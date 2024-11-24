import 'package:flutter/material.dart';
import 'package:local_weather_app/curent_weather_service.dart';

class WindSpeed extends StatefulWidget {
  const WindSpeed({super.key});
  // final double windSpeedValue;

  // const WindSpeed(weatherdata, {super.key,required this.windSpeedValue});

  @override
  State<WindSpeed> createState() => _WindSpeedState();
}

class _WindSpeedState extends State<WindSpeed> {




 Map<String, dynamic>? _Weatherdata;
  final WeatherService _weatherServise = WeatherService();
  String city = 'Amman';
  bool _isLoading = false;

  Map<String,dynamic>?getWeatherData(){
    return _Weatherdata;
  }

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _weatherServise.featchWeather(city);
      setState(() {
        _Weatherdata = data;
      });
    } catch (e) {
      throw Exception("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  

  //To call the _getWeather(); when the widgrt relode
  @override
  void initState() {
    super.initState();
    _getWeather();
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      padding: const EdgeInsets.all(15),
      height: 130,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                      child: Image.asset(
                    "Materials/windy.png",
                    width: 30,
                    height: 35,
                    color: Colors.white,
                  )),
                ),
                const Text(
                  "Wind",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white38,
            thickness: 1.0,
          ),


          Center(
            child: Text('${_Weatherdata?['wind']['speed'].round()} km/s',
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.white),
            
            )
            ),
        ],
      ),
    );
  }
}