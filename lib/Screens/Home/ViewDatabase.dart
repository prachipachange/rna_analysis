import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rna_analysis/Screens/Home/DataScreen.dart';

class ViewDatabase extends StatefulWidget {
  @override
  _ViewDatabaseState createState() => _ViewDatabaseState();
}

class _ViewDatabaseState extends State<ViewDatabase> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          width: double.maxFinite,
          color: Colors.green,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("data").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List documents = snapshot.data.docs;
                  List<DatabaseTab> data = documents
                      .map((e) => DatabaseTab(
                            title: e["title"].toString(),
                            bp: e["bp"].toString(),
                            author: e["author"].toString(),
                            id: e["id"].toString(),
                            onTap: (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DataScreen(
                                            id: value,
                                          )));
                            },
                          ))
                      .toList();
                  return ListView(
                    children: data,
                  );
                } else {
                  return Text("No Internet");
                }
              }),
        ),
      ],
    );
  }
}

typedef void IDCallBack(String id);

class DatabaseTab extends StatelessWidget {
  final String title;
  final String bp;
  final String id;
  final String author;
  final IDCallBack onTap;
  DatabaseTab({
    Key key,
    this.title,
    this.bp,
    this.id,
    this.author,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(id);
      },
      child: Container(
        height: 100,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Material(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "id : " + id,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bp + " BP",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "Author : " + author,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
