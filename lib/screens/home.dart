import 'package:flutter/material.dart';
import 'package:to_do/models/tiles.dart';

import 'add_task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tile> tile = <Tile>[
    Tile("Raghav", 0),

    Tile("Raghav", 1),
    Tile("Raghav", 2),
    Tile("Raghav", 3),
    Tile("Raghav", 4),
    Tile("Raghav", 5),
    Tile("Raghav", 6),
    Tile("Raghav", 7),
    Tile("Raghav", 8),
    Tile("Raghav", 7),
    Tile("Raghav", 8),
    Tile("Raghav", 7),
    Tile("Raghav Garg 8", 8),
    Tile("Raghav Garg", 7),
    Tile("Raghav Garg 6", 8),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: height / 7),
            child: ReorderableListView(
              padding: EdgeInsets.only(top: 50),
              children: List.generate(tile.length, (index) {
                return Padding(
                  key: ValueKey("value$index"),
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    height: 100.0,
                    width: width,
                    child: ListTile(
                      title: Text(
                        tile[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.radio_button_checked,color: Color(0xFFFFD700),),
                        onPressed: (){},
                        
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.check_circle_outline),
                        onPressed: (){},
                      ),
                      subtitle: Text(
                        tile[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: true,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red),
                  ),
                );
              }),

              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  _updateMyItems(oldIndex, newIndex);
                });
              },
            ),
          ),
          Container(
            width: width,
            height: height / 6,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 60.0, top: 30),
              child: Text(
                "Intray",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.68),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context)=> Add(),
                ));
              },
              splashColor: Colors.transparent,
                          child: Container(
                width: 50.0,
                height: 50.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Tile item = tile.removeAt(oldIndex);
    tile.insert(newIndex, item);
  }
}
