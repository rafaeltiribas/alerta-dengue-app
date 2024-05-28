import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alerta_dengue/models/dengue_model.dart';
import 'dart:convert';
import 'dart:async';

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

  late Future<Dengue> futureDengue;

  Future<Dengue> fetchDengue() async {

    const url = 'https://info.dengue.mat.br/api/alertcity';
    final searchFilter =
      'geocode=${widget.cityCode}&disease=${widget.disease}&format=json&' +
      'ew_start=1&ew_end=50&ey_start=${widget.startDate}&ey_end=${widget.endDate}';

    final fullUrl = Uri.parse('$url?$searchFilter');
    

    final response = await http.get(fullUrl);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print(fullUrl);
      print(Dengue.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
      return Dengue.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dengue');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDengue = fetchDengue();
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
    return Center(
          child: FutureBuilder<Dengue>(
            future: futureDengue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.casos as String);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        );
  }
}