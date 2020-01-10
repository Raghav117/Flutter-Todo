import 'package:flutter/material.dart';
import 'package:to_do/models/bloc.dart';
import 'package:to_do/models/database.dart';
import 'package:to_do/models/tiles.dart';
import 'add_task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tile> tiles;
  bool c;
  TileBloc bloc;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("init");
    bloc = TileBloc();
    bloc.getTile();

    c = true;
    getList();

    super.initState();
  }

  getList() async {
    await bloc.tiles.listen(
      (data) {
        tiles = data;
        setState(() {});
      },
      onDone: () {},
    );
  }

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
            child: tiles != null
                ? (tiles.length != 0
                    ? ReorderableListView(
                        padding: EdgeInsets.only(top: 50),
                        children: List.generate(tiles.length, (index) {
                          Tile t = tiles[index];
                          print(t.id);
                          return Dismissible(
                            key: ValueKey("value$index"),
                            onDismissed: (direction) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    content: Text("You really want to Delete",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    backgroundColor: Colors.white,
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          int i = index;
                                          for (i = t.id;
                                              i < tiles.length;
                                              ++i) {
                                            Tile t2 = tiles[i];
                                            t2.id = i;
                                            bloc.updateWithId(t2, i);
                                          }
                                          bloc.delete(tiles.length);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          }),
                                    ],
                                  ));
                            },
                            background: Container(
                              child: Icon(Icons.delete),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: Container(
                                height: 100.0,
                                width: width,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return Add(
                                        description: t.description,
                                        image: t.image,
                                        priority: t.priority,
                                        title: t.title,
                                        s: false,
                                        id: t.id,
                                        completed: t.completed,
                                      );
                                    }));
                                  },
                                  title: Text(
                                    t.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decoration: t.completed
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontSize: 20),
                                  ),
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.radio_button_checked,
                                      color: t.priority
                                          ? Color(0xFFFFD700)
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      t.priority = !t.priority;
                                      bloc.update(t);
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.check_circle_outline),
                                    color: t.completed
                                        ? Color(0xFFFFD700)
                                        : Colors.black,
                                    onPressed: () {
                                      t.completed = !t.completed;
                                      bloc.update(t);
                                    },
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
                            ),
                          );
                        }),
                        onReorder: (int oldIndex, int newIndex) {
                          print("Old $oldIndex");
                          print("New $newIndex");
                          setState(() {
                            _updateMyItems(oldIndex, newIndex);
                          });
                        },
                      )
                    : Center(
                        child: Text(
                          "Add to insert item",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
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
                "Your's Todo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.68),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Add(
                    title: "",
                    description: "",
                    image: "null",
                    priority: false,
                    s: true,
                    id: tiles.length + 1,
                    completed: false,
                  ),
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
    int i;

    if (oldIndex < newIndex) {
      --newIndex;
      Tile t2 = tiles[oldIndex];
      for (i = oldIndex + 1; i <= newIndex; ++i) {
        Tile t3 = tiles[i];
        t3.id = i;
        DBProvider.db.updateWithId(t3, i);
      }
      t2.id = i;
      bloc.updateWithId(t2, i);
    } else if (oldIndex > newIndex) {
      Tile t2 = tiles[oldIndex];
      for (i = oldIndex - 1; i >= newIndex; --i) {
        Tile t3 = tiles[i];
        ++t3.id;
        DBProvider.db.updateWithId(t3, i + 2);
      }
      t2.id = newIndex + 1;
      bloc.updateWithId(t2, newIndex + 1);
    }
  }
}
