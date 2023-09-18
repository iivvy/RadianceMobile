import 'package:RadianceAI/Patients/bloc/patient_bloc.dart';
import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/Patients/widgets/patients_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  bool isSearching = false;
  List<Patient> _filteredPatients = [];
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        // Here, filter your patient list based on the search term.
                        // Replace `filteredPatients` with your actual patient list.
                        // This is a simple example; you may need to filter differently.
                        _filteredPatients =
                            BlocProvider.of<PatientBloc>(context)
                                .state
                                .patients
                                .where((patient) =>
                                    patient.first_name
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    patient.last_name
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                .toList();
                      });
                    },
                    controller: myController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search patients",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                // Rest of your content here
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PatientBloc, PatientState>(
              builder: (context, state) {
                if (state is PatientLoaded) {
                  final patientsToShow = _filteredPatients.isNotEmpty
                      ? _filteredPatients
                      : state.patients;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.vertical,
                    itemCount: patientsToShow.length,
                    itemBuilder: (context, index) {
                      final patient = patientsToShow[index];
                      return PatientCardWidget(
                        patient: patient,
                      );
                    },
                  );
                } else if (state is PatientError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
