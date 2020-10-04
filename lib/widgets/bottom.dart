import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/data/forecast_data.dart';
import 'package:intl/intl.dart';

class BottomSheetNew extends StatefulWidget {
  final String place;
  final List<Forecast> futureForecast;
  BottomSheetNew({this.place, this.futureForecast});
  @override
  _BottomSheetNewState createState() => _BottomSheetNewState();
}

class _BottomSheetNewState extends State<BottomSheetNew> {
  List<Forecast> newdata;
  get data {
    var data = DateTime.now();
    var d = DateFormat.H().format(data);
    newdata = widget.futureForecast.sublist(int.parse(d));
  }

  @override
  Widget build(BuildContext context) {
    data;
    return DraggableScrollableSheet(
        minChildSize: 0.1,
        maxChildSize: 0.6,
        builder: (context, controller) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(20))),
              child: ListView.builder(
                  controller: controller,
                  itemCount: newdata.length,
                  itemBuilder: (context, index) {
                    var data = DateTime.tryParse('${newdata[index].time}');
                    var timeinstance = DateFormat.Hm().format(data);
                    return ListTile(
                      title: Text(newdata[index].condition),
                      trailing: Image(
                        image: NetworkImage(
                            'https://${newdata[index].url.substring(2)}'),
                      ),
                      leading: Text(timeinstance.toString()),
                    );
                  }));
        });
  }
}
