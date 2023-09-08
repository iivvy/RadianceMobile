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
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(prediction['observations'].toString())),
    );
  }
}