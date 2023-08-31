import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/Setting/bloc/setting_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  bool isSearching = false;

  //late ProductListModel _productlist;
  List<Patient> _filteredpatients = [];
  final myController = TextEditingController();

  String value = "";
  late bool _theme;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController.addListener(_latestValue);
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
  }

  void _latestValue() {
    setState(() {
      value = myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      decoration: BoxDecoration(
                        // border:
                        // Border.all(color: Colors.black), // Add border here
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add border radius
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _latestValue();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            // myController.text = "";
                            isSearching = true;
                          });
                        },
                        controller: myController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search patients",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    // Add the rest of your content here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
