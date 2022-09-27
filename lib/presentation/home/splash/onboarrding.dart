import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:newsapi2/presentation/home/HomeView.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage
      ({ Key? key }) : super(key: key);


  final List<PageViewModel> pages = [
    PageViewModel(
        title: 'first page',
        body: 'Always update with the lastest happenings in the world',
        image: Center(
          child: Image.asset('assets/img.jpeg'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
            TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: 'second page',
        body: 'it allows you to learn about all kinds of news that comes to your mind',
        image: Center(
          child: Image.asset('assets/img1.jpeg'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: 'third page',
        body: 'We seek to arrive all the news to you',
        image: Center(
          child: Image.asset('assets/img1.jpeg'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan[600],
          title: const Text('our vission'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: IntroductionScreen (
            pages: pages,
            dotsDecorator: const DotsDecorator(
                size: Size(10, 10),
                color: Colors.blue,
                activeColor: Colors.red,
                activeSize: Size.square(20)),
            showDoneButton: true,
            done: const Text(
              "done",
              style: TextStyle(fontSize: 20),
            ),
            showNextButton: true,
            next: const Text(
              "next",
              style: TextStyle(fontSize: 20),
            ),
            showSkipButton: true,
            skip: const Text(
              "skip",
              style: TextStyle(fontSize: 20),
            ),
            onDone: () => ondone(context),
          ),
        ));
  }
}

ondone(context) {
  Navigator.pushNamed(context, 'one');
}