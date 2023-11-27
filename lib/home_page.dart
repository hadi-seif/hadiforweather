import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/consts.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState()=> _HomePageState();

}
class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OpenWeather_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Saida").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(),);
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator(),
      );
    }
    return SizedBox(width: MediaQuery
        .sizeOf(context)
        .width,
      height: MediaQuery
          .sizeOf(context)
          .height, child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.08,
          ),
          SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );

    // ignore: dead_code, unused_element, no_leading_underscores_for_local_identifiers
    Widget _dateTimeInfo() {
      DateTime now = _weather!.date!;
      return Column(
        children: [
          Text(DateFormat("h:mm a").format(now),
            style: const TextStyle(
              fontSize: 33,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat("EEEE").format(now),
                style: const TextStyle(
                    fontWeight: FontWeight.w700
                ),
              ),
              Text(
                " ${DateFormat("d.m.y").format(now)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery
              .sizeOf(context)
              .height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather
                      ?.weatherIcon}@4x.png"
              ),
            ),
          ),
        ),
        Text(_weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text("${_weather?.temperature?.celsius}°C",
      style: const TextStyle(
        color: Colors.greenAccent,
        fontSize: 80,
        fontWeight: FontWeight
            .
        w500
        ,
      )
      ,
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.15,
      width: MediaQuery
          .sizeOf(context)
          .width * 0.75,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(
        18,
      ),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("max: ${_weather?.tempMax?.celsius}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text("min: ${_weather?.tempMin?.celsius}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
