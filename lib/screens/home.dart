import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.075),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(padding: EdgeInsets.only(top: deviceSize.height * .024), child: Text("Let's eat!", style: Theme.of(context).primaryTextTheme.titleLarge)),
        ],)
      )
    );
  }
}