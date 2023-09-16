import 'package:RadianceAI/prediction/models/predict_list_model.dart';
import 'package:RadianceAI/prediction/widgets/report_template.dart';
import 'package:RadianceAI/report/report_bloc/report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictionResultPage extends StatefulWidget {
  const PredictionResultPage({Key? key, required this.prediction})
      : super(key: key);
  final Map<String, dynamic> prediction;

  @override
  State<PredictionResultPage> createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  late Map<String, dynamic> prediction;
  late Map<String, dynamic> report ;
  

  @override
  void initState() {
    prediction = widget.prediction;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> observations = prediction['observations'];
    String predId = prediction['pred_id'];
    
    // report ={};
   
    // final Map<String, dynamic> findings = report['findings'];

    // Create an empty string to build the formatted output
    String observationsText = '';
    bool isImageVisible = false;
    Image? activationMapImage;

    // Iterate through the map and build the formatted string
    observations.forEach((key, value) {
      observationsText += ' $key: $value\n';
    });
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Color.fromARGB(255, 0, 0, 1),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       // Navigate to the notification page
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportTemplate(report: state.report,)));
           
          //     },
          //     icon: const Icon(
          //       Icons.notifications,
          //       size: 25,
          //       color: Color.fromARGB(255, 0, 0, 1),
          //     ),
          //   ),
          // ],
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 236, 255, 255),
          title: const Text("Your prediction result",
              style: TextStyle(color: Colors.black)),
        ),
        body: BlocListener<ReportBloc, ReportState>(
          listener: (context, state) {
            if (state is ReportCreated) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportTemplate(report: state.reports)));
            //    setState(() {
            //    report =state.reports;
            //    print("this is the page response ${report['findings']}"); // Update the response text
            // });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Report created")),
              );
            } else {
              if (state is ReportCreatedFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("report creation failed")),
                );
              }
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Observations',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                Center(
                  child: Text(observationsText),
                ),
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: BlocBuilder<ReportBloc, ReportState>(
                    builder: (context, state) {
                      return state is ReportLoading
                          ? const SizedBox(
                              width: 200.0,
                              height: 42.0,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ) // Show progress indicator when loading
                          : MaterialButton(
                              onPressed: () async {
                                // Create a new report
                                BlocProvider.of<ReportBloc>(context).add(
                                  GetReportsEvent(
                                    predId: prediction['pred_id'],
                                  ),
                                );
                              },
                              minWidth: 200.0,
                              height: 60.0,
                              color: Color.fromARGB(255, 223, 0, 0),
                              child: const Text(
                                'generate report',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: MaterialButton(
                    onPressed: () async {
                      final imageUrl =
                          'http://127.0.0.1:8000/doctor/predict/activation/${prediction['pred_id']}';

                      setState(() {
                        activationMapImage = Image.network(
                          imageUrl,
                          width: 200, // Set the desired width
                          height: 200, // Set the desired height
                        );
                        isImageVisible = true;
                      });
              
                    },
                    minWidth: 200.0,
                    height: 60.0,
                    color: Color.fromARGB(255, 0, 176, 35),
                    child: const Text(
                      'create activation map',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isImageVisible,
                  child: activationMapImage ??
                      Container(), // Display the image or an empty container
                ),
                 Image(
                      // height: 300.0,
                      // width: 300,
                      image: NetworkImage(
                          'http://127.0.0.1:8000/api/doctor/predict/activation/$predId'),
            
                      fit: BoxFit.cover),
                 
                    
                
              ],
            ),
          ),
        ));
  }
}
