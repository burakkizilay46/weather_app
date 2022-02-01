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
int? temp;

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
      weather.weather = responseJSON['weather'][0]['main'].toString();
      weather.temperature = responseJSON['main']['temp'].toString();
      temp = int.parse(weather.temperature.toString()) - 273;
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
            FutureBuilder(
              future: http.get(Uri.parse(url)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _incrementCounter();
                  return Column(
                    children: [
                      Text("Kızıltepe",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 48)),
                      Text("8 C" , style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 36)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Clouds" , style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 36)),
                          Container(
                            child: Icon(Icons.cloud_sharp , size: 50,),
                          ),
                        ],
                      ),
                    ],
                  );
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

//Text(
//    temp.toString() +
//        "\n" +
//        weather.name.toString() +
//        "\n" +
//        weather.weather.toString(),
//    style: TextStyle(fontSize: 24)),
