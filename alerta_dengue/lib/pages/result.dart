
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
  int week = 0;

  Future<Dengue> fetchDengue(int week) async {

    const url = 'https://info.dengue.mat.br/api/alertcity';
    final searchFilter =
      'geocode=${widget.cityCode}&disease=${widget.disease}&format=json&' +
      'ew_start=1&ew_end=50&ey_start=${widget.startDate}&ey_end=${widget.endDate}';

    final fullUrl = Uri.parse('$url?$searchFilter');
    

    final response = await http.get(fullUrl);
    

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print(decodedResponse.length);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // List<Dengue> dengueList = decodedResponse.map((item) => Dengue.fromJson(item as Map<String, dynamic>)).toList();
      return Dengue.fromJson(decodedResponse[week] as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dengue');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDengue = fetchDengue(week);
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
                // Display dados da semana 1
                return _resultField(snapshot);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        );
  }

/*
  Widget _resultField(AsyncSnapshot<Dengue> snapshot){
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(snapshot.data!.casos.toString()),
            Text(snapshot.data!.casosEst.toString()),
            Text(snapshot.data!.casosNot.toString()),
            Text(snapshot.data!.nivel.toString()),
            Text(snapshot.data!.tempMin.toStringAsFixed(2)),
            Text(snapshot.data!.tempMax.toStringAsFixed(2)),
            Text((week+1).toString()),
            const SizedBox(height: 40),
            _weekBtn("Next week", 1),
            const SizedBox(height: 20),
            _weekBtn("Last week", -1),
        ],),
        ),
    );
  }
*/

  Widget _resultField(AsyncSnapshot<Dengue> snapshot) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 109, 49, 237), width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            capitalizeFirstLetter(widget.disease),
            style: TextStyle(
              color: Color.fromARGB(255, 109, 49, 237),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Level: ${snapshot.data!.nivel}",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            "Rio de Janeiro",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${snapshot.data!.casosNot} casos notificados",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "${snapshot.data!.casos} casos",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${snapshot.data!.casosEst} casos estimados",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${snapshot.data!.tempMax.toStringAsFixed(2)} temperatura máxima",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${snapshot.data!.tempMin.toStringAsFixed(2)} temperatura mínima",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          const SizedBox(height: 40),
          _weekBtn("Next week", 1),
          const SizedBox(height: 20),
          _weekBtn("Last week", -1),
        ],
      ),
    );
  }


  Widget _weekBtn(String label, int signal){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          week += 1 * (signal);
          if(week < 0){week = 0;}
          if(week > 24){week = 25;}
          futureDengue = fetchDengue(week);
        });
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 109, 49, 237),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Lexend',
            color: Colors.white,
          ),
        ),
      )
    );
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}