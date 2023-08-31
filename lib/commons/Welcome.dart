import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:RadianceAI/Setting/bloc/setting_bloc.dart';
import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:RadianceAI/Patients/Patients.dart';
import 'package:RadianceAI/commons/Home.dart';
import 'package:RadianceAI/profile/profile.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.defaultIndex}) : super(key: key);
  final int defaultIndex;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late User user;
  int _selectedIndex = 0;
  late bool _theme;

  @override
  void initState() {
    super.initState();

    user = const User(
      // id: 0,
      first_name: '',
      last_name: '',
      address: '',
      email: '',
      hospital: '',
      speciality: '',
      profile_picture: '',
      age: 0,
    );

    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';

    _initializeWidgetOptions();
  }

  void _initializeWidgetOptions() {
    _widgetOptions.addAll([
      const Home(),
      const Patients(),
      ProfilePage(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
      }
      if (index == 2) {
        BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
      }
    });
  }

  final List<Widget> _widgetOptions = [];

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          user = state.user;
        }
    
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   // Add your app bar content here
      // ),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sick),
            label: "Patients",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
      }
    );
    }
    }

