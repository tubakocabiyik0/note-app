import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Model/category.dart';
import 'package:notes_app/Model/notes.dart';
import 'package:notes_app/utils/db_helper.dart';

class NoteAddPAge extends StatefulWidget {
  String barTitle;
  Notes notes;
  List noteList;

  NoteAddPAge({this.barTitle, this.notes, this.noteList});

  @override
  State<StatefulWidget> createState() {
    return StateAdd();
  }
}

class StateAdd extends State<NoteAddPAge> {
  var keyScaff = GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Category> categories;
  int categoryId;
  int priority;
  var getTitle = TextEditingController();
  var getDesc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = new List<Category>();
    databaseHelper.getAllCategory().then((value) {
      for (Map category in value) {
        categories.add(Category.fromMap(category));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaff,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        title: Text(
          widget.barTitle,
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.add_to_photos_rounded,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "Categories :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: categoryId,
                  items: getlist(),
                  onChanged: (value) {
                    setState(() {
                      categoryId = value;
                    });
                  },
                ),
              ),
            ],
          ),
          textformFields(),
          priorityDrop(),
          buttons()
        ],
      ),
    );
  }

  List<DropdownMenuItem> getlist() {
    return categories
        .map((e) => DropdownMenuItem<int>(
              value: e.categoryId,
              child: Text(e.categoryName),
            ))
        .toList();
  }

  textformFields() {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: getTitle,
              decoration: InputDecoration(
                hintText: "title",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: getDesc,
              maxLines: 5,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "description",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade300)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  priorityDrop() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(
            "Priority :",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        DropdownButton(
            value: priority,
            items: priorityList(),
            onChanged: (value) {
              setState(() {
                priority = value;
              });
            }),
      ],
    );
  }

  List<DropdownMenuItem> priorityList() {
    List<DropdownMenuItem> list = new List();
    for (int i = 1; i < 4; i++) {
      list.add(DropdownMenuItem(
        child: Text("$i"),
        value: i,
      ));
    }
    return list;
  }

  buttons() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: RaisedButton(
        onPressed: () {
          if (widget.barTitle == "Add new note") {
            databaseHelper
                .addNote(Notes(getTitle.text, getDesc.text,
                    DateTime.now().toString(), priority.toString(), categoryId))
                .then((dataId) {
              if (dataId > 0) {
                keyScaff.currentState
                    .showSnackBar(SnackBar(content: Text("note added")));
                Navigator.pop(context);
              }
            });
          } else {
            databaseHelper
                .updateNote(Notes.getId(
                    widget.notes.notesId,
                    getTitle.text,
                    getDesc.text,
                    DateTime.now().toString(),
                    priority.toString(),
                    categoryId))
                .then((value) {
              keyScaff.currentState
                  .showSnackBar(SnackBar(content: Text("note updated")));
              Navigator.pop(context);
            });
          }
        },
        color: Colors.orange.shade100,
        child: Text("save"),
      ),
    );
  }
}
