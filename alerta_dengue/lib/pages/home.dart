import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController diseaseController = TextEditingController();
  TextEditingController sdateController = TextEditingController();
  TextEditingController edateController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

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
        '',
        style: TextStyle(
          fontFamily: 'Lexend',
        ),
      ),
      centerTitle: true,
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Brazil Alert',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lexend',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
            ),
            const Text(
                'Home',
                style: TextStyle(
                  color: Color.fromARGB(255, 109, 49, 237),
                  fontFamily: 'Lexend',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(height: 40),
            const Text(
                'Enter the requested data',
                style: TextStyle(
                  color:Colors.grey,
                  fontFamily: 'Lexend',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(height: 10),
            _inputField("Disease", diseaseController),
            const SizedBox(height: 20),
            _inputField("Start Date", sdateController),
            const SizedBox(height: 20),
            _inputField("End Date", edateController),
            const SizedBox(height: 20),
            _inputField("State Code", stateController),
            const SizedBox(height: 20),
            _inputField("City Code", cityController),
            const SizedBox(height: 40),
            _resultBtn(),
        ],),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller){

    //var border = OutlineInputBorder(
     // borderRadius: BorderRadius.circular(5),
     // borderSide: const BorderSide(color: Colors.black));

    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Lexend'
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        //enabledBorder: border,
        //focusedBorder: border,
      ),
    );
  }

  Widget _resultBtn(){
    return ElevatedButton(
      onPressed: (){}, // Get Result action
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 109, 49, 237),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Result",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Lexend',
            color: Colors.white,
          ),
        ),
      )
    );
  }
}

