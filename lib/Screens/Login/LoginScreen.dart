import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rna_analysis/Screens/Home/HomeScreen.dart';
import 'package:rna_analysis/Screens/Login/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailAvailibilty, passwordAvailibilty;
  String emailErrorText = '', passwordErrorText = '';
  TextEditingController emailController, passController;
  String email = '', password = '';

  @override
  void initState() {
    emailAvailibilty = true;
    passwordAvailibilty = true;
    emailController = TextEditingController();
    passController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: ListView(
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
                    'Login',
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color:
                                    email != '' ? Colors.green : Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 50),
                            focusColor: Colors.green,
                            hintText: 'Enter email here',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.height / 80),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                            fillColor: Colors.white,
                            filled: true)
                        .copyWith(
                      errorText: emailAvailibilty ? null : emailErrorText,
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
                                    MediaQuery.of(context).size.height / 50),
                            focusColor: Colors.green,
                            hintText: 'Enter Password here',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.height / 80),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                            fillColor: Colors.white,
                            filled: true)
                        .copyWith(
                      errorText: passwordAvailibilty ? null : passwordErrorText,
                    ),
                    style: TextStyle(
                        color: password != '' ? Colors.green : Colors.black54,
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
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: MaterialButton(
                        onPressed: () async {
                          if (email.isNotEmpty) {
                            if (password.isNotEmpty) {
                              try {
                                final user = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }), (route) => false);
                                }
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                    emailAvailibilty = false;
                                    emailErrorText =
                                        "No user found for that email";
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                    passwordAvailibilty = false;
                                    passwordErrorText =
                                        "Wrong password provided for that user";
                                  }
                                });
                              }
                            } else {
                              setState(() {
                                passwordAvailibilty = false;
                                passwordErrorText = "Password is not provided";
                              });
                            }
                          } else {
                            setState(() {
                              emailAvailibilty = false;
                              emailErrorText = "Email is not provided";
                              if (password.isEmpty) {
                                passwordAvailibilty = false;
                                passwordErrorText = "Password is not provided";
                              }
                            });
                          }
                        },
                        shape: StadiumBorder(),
                        color: Colors.green,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        print(email);
                        print(password);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        "Not Registerd ?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
