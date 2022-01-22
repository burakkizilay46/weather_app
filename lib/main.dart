import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

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
  String? responseWeather;

  Future<void> _incrementCounter() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=Kızıltepe&appid=3bd5ba9c630e384ffbf8de1f536042fe";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map responseJSON = jsonDecode(response.body);
      responseWeather = responseJSON["name"].toString()+  " " + responseJSON["sys"]["country"].toString();
    } else {
      responseWeather = "Baglantida sorun olustu!!";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            'GELEN CEVAP',
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(responseWeather == null ? "Deger yok" : "$responseWeather",
              style: TextStyle(fontSize: 36))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
