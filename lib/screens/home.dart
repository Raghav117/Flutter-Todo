
import 'package:flutter/material.dart';
import 'package:to_do/models/database.dart';
import 'package:to_do/models/tiles.dart';
import 'add_task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
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
              child: FutureBuilder(
                future: DBProvider.db.display(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0)
                      return ReorderableListView(
                        padding: EdgeInsets.only(top: 50),
                        children: List.generate(snapshot.data.length, (index) {
                          Tile t = snapshot.data[index];
                          print(t.id);
                          return Padding(
                            key: ValueKey("value$index"),
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: Container(
                              height: 100.0,
                              width: width,
                              child: ListTile(
                                onLongPress: (){
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text("data"),
                                        ),
                                        RaisedButton(
                                          child: Text("data"),

                                        ),
                                        RaisedButton(
                                          child: Text("data"),

                                        ),
                                      ],
                                    )
                                  );
                                },
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return Add(
                                        description: t.description,
                                        image: t.image,
                                        priority: t.priority,
                                        title: t.title,
                                        s: false,
                                        id: t.id,
                                        completed: t.completed,
                                      );
                                    }
                                  ));
                                },
                                title: Text(
                                  t.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                                    DBProvider.db.update(t);
                                    setState(() {
                                    });
                                  },
                                ),
                                trailing:
                                    IconButton(
                                      icon: Icon(Icons.check_circle_outline),
                                      color: t.completed
                                        ? Color(0xFFFFD700)
                                        : Colors.black,
                                  onPressed: () {
                                    t.completed = !t.completed;
                                    DBProvider.db.update(t);
                                    setState(() {
                                    });
                                  },
                                    ),
                                    
                                    // t.image != "null"
                                    //     ? Image.file(File(t.image),
                                    //         fit: BoxFit.fitHeight)
                                    //     : Container(),
                                  
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
                        onReorder: (int oldIndex, int newIndex) {
                          print("Old $oldIndex");
                          print("New $newIndex");
                          setState(() {
                            _updateMyItems(oldIndex, newIndex);
                          });
                        },
                      );
                    else
                      return Center(
                          child: Text(
                        "Add to insert your task",
                        style: TextStyle(color: Colors.white),
                      ));
                  } else
                    return Center(
                        child: Text(
                      "Add to insert your task",
                      style: TextStyle(color: Colors.white),
                    ));
                },
              )),
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
                    id: 0,
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
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

}
}