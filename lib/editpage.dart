import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/main.dart';
import 'package:notes/model.dart';
import 'package:notes/insertpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class EditPage extends StatefulWidget {
  EditPage(
      {Key? key, required this.cid, required this.title, required this.note})
      : super(key: key);
  final String title;
  final String note;
  final int cid;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController etitle = TextEditingController();
  TextEditingController enote = TextEditingController();

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
    int CID = widget.cid;
    String Title = widget.title;
    String Note = widget.note;
    etitle.text = Title;
    enote.text = Note;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Column(
        children: [
          Card(
            child: TextField(
              controller: etitle,
              decoration: InputDecoration(
                label: Text('title'),
              ),
            ),
          ),
          Card(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: enote,
              decoration: InputDecoration(label: Text('note')),
            ),
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    String Esql =
                        "Update notes set title = '${etitle.text}', note = '${enote.text}' where id= $CID";
                    int i = await db!.rawUpdate(Esql);
                    print('RawEdit=${i}');
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ViewPage();
                      },
                    ));
                  },
                  child: Text('save'))),
        ],
      ),
    );
  }
}
