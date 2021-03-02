import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_app/Model/category.dart';
import 'package:notes_app/pages/notadd_page.dart';
import 'package:notes_app/utils/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateHome();
  }
}

class StateHome extends State<HomePage> {
  var ScaffKey = GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  var text = TextEditingController();
  List categories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = new List<Category>();
    databaseHelper.getAllCategory().then((value) {
      for(Map getCategory in value ){
        categories.add(Category.fromMap(getCategory));
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    databaseHelper.getAllCategory();
    var btn1;
    var btn2;
    return Scaffold(
      key: ScaffKey,
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
            heroTag: btn2,
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
                                  onPressed: () {
                                    categoryAdd(Category(text.text));
                                    Navigator.pop(context);
                                  },
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
            heroTag: btn1,
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>NoteAddPAge("Add new note")));
            },
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

  void categoryAdd(Category category) async {
    var addedCategory = await databaseHelper.addCategory(category);

    if (addedCategory > 0) {
      ScaffKey.currentState.showSnackBar(SnackBar(
        content: Text("category added"),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        categories.insert(0, Category.withID(text.text, addedCategory));
      });

    }
  }
}
