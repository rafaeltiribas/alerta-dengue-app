import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

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
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  List<List<dynamic>>? _csvData;

  Future<void> fetchData() async {
    // ignore: prefer_const_declarations
    final url = 'https://info.dengue.mat.br/api/alertcity';
    final searchFilter =
      'geocode=${widget.cityCode}&disease=${widget.disease}&format=csv&' +
      'ew_start=1&ew_end=50&ey_start=${widget.startDate}&ey_end=${widget.endDate}';

    final fullUrl = Uri.parse('$url?$searchFilter');

    try {
      final response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        // Process the CSV response
        final csvData = const CsvToListConverter().convert(response.body);
        setState(() {
          _csvData = csvData;
        });
      } else {
        // Handle the error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle the exception
      print('An error occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
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
                'Disease: ${widget.disease}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'Start Date: ${widget.startDate}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'End Date: ${widget.endDate}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'State Code: ${widget.stateCode}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
            ),
             Text(
                'City Code: ${widget.cityCode}',
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