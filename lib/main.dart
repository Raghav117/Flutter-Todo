import 'package:flutter/material.dart';
import 'package:to_do/screens/home.dart';

void main() => runApp(MaterialApp(
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
    _tcontroller = TabController(length: 3, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                child: Icon(Icons.home),
              ),
              Tab(
                child: Icon(Icons.compare),
              ),
              Tab(
                child: Icon(Icons.accessibility),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          controller: _tcontroller,
          children: <Widget>[
            Home(),
            Container(
              height: height,
              width: width,
              color: Colors.green,
            ),
            Container(
              height: height / 4,
              width: width,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

// PreferredSize(
//             preferredSize: Size(width, height / 3.5),
//             child: Stack(
//               children: <Widget>[
                  // child: Align(
//                     alignment: Alignment.topCenter,
//                     child:
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment(0, 1),
//                   child: Container(
//                     width: 50.0,
//                     height: 50.0,
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 50.0,
//                     ),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.red),
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment(-0.75, 0),
//                     child: Text(
//                       "Intray",
//                       style: TextStyle(
//                           fontSize: 40.0, fontWeight: FontWeight.bold),
//                     ))
//               ],
//             )),
