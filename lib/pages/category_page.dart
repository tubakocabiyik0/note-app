import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return StateCategory();
  }

}
class StateCategory extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      backgroundColor: Colors.orange.shade300,
      title: Text("Category",style: TextStyle(color: Colors.black),),
      leading: Icon(Icons.category,color: Colors.black,),

    ),
    );

  }

}