import 'package:flutter/material.dart';
import 'data/forecast_data.dart';
import 'data/weather.dart';
import 'widgets/body.dart';
import 'package:http/http.dart' as http;
import 'package:futuristic/futuristic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(canvasColor: Colors.transparent),
      home: MysplashScreen(),
    );
  }
}

class MysplashScreen extends StatelessWidget {
  weatherdata() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    var future = await fetchForecastData(http.Client());
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Futuristic(
        futureBuilder: weatherdata(),
        initialBuilder: (context, start) => Container(
          height: 100,
          width: 200,
          color: Colors.amberAccent,
        ),
        busyBuilder: (context) => CircularProgressIndicator(),
        errorBuilder: (context, error, retry) => Container(
          width: 100,
          height: 100,
          child: Center(
            child: Text(error.toString()),
          ),
        ),
        dataBuilder: (context, data) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      weatherData: data,
                    ))),
      ),
    );
  }
}
