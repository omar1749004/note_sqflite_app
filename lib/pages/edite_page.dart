
import 'package:flutter/material.dart';

import '../services/sqldb.dart';


class EditePage extends StatelessWidget { 
  
  static String ePageId ="editePage";
  SqlDb sqldb = SqlDb();
 
  GlobalKey<FormState> formStat = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();
  
   EditePage();

  @override
  Widget build(BuildContext context) {
     String stringid = ModalRoute.of(context)!.settings.arguments.toString();
     int id = int.parse(stringid);
    return Scaffold(
        appBar: AppBar(
          title: Text("Edite Notes"),
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
                          
                          int response = await sqldb.update("notec", 
                          { 
                          "notic" : note.text ,
                          "title" : title.text,
                          "color" : color.text
                         } , "id =  $id");
                        // int response = await sqldb.updateData('''
                        // UPDATE notec SET
                        //  notic = '${note.text}' ,
                        // title = '${title.text}' ,
                        //  color = '${title.text}'
                        //   WHERE id = '${id}'
                        //     ''');
                            
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