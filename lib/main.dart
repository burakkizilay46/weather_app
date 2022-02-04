import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/WeatherModel.dart';

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
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void weatherIcon() {
    switch (weather.weather) {
      case "clear sky":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "few clouds":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "scattered clouds":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "broken clouds":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "shower rain":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "rain":
        {
          const Icon(Icons.wb_sunny);
        }
        break;
      case "thunderstorm":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "snow":
        {
         const Icon(Icons.wb_sunny);
        }
        break;
      case "mist":
        {
          const Icon(Icons.wb_sunny);
        }
        break;

      default:
        {
          const Icon(Icons.wb_sunny);
        }
        break;
    }
  }

  Future<void> _incrementCounter() async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      Map responseJSON = jsonDecode(response.body);

      weather.name = responseJSON['name'].toString();
      weather.weather = responseJSON['weather'][0]['main'].toString();
      weather.temperature = responseJSON['main']['temp'].toString();
      //temp = int.parse(weather.temperature.toString()) - 273;
    } catch (e) {
      print(e);
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
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Weather App"),
      ),
      body: Center(
        child: FutureBuilder(
          future: http.get(Uri.parse(url)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //_incrementCounter();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Kızıltepe  ",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 48, color: Colors.white)),
                      Icon(
                        Icons.cloud_sharp,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ],
                  ),
                  Text("8 Derece",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 36, color: Colors.white)),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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


/*
switch (weather.weather) {
      case "clear sky":
        {}
        break;
      case "few clouds":
        {}
        break;
      case "scattered clouds":
        {}
        break;
      case "broken clouds":
        {}
        break;
      case "shower rain":
        {}
        break;
        case "rain":
        {}
        break;
        case "thunderstorm":
        {}
        break;
        case "snow":
        {}
        break;
        case "mist":
        {}
        break;

      default:
        {
          //statements;
        }
        break;
    }
    
    */