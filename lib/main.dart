import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/WeatherModel.dart';

void main() {
  runApp(const MyApp());
}

String url =
    "https://api.openweathermap.org/data/2.5/weather?q=Kızıltepe&appid=3bd5ba9c630e384ffbf8de1f536042fe";

    WeatherModel weather = WeatherModel();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> _incrementCounter() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      
      Map responseJSON = jsonDecode(response.body);

      weather.name = responseJSON['name'].toString();   
      weather.weather = responseJSON['weather']['main'].toString();   
      weather.temperature = responseJSON['main']['temp'].toString();   
    } else {
      "Baglantida sorun olustu!!";
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //_incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'GELEN CEVAP',
              style: Theme.of(context).textTheme.headline3,
            ),
            FutureBuilder(
              future: http.get(Uri.parse(url)),
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  _incrementCounter();
                  return Text(weather.weather.toString() , style: TextStyle(fontSize: 24),);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
