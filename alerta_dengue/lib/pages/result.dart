import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String disease;
  final String startDate;
  final String endDate;
  final String stateCode;
  final String cityCode;

  ResultScreen({
    required this.disease,
    required this.startDate,
    required this.endDate,
    required this.stateCode,
    required this.cityCode,
  });

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ResultScreenState createState() => _ResultScreenState(disease:  disease, 
    startDate: startDate, endDate: endDate, stateCode: stateCode, cityCode: cityCode);
}

class _ResultScreenState extends State<ResultScreen> {

  final String disease;
  final String startDate;
  final String endDate;
  final String stateCode;
  final String cityCode;

  _ResultScreenState({
    required this.disease,
    required this.startDate,
    required this.endDate,
    required this.stateCode,
    required this.cityCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Result',
        style: TextStyle(
          fontFamily: 'Lexend',
        ),
      ),
      centerTitle: true,
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Text(
                'Disease: $disease',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'Start Date: $startDate',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'End Date: $endDate',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'State Code: $stateCode',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'City Code: $cityCode',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
        ],),
      ),
    );
  }
}