import 'package:flutter/material.dart';

class ReportTemplate extends StatefulWidget {
  const ReportTemplate({Key? key, required this.report}) : super(key: key);
  final Map<String, dynamic> report;

  @override
  State<ReportTemplate> createState() => _ReportTemplateState();
}

class _ReportTemplateState extends State<ReportTemplate> {
  @override
  void initState() {
    report = widget.report;

    super.initState();
  }

  late Map<String, dynamic> report;

  Padding textlabel(String label, String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
      child: RichText(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int exam_number = report['exam_number'];
    String report_text = report['findings'];
    String type = report['type'];
    String exam_code = report['exam_code'];
    String history = report['history'];
    String providers = report['providers'];
    String signature = report['signature'];
    String patient = report['ordering_provider'];
    final Map<String, dynamic> observations = report['observations'];
    String recommendations = report['recommendations'];
    // Iterate through the map and build the formatted string
    String observationsText = '';
    int index = 0;

    for (var key in observations.keys) {
      observationsText += ' $key';

      if (index < observations.length - 1) {
        observationsText += ',';
      }

      index++;
    }
  if (recommendations == '') {
      recommendations = 'No recommendations';
    }
    // String status = report['status'];
    // DateTime date_time = report['date'];

    return Scaffold(
      appBar: AppBar(
          title: Text('$patient Report '),
          backgroundColor: Colors.blue[900],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                // do something
              },
            )
          ]),
      body: Container(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(20.0, 15.0, 10.0, 10.0)),
            textlabel('Exam number: ', ' $exam_number'),
            textlabel("Report status: ", 'final.'),
            textlabel('Type: ',' $type.'),
            // textlabel('DateTime: ', '$date_time'),
            textlabel('Exam Code: ',' $exam_code.'),
            textlabel('Ordering Provider: ', '$providers.'),
            textlabel('History of present illness: ',' $history.'),
            textlabel('Report: ', '$report_text.'),
            textlabel('Observations: ', '${observationsText.toString()}.'),
            textlabel('recommendations: ', "$recommendations."),
            textlabel('providers: ', '$providers.'),
            textlabel('Signature: ', '$signature.')
        
          ],
        ),
      ),
    );
  }
}
