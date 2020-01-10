import 'package:flutter/material.dart';
import 'package:to_do/models/database.dart';
import 'package:to_do/models/tiles.dart';

class UnComplete extends StatefulWidget {
  @override
  _UnCompleteState createState() => _UnCompleteState();
}

class _UnCompleteState extends State<UnComplete> {
  List<Tile> tiles;

  @override
  void initState() {
    print("init");
    getList();

    super.initState();
  }

  getList() async {
    tiles = await DBProvider.db.displayUncompleted();
    print(tiles);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        //! For card
        Container(
          width: width,
          height: height / 6,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.0),
                bottomRight: Radius.circular(60.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 30),
            child: Text(
              "Incomplete Task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
        ),

        //! For Incompleted List

        Padding(
          padding: EdgeInsets.only(top: height / 7),
          child: tiles != null
              ? (tiles.length != 0
                  ? ListView(
                      padding: EdgeInsets.only(top: 50),
                      children: List.generate(tiles.length, (index) {
                        Tile t = tiles[index];
                        print(t.id);
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: Container(
                            height: 100.0,
                            width: width,
                            child: ListTile(
                              title: Text(
                                t.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              leading: Icon(
                                Icons.radio_button_checked,
                                color: t.priority
                                    ? Color(0xFFFFD700)
                                    : Colors.black,
                              ),
                              subtitle: Text(
                                t.description,
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
                    )
                  : Center(
                      child: Text(
                        "No task to finish...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
        ),
      ],
    );
  }
}
