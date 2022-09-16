import 'package:notes/details.dart';
import 'package:notes/editpage.dart';
import 'package:notes/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'insertpage.dart';

void main() {
  runApp(MaterialApp(
    home: ViewPage(),
  ));
}

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  initState() {
    super.initState();
    get();
    setState(() {});
  }

  Database? db;
  List<Map> list = [];

  get() {
    DbHelper dbhelper = DbHelper();
    dbhelper.createfolder().then((value) async {
      db = value;
      String qry = 'SELECT * FROM Notes';
      list = await db!.rawQuery(qry);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('viewpage'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            Map map = list[index];
            return ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return EditPage(
                            cid: map['id'],
                            title: map['title'],
                            note: map['note']);
                      },
                    ));
                  },
                  icon: Icon(Icons.edit)),
              trailing: IconButton(
                onPressed: () async {
                  int cid = map['id'];
                  print(cid);
                  String dsql = "Delete from Notes where id='$cid'";
                  int i = await db!.rawDelete(dsql);
                  print('Rawdelete=${i}');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
                icon: Icon(Icons.delete),
              ),
              title: Text('${map['title']}'),
              subtitle: SizedBox(
                  width: double.infinity,
                  height: 17,
                  child: Text('${map['note']}')),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Details(
                        cid: map['id'], title: map['title'], note: map['note']);
                  },
                ));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
