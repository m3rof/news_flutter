
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:newsapi2/datasource/login/login_screen.dart';
import 'package:newsapi2/datasource/register/register_screen.dart';
import 'package:newsapi2/presentation/home/HomeView.dart';
import 'package:newsapi2/presentation/home/Homeview2.dart';
import 'package:newsapi2/presentation/home/account.dart';
import 'package:newsapi2/presentation/home/bloc/news_bloc.dart';
import 'package:newsapi2/presentation/home/bloc/news_state.dart';
import 'package:newsapi2/presentation/home/chat.dart';
import 'package:newsapi2/repository/UserProvider.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import 'home/splash/onboarrding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(ChangeNotifierProvider<UserProvider>(create: (context) =>UserProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false,
      // home:BlocProvider<NewsBloc>(create:(context) => NewsBloc(LoadingState()),child:HomeView()) ,
      routes: {
      'one':(context)=>BlocProvider<NewsBloc>(create:(context) => NewsBloc(LoadingState()),child:HomeView()),
        'two':(context) => HomeView2(),
        'three':(context)=>MyHomePage(),
        'four':(context)=>RegisterScreen(),
        'five':(context)=>LoginScreen(),
        'six':(context)=>account(),
        'seven':(context)=>chat(),
      },
      initialRoute: 'five',
  ),
    ));
}
