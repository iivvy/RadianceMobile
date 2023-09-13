import 'package:flutter/material.dart';

class ReportTemplate extends StatefulWidget {
  const ReportTemplate({super.key});

  @override
  State<ReportTemplate> createState() => _ReportTemplateState();
}

class _ReportTemplateState extends State<ReportTemplate> {

  
  RichText textlabel(String label, String text){
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 20.0)),
                
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  // textlabel('Exam number:',' 12345678'),
       
                  // textlabel("Report status:", "final"),
     
                ],
              ),
              textlabel('Type:','2 chest view'  ),
              Spacer(flex: 2),
              
              textlabel('DateTime:',' 12/12/2000 10:00h'),
                Spacer(flex:2),

              textlabel('Exam Code:', 'XT5U'),
                       Spacer(flex:2),
              textlabel('Ordering Provider:', 'Dr. John Doe'),
                       Spacer(flex:2),
              textlabel('History of present illness:', 'Patient presents with a history of...'),
                       Spacer(flex:2),
              textlabel('report',''),
            ],
            ),
      ),
    );
  }
}
