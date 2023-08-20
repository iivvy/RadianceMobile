import 'package:flutter/material.dart';
import 'package:tesy/login/login.dart';

import 'commons/Welcome.dart';


void main() {
  runApp(const MaterialApp(home: Login()),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute:'/' ,
      routes: {
        '/':(context) =>const Welcome(),
        'login':(context)=> const Login(),

      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//     );
//   }
// }
