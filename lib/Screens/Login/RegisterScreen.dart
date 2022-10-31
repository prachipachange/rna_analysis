import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rna_analysis/Provider/Provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool emailAvailibilty,
      passwordAvailibilty,
      nameAvailibilty,
      verpassAvailibilty;
  TextEditingController emailController,
      passController,
      nameController,
      verpassController;
  String email = '', password = '', name = '', verpass = '';

  @override
  void initState() {
    emailAvailibilty = true;
    passwordAvailibilty = true;
    nameAvailibilty = true;
    verpassAvailibilty = true;
    emailController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
    verpassController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  bool comparePasswords() {
    if (password == verpass) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Registration',
                        style: TextStyle(fontSize: 40),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                                labelText: 'Enter your name',
                                labelStyle: TextStyle(
                                    color: name != ''
                                        ? Colors.green
                                        : Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                                focusColor: Colors.green,
                                hintText: 'Enter Name here',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            80),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                fillColor: Colors.white,
                                filled: true)
                            .copyWith(
                          errorText: nameAvailibilty ? null : "Enter the Name",
                        ),
                        style: TextStyle(
                            color: name != '' ? Colors.green : Colors.black54,
                            fontSize: MediaQuery.of(context).size.height / 50),
                        onChanged: (value) {
                          if (value != '') {
                            nameAvailibilty = true;
                            name = value;
                          } else {
                            name = '';
                            nameAvailibilty = false;
                          }
                        },
                        onSubmitted: (value) {
                          name = passController.text;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: email != ''
                                        ? Colors.green
                                        : Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                                focusColor: Colors.green,
                                hintText: 'Enter email here',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            80),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                fillColor: Colors.white,
                                filled: true)
                            .copyWith(
                          errorText: emailAvailibilty
                              ? null
                              : "Please enter valid email",
                        ),
                        style: TextStyle(
                            color: email != '' ? Colors.green : Colors.black54,
                            fontSize: MediaQuery.of(context).size.height / 50),
                        onChanged: (value) {
                          if (value != '') {
                            emailAvailibilty = true;
                            email = value;
                          } else {
                            email = '';
                            emailAvailibilty = false;
                          }
                        },
                        onSubmitted: (value) {
                          email = emailController.text;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: password != ''
                                        ? Colors.green
                                        : Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                                focusColor: Colors.green,
                                hintText: 'Enter Password here',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            80),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                fillColor: Colors.white,
                                filled: true)
                            .copyWith(
                          errorText:
                              passwordAvailibilty ? null : "Enter password",
                        ),
                        style: TextStyle(
                            color:
                                password != '' ? Colors.green : Colors.black54,
                            fontSize: MediaQuery.of(context).size.height / 50),
                        onChanged: (value) {
                          if (value != '') {
                            passwordAvailibilty = true;
                            password = value;
                          } else {
                            password = '';
                            passwordAvailibilty = false;
                          }
                        },
                        onSubmitted: (value) {
                          password = passController.text;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        controller: verpassController,
                        decoration: InputDecoration(
                                labelText: 'Verify Password',
                                labelStyle: TextStyle(
                                    color: verpass != ''
                                        ? Colors.green
                                        : Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                                focusColor: Colors.green,
                                hintText: 'Verify Password here',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            80),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                fillColor: Colors.white,
                                filled: true)
                            .copyWith(
                          errorText:
                              verpassAvailibilty ? null : "Enter password",
                        ),
                        style: TextStyle(
                            color:
                                verpass != '' ? Colors.green : Colors.black54,
                            fontSize: MediaQuery.of(context).size.height / 50),
                        onChanged: (value) {
                          if (value != '') {
                            verpassAvailibilty = true;
                            verpass = value;
                          } else {
                            verpass = '';
                            verpassAvailibilty = false;
                          }
                        },
                        onSubmitted: (value) {
                          verpass = passController.text;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () async {
                              if (comparePasswords()) {
                                try {
                                  Provider.of<ProviderModifier>(context,
                                          listen: false)
                                      .updateSpinner(true);
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password)
                                          .whenComplete(() async {
                                    await FirebaseAuth.instance.currentUser
                                        .updateProfile(displayName: name);

                                    Provider.of<ProviderModifier>(context,
                                            listen: false)
                                        .updateSpinner(false);
                                    Navigator.pop(context);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Provider.of<ProviderModifier>(context,
                                          listen: false)
                                      .updateSpinner(false);
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  Provider.of<ProviderModifier>(context,
                                          listen: false)
                                      .updateSpinner(false);
                                  print(e);
                                }
                                //todo login
                              } else {
                                setState(() {
                                  Provider.of<ProviderModifier>(context,
                                          listen: false)
                                      .updateSpinner(false);
                                  verpassAvailibilty = false;
                                });
                              }
                            },
                            shape: StadiumBorder(),
                            color: Colors.green,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
      ),
    ));
  }
}
