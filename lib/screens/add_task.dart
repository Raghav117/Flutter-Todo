import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do/models/bloc.dart';
import 'package:to_do/models/tiles.dart';

class Add extends StatefulWidget {
  final String image;
  final String title, description;
  final bool priority;
  final bool s;
  final int id;
  final bool completed;

  Add(
      {Key key,
      this.image,
      this.title,
      this.description,
      this.priority,
      this.s,
      this.id,
      this.completed});

  @override
  _AddState createState() => _AddState(this.image, this.title, this.description,
      this.priority, this.s, this.id, this.completed);
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final bool s;
  final int id;

  String image;
  String title, description;
  bool priority;
  File _image;

  final bool completed;
  @override
  void initState() {
    super.initState();
    if (image != "null") _image = File(image);
  }

  int c;

  TextStyle _t = TextStyle(color: Colors.red);

  _AddState(this.image, this.title, this.description, this.priority, this.s,
      this.id, this.completed);

  Future getImage(int c) async {
    var image = c == 1
        ? await ImagePicker.pickImage(source: ImageSource.camera)
        : await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("Add a task"),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                child: Theme(
              data: ThemeData(
                primaryColor: Colors.red,
                canvasColor: Colors.red,
              ),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        //!  For Title
                        Text("Title"),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 40.0, left: 10.0, right: 10.0),
                          child: TextFormField(
                            initialValue: title,
                            onChanged: (value) {
                              title = value;
                            },
                            onSaved: (value) {
                              title = value;
                            },
                            onFieldSubmitted: (value) {
                              title = value;
                            },
                            validator: (title) {
                              if (title == null || title.length == 0)
                                return 'Title can not be empty';
                              return null;
                            },
                            cursorColor: Colors.red,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                        ),
                        //!  For Description
                        Text("Description"),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 40.0, left: 10.0, right: 10.0),
                          child: TextFormField(
                            initialValue: description,
                            onChanged: (value) {
                              description = value;
                            },
                            onSaved: (value) {
                              description = value;
                            },
                            onFieldSubmitted: (value) {
                              description = value;
                            },
                            cursorColor: Colors.red,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                        ),
                        //! Add a image
                        Text("Image"),

                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text("Image"),
                                    actions: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          FlatButton(
                                              child: Text(
                                                "From Camera",
                                                style: _t,
                                              ),
                                              onPressed: () async {
                                                await getImage(1);
                                                Navigator.of(context).pop();
                                              }),
                                          FlatButton(
                                              child: Text(
                                                "From Gallery",
                                                style: _t,
                                              ),
                                              onPressed: () async {
                                                await getImage(2);
                                                Navigator.of(context).pop();
                                              }),
                                          FlatButton(
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _image = null;
                                                });
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: height / 4,
                            width: height / 4,
                            color: Colors.grey,
                            child: _image == null
                                ? Icon(Icons.add_a_photo)
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),

                        //! Priority
                        SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Priority --> "),
                            IconButton(
                              icon: Icon(
                                Icons.radio_button_checked,
                                color: priority ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                priority = !priority;
                                setState(() {});
                              },
                            ),
                          ],
                        ),

                        //! Pressed OK
                        SizedBox(
                          height: 20.0,
                        ),

                        RaisedButton(
                          child: s
                              ? Text("Save",
                                  style: TextStyle(color: Colors.white))
                              : Text("Update",
                                  style: TextStyle(color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.red,
                          onPressed: () {
                            if (this._formKey.currentState.validate()) {
                              setState(() {
                                this._formKey.currentState.save();
                                // print("Save $_image");
                                if (s) {
                                  TileBloc().add(Tile.withId(
                                      description: description,
                                      title: title,
                                      id: id,
                                      image: _image != null
                                          ? "//" +
                                              _image.toString().substring(7,
                                                  _image.toString().length - 1)
                                          : "null",
                                      priority: priority,
                                      completed: false));
                                } else {
                                  var result = TileBloc().update(Tile.withId(
                                      title: title,
                                      description: description,
                                      id: id,
                                      image: _image != null
                                          ? "//" +
                                              _image.toString().substring(7,
                                                  _image.toString().length - 1)
                                          : "null",
                                      priority: priority,
                                      completed: completed));

                                  print(result);
                                }
                              });
                              Navigator.of(context).pop();
                            }
                          },
                        )
                      ],
                    )),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
