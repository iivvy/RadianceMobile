import 'package:flutter/material.dart';
import 'package:RadianceAI/Patients/Patients.dart';
import 'package:RadianceAI/commons/Home.dart';
import 'package:RadianceAI/profile/profile.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.defaultIndex}) : super(key: key);
  final int defaultIndex;

  @override
  State<Welcome> createState() => _WelcomeState();
}

int _selectedIndex = 0;

class _WelcomeState extends State<Welcome> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
      }
      if (index == 2) {
        // BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
      }
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const UserProfile(),
    const Patients(),
    const Home(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:const Icon(Icons.arrow_back),color: Colors.blue.shade900, onPressed: (

            ) {   Navigator.pop(context); },),
       ),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      backgroundColor: Colors.red,
      bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon:
            Icon(Icons.sick),
            label: "Patients",
          ),
          BottomNavigationBarItem(
            icon: Icon(
     Icons.account_circle_rounded),

            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),


      );

  }
}
