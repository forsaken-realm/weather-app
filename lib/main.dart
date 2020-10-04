import 'package:flutter/material.dart';
import 'data/forecast_data.dart';
import 'data/weather.dart';
import 'widgets/body.dart';
import 'package:http/http.dart' as http;

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
      home: MyHomePage(),
      routes: {
        'splashScreen': (context) => MysplashScreen(),
        'home': (context) => MyHomePage()
      },
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: weatherdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()))
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
