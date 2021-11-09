import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/app_const/common.dart';
import 'package:wheather_app/model/model_wheather.dart';
import 'package:wheather_app/widget.dart/value_tile.dart';

class WeatherWidget extends StatelessWidget {
  final ModelWheather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.weather.city.name.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                // color: AppStateContainer.of(context).theme.accentColor,
                fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.weather.list?.first?.weather[0]?.description,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              letterSpacing: 5,
              fontSize: 15,
            ),
          ),
          Padding(
            child: Divider(),
            padding: EdgeInsets.all(10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cloud_outlined,
                size: 70,
              ),
              const SizedBox(
                height: defaultHeightMedium,
              ),
              Text(
                '${(this.weather.list.first.main.temp - 273.15).toStringAsFixed(1)}°',
                style: TextStyle(
                  fontSize: defaultHeightMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: defaultHeightMedium,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ValueTile("max",
                        '${(this.weather.list.first.main.tempMax - 273.15).toStringAsFixed(1)}°'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Center(
                          child: Container(
                        width: 1,
                        height: 30,
                      )),
                    ),
                    ValueTile("min",
                        '${(this.weather.list.first.main.tempMin - 273.15).toStringAsFixed(1)}°'),
                  ]),
            ],
          ),
          Padding(
            child: Divider(),
            padding: EdgeInsets.all(10),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ValueTile("wind speed",
                    '${this.weather?.list?.first?.wind?.speed ?? ""} m/s'),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                  )),
                ),
                ValueTile(
                    "sunrise",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            this.weather.city.sunrise * 1000))),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                  )),
                ),
                ValueTile(
                    "sunset",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            this.weather.city.sunset * 1000))),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                  )),
                ),
                ValueTile("humidity",
                    '${this.weather?.list?.first?.main?.humidity ?? ""}%'),
              ]),
        ],
      ),
    );
  }
}
