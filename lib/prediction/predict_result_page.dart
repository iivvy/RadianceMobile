

import 'package:RadianceAI/prediction/models/predict_list_model.dart';
import 'package:flutter/material.dart';

class PredictionResultPage extends StatefulWidget {
  const PredictionResultPage({Key? key,required this.prediction}):super(key: key);
  final Map<String, dynamic> prediction;

  @override
  State<PredictionResultPage> createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
   late Map<String, dynamic> prediction;
  

  @override
  void  initState() {
    prediction = widget.prediction;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
      final Map<String, dynamic> observations = prediction['observations'];
  
  // Create an empty string to build the formatted output
  String observationsText = '';

  // Iterate through the map and build the formatted string
  observations.forEach((key, value) {
    observationsText += ' $key: $value\n';
  });
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Column(
      children: [
        Text('Observations', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
        Center(
          child: Text(observationsText),
        ),
      ],
    ),
    );
  }
}