import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_app/utils/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateHome();
  }
}

class StateHome extends State<HomePage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  TextEditingController text;

  @override
  Widget build(BuildContext context) {
    databaseHelper.getAllCategory();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        title: Text(
          "My Notes",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.library_books_outlined,
          color: Colors.black,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                        title: Text("Add Category"),
                        children: [
                          Form(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: text,
                                    cursorColor: Colors.orange.shade300,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orange.shade300)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orange.shade300)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orange.shade300)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
                                      labelText: "Category Name",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: Colors.orange.shade100,
                                  child: Text("add"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
            },
            mini: true,
            tooltip: "new category",
            elevation: 0,
            backgroundColor: Colors.orange.shade200,
            child: Icon(
              Icons.category,
              color: Colors.black,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            elevation: 0,
            tooltip: "new note",
            backgroundColor: Colors.orange.shade200,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
