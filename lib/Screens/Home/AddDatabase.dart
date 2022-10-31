import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rna_analysis/Provider/Provider.dart';

class AddDatabase extends StatefulWidget {
  @override
  _AddDatabaseState createState() => _AddDatabaseState();
}

class _AddDatabaseState extends State<AddDatabase> {
  User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  double _topMargin;
  bool focusOntextField, titleError, sequenceError;
  FocusNode _titleFocus = FocusNode();
  FocusNode _sequenceFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController sequenceController = TextEditingController();

  String userName = FirebaseAuth.instance.currentUser.displayName;
  int entriesCount = 234, contributedByYou = 2;

  String titleName = "",
      sequence = "",
      titleErrorText = "",
      sequenceErrorText = "";

  @override
  void initState() {
    focusOntextField = false;
    // TODO: implement initState
    super.initState();
    _titleFocus.addListener(focusChanged);
    _sequenceFocus.addListener(focusChanged);
    titleError = false;
    sequenceError = false;
  }

  void focusChanged() {
    setState(() {
      focusOntextField ? focusOntextField = false : focusOntextField = true;
    });
  }

  bool validateRNASequence(String seq) {
    if (seq.isNotEmpty) {
      if (seq.contains(RegExp(r'[^AUGC]'))) {
        setState(() {
          sequenceError = true;
          sequenceErrorText = "Invalid Sequence";
          return false;
        });
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    focusOntextField ? _topMargin = 50 : _topMargin = 300;

    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          color: Colors.green,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hello " + userName + " !",
                style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                      stream: firestore.collection('data').snapshots(),
                      builder: (context, snapshot) {
                        QuerySnapshot q = snapshot.data;
                        return Text(
                          q.docs.length.toString(),
                          style: GoogleFonts.playfairDisplaySc(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.w500),
                        );
                      }),
                  Text(
                    "Entries added yet",
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ],
          ),
          height: 500,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.decelerate,
          height: focusOntextField ? 700 : 450,
          margin:
              EdgeInsets.only(left: 10, right: 10, top: _topMargin, bottom: 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add New Sequence",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      focusNode: _titleFocus,
                      onChanged: (value) {
                        setState(() {
                          titleError = false;
                          focusOntextField = true;
                          titleName = value;
                        });
                      },
                      maxLines: null,
                      controller: titleController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        errorText: titleError ? titleErrorText : null,
                        labelText: "Title of Sequence",
                        labelStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 3,
                                style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      maxLines: null,
                      focusNode: _sequenceFocus,
                      onChanged: (value) {
                        setState(() {
                          sequenceError = false;
                          focusOntextField = true;
                          sequence = value;
                        });
                      },
                      textCapitalization: TextCapitalization.characters,
                      controller: sequenceController,
                      decoration: InputDecoration(
                        errorText: sequenceError ? sequenceErrorText : null,
                        labelText: "Enter the RNA Sequence",
                        labelStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 3,
                                style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                    child: RawMaterialButton(
                      onPressed: () {
                        Provider.of<ProviderModifier>(context, listen: false)
                            .updateSpinner(true);
                        _titleFocus.unfocus();
                        _sequenceFocus.unfocus();

                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy-MM-dd');
                        String formattedDate = formatter.format(now);

                        if (titleName.isNotEmpty) {
                          if (sequence.isNotEmpty) {
                            if (validateRNASequence(sequence)) {
                              setState(() {
                                int bp = sequence.length;
                                var now = new DateTime.now();
                                var idnow =
                                    new DateTime.now().millisecondsSinceEpoch;
                                var formatter = new DateFormat('yyyy-MM-dd');
                                String formattedDate = formatter.format(now);

                                //Command to add the sequence to firebase firestore database

                                firestore
                                    .collection("data")
                                    .doc(idnow.toString())
                                    .set({
                                  "title": titleName,
                                  "fasta": sequence,
                                  "author": FirebaseAuth
                                      .instance.currentUser.displayName,
                                  "date": formattedDate,
                                  "id": idnow.toString(),
                                  "bp": bp
                                }).whenComplete(() async {
                                  Provider.of<ProviderModifier>(context,
                                          listen: false)
                                      .updateSpinner(false);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(titleName +
                                              " added Successfully")));
                                });
                                titleController.clear();
                                sequenceController.clear();
                              });
                            }
                          } else {
                            setState(() {
                              sequenceError = true;
                              sequenceErrorText = "Not given any RNA sequence";
                            });
                          }
                        } else {
                          setState(() {
                            titleError = true;
                            titleErrorText = "Not given any title";
                            if (sequence.isEmpty) {
                              sequenceError = true;
                              sequenceErrorText = "Not given any RNA sequence";
                            }
                          });
                        }
                      },
                      elevation: 4,
                      shape: StadiumBorder(),
                      fillColor: Colors.green,
                      child: Text(
                        "Add to database",
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Provider.of<ProviderModifier>(context, listen: true).spinner
            ? Center(
                child: SpinKitFadingCircle(
                  color: Colors.green,
                  size: 80.0,
                ),
              )
            : SizedBox(
                height: 1,
              ),
      ],
    );
  }
}
