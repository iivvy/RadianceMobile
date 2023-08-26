import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:RadianceAI/commons/Welcome.dart';
import 'package:RadianceAI/login/bloc/auth_bloc.dart';

import 'bloc/auth_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Welcome(defaultIndex: 0)));

            } else {
              if (state is AuthenticationError){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("username or password is invalid")),
                );
              }
            }
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20.0, right: 20.0),

                  // height: 521,

                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Welcome to Radiance.AI 👋',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // const Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: 20.0),
                      //     child: Text(
                      //       'Email address',
                      //       style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           fontStyle: FontStyle.normal,
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 15,
                      //           color: Colors.black),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 450,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Email address',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                             Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10.0, right: 20.0, bottom: 20.0),
                              child: TextFormField(
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'email';
                                  } return null;
                                },

                                controller: userNameController,


                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    hintText: 'Example@gmail.com'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                             Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10.0, right: 20.0, bottom: 20.0),
                              child: TextFormField(
                                controller: userPasswordController,
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'password';
                                  } return null;
                                },

                                obscureText: true,
                                cursorColor: Colors.blueGrey,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  hintText: '*************',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
                              child: Material(
                                color: const Color(0xff0f172a),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(13.0)),
                                elevation: 2.0,
                                child: MaterialButton(
                                    minWidth: 240.0,
                                    height: 60.0,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()){
                                        BlocProvider.of<AuthenticationBloc>(context)
                                            .add(Authenticate(userName: userNameController.text, userPassword: userPasswordController.text));
                                      }

                                      //
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => const Welcome(defaultIndex: 0,)),
                                      // );
                                      // Navigator.pushNamed(context, '/');
                                    },
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 13,
                                        ),
                                        Icon(
                                          Icons.login_sharp,
                                          color: Colors.white,
                                          size: 25.0,
                                          weight: 15.0,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: "By signing in, you confirm our",
                            style: TextStyle(
                                color: Color(0x898c8ca1),
                                fontSize: 15,
                                fontFamily: 'poppins'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms Of Use ',
                                  style: TextStyle(
                                      color: Color(0xff1d4ed8),
                                      fontWeight: FontWeight.w700)),
                              TextSpan(
                                  text: 'and ',
                                  style: TextStyle(color: Color(0x898c8ca1))),
                              TextSpan(
                                  text: 'Privacy Policy ',
                                  style: TextStyle(
                                      color: Color(0xff1d4ed8),
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )

        );
  }
}
//and
