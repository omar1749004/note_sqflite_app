import 'package:flutter/material.dart';

import '../services/sqldb.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});
  static String addPageId = "addnotespage";
  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  SqlDb sqldb = SqlDb();

  GlobalKey<FormState> formStat = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Notes"),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formStat,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: "title"),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "note"),
                  ),
                  
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(hintText: "color"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                         int response = await sqldb.insert("notec" ,
                         { 
                          "notic" : note.text ,
                          "title" : title.text,
                          "color" : color.text
                         } 
                         );

                    //     int response = await sqldb.insertData('''
                    //  INSERT INTO notec (`notic` , `title`, `color`)
                    //     VALUES ("${note.text}" ," ${title.text}" , "${color.text}") 
                    //         ''');
                            
                       if(response>0)
                       {
                        Navigator.pop(context,true);
                       }
                      } catch (e) {
                       print(e);
                      }
                    },
                    child: Text("Add note"),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
