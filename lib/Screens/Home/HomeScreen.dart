import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rna_analysis/Screens/Home/AddDatabase.dart';
import 'package:rna_analysis/Screens/Home/ViewDatabase.dart';
import 'package:rna_analysis/Screens/Login/LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> menuChoices = <String>[
    'logout',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              color: Colors.white.withOpacity(0.9),
              onSelected: choicePopupMenu,
              itemBuilder: (BuildContext cn) {
                return menuChoices
                    .map((String choice) => PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        ))
                    .toList();
              },
            ),
          ],
          brightness: Brightness.dark,
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              tabs: [
                Tab(
                  child: Text("Add Database",
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text("RNA Database",
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        body: TabBarView(
          children: [
            AddDatabase(),
            ViewDatabase(),
          ],
        ),
      ),
    );
  }

  Future<void> choicePopupMenu(String s) async {
    if (s == 'logout') {
      await FirebaseAuth.instance.signOut().whenComplete(() =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false));
    }
  }
}
