import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  File _image;
  final _formKey = GlobalKey<FormState>();

  String title, description;

  int c;
  TextStyle _t = TextStyle(color: Colors.red);

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
    // var width = MediaQuery.of(context).size.width;
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
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),

                        //! Pressed OK
                        SizedBox(
                          height: 20.0,
                        ),

                        RaisedButton(
                          child: Text("Save",
                              style: TextStyle(color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.red,
                          onPressed: () {
                            if (this._formKey.currentState.validate()) {
                              setState(() {
                                this._formKey.currentState.save();
                                // print("Save $title");
                              });
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
