import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PatientCardWidget extends StatefulWidget {
  const PatientCardWidget({Key? key, required this.patient}) : super(key: key);
  final Patient patient;

  @override
  State<PatientCardWidget> createState() => _PatientCardWidgetState();
}

class _PatientCardWidgetState extends State<PatientCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      margin:  const EdgeInsets.only(left:10.0,right:10.0,top:5.0,bottom: 5.0),
      

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 2.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
       
              SizedBox(
               height: 70.0,
               width: width * 0.6,

                child: ListTile(
                  leading: Container(
                   
                    height: 50.0,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      
    
                      image: DecorationImage(
                        image: AssetImage('assets/images/patient.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                  "${widget.patient.first_name} ${widget.patient.last_name}",

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.patient.age}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )
                
              
                ),
              ),
            ],
          ),
        );
  }
}