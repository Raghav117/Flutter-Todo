import 'package:flutter/material.dart';
import 'package:to_do/screens/complete.dart';
import 'package:to_do/screens/home.dart';
import 'package:to_do/screens/uncomplete.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO Do",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tcontroller;

  @override
  void initState() {
    _tcontroller = TabController(length: 3, initialIndex: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tcontroller,
            tabs: <Widget>[
              Tab(
                child: Icon(Icons.sentiment_very_satisfied),
              ),
              Tab(
                child: Icon(Icons.home),
              ),
              Tab(
                child: Icon(Icons.sentiment_dissatisfied),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          controller: _tcontroller,
          children: <Widget>[Complete(), Home(), UnComplete()],
        ),
      ),
    );
  }
}
