import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _PatientCardWidget extends StatefulWidget {
  const _PatientCardWidget({Key? key, required this.patient}) : super(key: key);
  final Patient patient;

  @override
  State<_PatientCardWidget> createState() => __PatientCardWidgetState();
}

class __PatientCardWidgetState extends State<_PatientCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   height: 70.0,
              //   width: 10.0,
              //   color: widget.patient.first_name!
              //       ? Colors.greenAccent.shade400
              //       : Colors.grey.shade400,
              // ),
              SizedBox(
                width: width * 0.95,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/patient_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.patient.first_name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(widget.patient.last_name),
              
                ),
              ),
            ],
          ),
        );
  }
}