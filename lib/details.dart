import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/editpage.dart';
import 'package:notes/main.dart';
import 'package:notes/model.dart';
import 'package:notes/insertpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Details extends StatelessWidget {
  Details(
      {Key? key, required this.cid, required this.title, required this.note})
      : super(key: key);
  final String title;
  final String note;
  final int cid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Text(
            note,
            textScaleFactor: 1.5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return EditPage(cid: cid, title: title, note: note);
          }));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
