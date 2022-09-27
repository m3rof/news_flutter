import 'package:flutter/material.dart';
import 'package:newsapi2/presentation/home/HomeView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/news_state.dart';

class HomeView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionArgu args =
        ModalRoute.of(context)!.settings.arguments as CollectionArgu;
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 32, 58, .8),
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 18,
          ),
          Text(
              'author: ${args.successState.successResponse!.articles[args.index].author}',
              style: TextStyle(fontSize: 18, color: Colors.white)),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
                'title: ${args.successState.successResponse!.articles[args.index].title}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          SizedBox(
            height: 5,
          ),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: args.successState.successResponse!.articles[args.index]
                          .urlToImage !=
                      null
                  ? Image.network(
                      '${args.successState.successResponse!.articles[args.index].urlToImage}')
                  : Image.asset('assets/about.png')),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Text(
                'description: ${args.successState.successResponse!.articles[args.index].description}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Text(
                'content: ${args.successState.successResponse!.articles[args.index].content}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(left: 3),
              child: Text(
                  'publishedAt: ${args.successState.successResponse!.articles[args.index].publishedAt}',
                  style: TextStyle(fontSize: 18, color: Colors.white))),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.cyan[600]),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18.0)))),
                    onPressed: ()async{
                      String url = args.successState.successResponse!.articles[args.index].url;
                      launch(url);
                    },
                    child: Text('open in browser'))),
          ],
        )

        ],
      ),
    );
  }
}
