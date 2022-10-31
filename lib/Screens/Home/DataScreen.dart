import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  final String id;

  DataScreen({Key key, this.id}) : super(key: key);

  String title = "";
  String author = "";
  String date = "";
  int bp = 0;
  String sequence = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('data')
        .where('id', isEqualTo: id)
        .snapshots()
        .listen((data) {});
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .where('id', isEqualTo: id)
            .snapshots(),
        builder: (context, snapshot) {
          QuerySnapshot data = snapshot.data;
          title = data.docs[0]['title'].toString();
          author = data.docs[0]['author'].toString();
          bp = data.docs[0]['bp'];
          date = data.docs[0]['date'];
          sequence = data.docs[0]['fasta'];
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              brightness: Brightness.dark,
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Text(
                      "Id : " + id,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Author : " + author,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Date of submission : " + date,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "FASTA",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SelectableText(
                      sequence,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.green),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "" + bp.toString() + " BP",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          );
        });
  }
}
