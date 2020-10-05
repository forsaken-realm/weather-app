import 'package:http/http.dart' as http;
import 'package:weather_app/data/forecast_data.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/weather.dart';
import 'bottom.dart';

class MyHomePage extends StatefulWidget {
  var weatherData;
  MyHomePage({this.weatherData});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String place;
  String condition;
  double temperture;
  double pressure;
  int humidty;
  double windSpeed;
  String iconUrl;
  int dayOrNight;

  void weatherdata() {
    place = widget.weatherData['location']['name'];
    condition = widget.weatherData['current']['condition']['text'];
    windSpeed = widget.weatherData['current']['wind_kph'];
    pressure = widget.weatherData['current']['pressure_in'];
    humidty = widget.weatherData['current']['humidity'];
    temperture = widget.weatherData['current']['temp_c'];
    iconUrl = widget.weatherData['current']['condition']['icon'];
    dayOrNight = widget.weatherData['current']['is_day'];
    iconUrl = iconUrl.substring(2);
    if (condition.length >= 22) {
      condition = '${condition.substring(0, 22)}\n${condition.substring(23)}';
    }

    print(place);
    print(condition);
    print(iconUrl);
  }

  @override
  void initState() {
    super.initState();
    weatherdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            //color: Colors.amber,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/n.jpg'), fit: BoxFit.fill),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () {
                        print('hii');
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  place ?? 'Home',
                  style: GoogleFonts.roboto(fontSize: 50, color: Colors.white),
                ),
                Text(
                  'Today',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Noon',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: NetworkImage('https://$iconUrl') ??
                            SvgPicture.asset('images/animated/day.svg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          temperture.toString() + '° C' ?? '25° C',
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 80,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          condition.toString() ?? 'Light rain shower',
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bottomItems(
                        iconsData: WeatherIcons.windy,
                        details: windSpeed.toString(),
                        contraints: 'km/h'),
                    _bottomItems(
                        iconsData: WeatherIcons.humidity,
                        details: humidty.toString(),
                        contraints: '%'),
                    _bottomItems(
                        iconsData: WeatherIcons.barometer,
                        details: pressure.toString(),
                        contraints: 'inches'),
                  ],
                )
              ],
            ),
          ),
          // BottomSheetNew(
          //   futureForecast: future,
          // ),
        ],
      ),
    );
  }

  Widget _bottomItems({iconsData, String details, String contraints}) {
    return Column(
      children: [
        Icon(iconsData),
        Text(
          details,
          style: GoogleFonts.openSansCondensed(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        Text(
          contraints,
          style: GoogleFonts.openSansCondensed(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
