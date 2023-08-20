import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 100, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  // Image.asset("",height: 100,),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child:
                  SizedBox(
                    height: 350,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  // borderRadius: BorderRadius.circular(100)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(100)
                                    ),
                                hintText: 'Example@gmail.com'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            obscureText: true,
                            cursorColor: Colors.blueGrey,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  // borderRadius: BorderRadius.circular(100)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(100)
                                    ),
                                hintText: '************'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
