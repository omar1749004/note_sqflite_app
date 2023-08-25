import 'package:flutter/material.dart';
import 'package:notic_app/pages/add_note.dart';
import 'package:notic_app/pages/edite_page.dart';
import 'package:notic_app/services/sqldb.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqldb = SqlDb();
  bool isloading = false;
  Stream<List<Map<String, dynamic>>> readDat() {
    return Stream.fromFuture(sqldb.read("notec"));
    //return Stream.fromFuture(sqldb.readData("SELECT * FROM notec "));
  }

  void initState() {
    readDat();

    super.initState();
  }

  String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.pushNamed(context, AddNotesPage.addPageId);
            setState(() {});
          },
        ),
        appBar: AppBar(),
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<List<Map<String, dynamic>>>(
                stream: readDat(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) { 
                    List<Map<String, dynamic>> notes = [] ;  //snapshot.data!;
                    for(int i =0;i<snapshot.data!.length;i++)
                       {   isloading=true;
                          notes.add(snapshot.data![i]);
                           isloading=false;
                       }
                    return ListView.builder(
                        itemCount: notes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, itemcount) {
                          return Card(
                            child: ListTile(
                              title: Text(notes[itemcount]['title']),
                              subtitle: Text(notes[itemcount]['notic']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      isloading =true;
                                      int response = await sqldb.delete(
                                        "notec", "id = ${notes[itemcount]['id']}");
                                    //   int response = await sqldb.deleteData('''
                                    //  DELETE FROM notec WHERE id = ${notes[itemcount]['id']}
                                    //  ''');
                                      if (response > 0) {
                                        isloading =false;
                                        setState(() {
                                          notes.removeAt(itemcount);
                                         
                                        });
                                        
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: ()async {
                                      await Navigator.pushNamed(
                                        context, EditePage.ePageId , arguments: notes[itemcount]['id'])  ;
                                        setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }else{
                    return Container();
                  }
                }));
  }
}

// Column(
//           children: [
//             MaterialButton(onPressed: ()async{
               
//               int response = await sqldb.insertData(
//                 "INSERT INTO notec (notic) VALUES ('$message') ");
//                 print(response);
//             },
//             color: Colors.red,
//             textColor: Colors.white,
//             child: Text("Insert data"),
      
//             ),
//             MaterialButton(onPressed: ()async{
//                List<Map<String,dynamic>> response = await sqldb.readData(
//                 "SELECT * FROM notec ");
                
//               print(response);
//             },
//             color: Colors.red,
//             textColor: Colors.white,
//             child: Text("read data"),
//             ),
//             MaterialButton(onPressed: ()async{
//                int response = await sqldb.delete(
//                 "DELETE FROM notec WHERE id = 3");
                
//               print(response);
//             },
//             color: Colors.red,
//             textColor: Colors.white,
//             child: Text("delete data"),
//             ),
//             MaterialButton(onPressed: ()async{
//                int response = await sqldb.update(
//                 "UPDATE notec SET notic = 'update note 2' WHERE id = 2");
                
//               print(response);
//             },
//             color: Colors.red,
//             textColor: Colors.white,
//             child: Text("update data"),
//             ),
//           ],
//         ),