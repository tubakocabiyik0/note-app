import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       routes: {
         '/HomePage':(contex)=>HomePage(),
       },
      initialRoute: '/HomePage',

    );
}
}
