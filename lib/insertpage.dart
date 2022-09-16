import 'package:notes/main.dart';
import 'package:notes/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController ititle = TextEditingController();
  TextEditingController inote = TextEditingController();

  Database? db;

  @override
  initState() {
    super.initState();
    DbHelper dbhelper = DbHelper();
    dbhelper.createfolder().then((value) {
      db = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: TextField(
                controller: ititle,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: inote,
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (ititle != '') {
                String qry =
                    'INSERT INTO Notes(title,note) VALUES("${ititle.text}","${inote.text}")';
                int i = await db!.rawInsert(qry);
                print('Rawinseertt=${i}');
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewPage();
                  },
                ));
              }
              ;
            },
            child: Text('save'),
          )
        ],
      ),
    );
  }
}
