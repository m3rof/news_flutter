import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:newsapi2/datasource/login/login_screen.dart';
import 'package:newsapi2/presentation/home/Homeview2.dart';
import 'package:newsapi2/presentation/home/bloc/news_bloc.dart';
import 'package:newsapi2/presentation/home/bloc/news_event.dart';
import 'package:newsapi2/presentation/home/bloc/news_state.dart';
import 'package:newsapi2/repository/UserProvider.dart';
import 'package:newsapi2/utils/FireBase_utils.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  int? heart;
  FirebaseAuth user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(FetchNews());
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 32, 58, .8),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.cyan[600],
            title: Text(
              'News',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
        body: SafeArea(
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is SuccessState) {
                SuccessState successState = state as SuccessState;
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade700,
                      height: 1,
                    ),
                    itemCount: successState.successResponse!.articles.length,
                    itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'two',
                              arguments: CollectionArgu(successState, index));
                        },
                        title: successState.successResponse!.articles[index]
                                    .urlToImage ==
                                null
                            ? Image.asset('assets/about.png')
                            : Container(
                                margin: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.network(
                                            '${successState.successResponse!.articles[index].urlToImage}'),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(left: 3),
                                          color: Colors.cyan[600],
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Text(
                                                successState.successResponse!
                                                    .articles[index].title,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                successState
                                                    .successResponse!
                                                    .articles[index]
                                                    .publishedAt,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        16, 32, 58, .8)),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              )),
                  ),
                );
              } else if (state is FailureState) {
                FailureState failureState = State as FailureState;
                return Text('${failureState.errorResponse!.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(top: 24, bottom: 24),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  FutureBuilder<MyUser?>(
                    future: DataBaseUtils.readUser('${user.currentUser?.uid}'),
                    builder: (context, snapshot) {
                      final user = snapshot.data;
                      if (snapshot.hasData) {
                        return Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.cyan[600],
                            radius: 30,
                            child: Text('${user?.userName?.substring(0,1).toUpperCase()}'),
                          ),SizedBox(height:5),Text(
                            '${user?.email}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),SizedBox(height: 5,),
                         Text('${user?.userName}',style: TextStyle(color: Colors.white, fontSize: 18),),
                        ],);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home', style: TextStyle(fontSize: 18)),
            selected: index == 1 ? true : false,
            selectedColor: Colors.blue,
            onTap: () {
              index = 1;
              Navigator.pushReplacementNamed(context, 'one');
              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('acount', style: TextStyle(fontSize: 18)),
            selected: index == 2 ? true : false,
            selectedColor: Colors.blue,
            onTap: () {
              index = 2;
              Navigator.pushReplacementNamed(context, 'six');
              setState(() {});
            },
          ),ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text(
              'chat',
              style: TextStyle(fontSize: 18),
            ),
            selected: index == 3 ? true : false,
            selectedColor: Colors.blue,
            onTap: () {
              index = 3;
              Navigator.pushNamed(context, 'seven');
              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.adb_outlined),
            title: Text(
              'about',
              style: TextStyle(fontSize: 18),
            ),
            selected: index == 4 ? true : false,
            selectedColor: Colors.blue,
            onTap: () {
              index = 3;
              Navigator.pushReplacementNamed(context, 'three');
              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.login_outlined),
            title: Text(
              'logout',
              style: TextStyle(fontSize: 18),
            ),
            selected: index == 5 ? true : false,
            selectedColor: Colors.blue,
            onTap: () async{
              index = 4;
             await FirebaseAuth.instance.signOut().whenComplete((){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen(),)
                   , (route) => false);
             });
              setState(() {});
            },
          ),
        ],
      )),
    );
  }
}

class CollectionArgu {
  SuccessState successState;
  int index;

  CollectionArgu(this.successState, this.index);
}
