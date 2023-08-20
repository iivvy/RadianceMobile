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
      backgroundColor:Colors.grey.shade300,
      body: SafeArea(
        child: Form(
          key: formKey,
          child:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(20.0),
                    child: Text('Welcome to Radiance.AI 👋',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 350,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(

                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black54, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                hintText: 'Example@gmail.com'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(

                            obscureText: true,
                            cursorColor: Colors.blueGrey,
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black54, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                hintText: '*************'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            elevation: 5.0,
                            child: MaterialButton(

                              minWidth: 200.0,
                              height: 42.0,
                              onPressed: () {
                                Navigator.pushNamed(context, '/');},


                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),

                              ),
                            ),
                          ),
                        ),
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
