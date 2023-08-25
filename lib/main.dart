import 'package:flutter/material.dart';
import 'package:notic_app/pages/add_note.dart';
import 'package:notic_app/pages/edite_page.dart';
import 'package:notic_app/pages/home_page.dart';


void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        AddNotesPage.addPageId : (context)=> AddNotesPage(),
        EditePage.ePageId :(context) => EditePage()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }

}
