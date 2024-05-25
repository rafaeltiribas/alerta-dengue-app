import 'package:flutter/material.dart';

class HomeScreen1 extends StatelessWidget {
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerta Dengue'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Informe os dados de consulta',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: diseaseController,
              decoration: InputDecoration(
                labelText: 'Doença',
                hintText: 'Digite a doença',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Data da consulta',
                hintText: 'Digite a data',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: stateController,
              decoration: InputDecoration(
                labelText: 'Lista de Estados',
                hintText: 'Geocode IBGE',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação do botão Resultado
                },
                child: Text('Resultado'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}