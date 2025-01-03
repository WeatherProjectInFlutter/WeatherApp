import 'package:flutter/material.dart';
import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:local_weather_app/curent_weather_service.dart';
import 'package:provider/provider.dart';






class WindSpeed extends StatelessWidget {
  const WindSpeed({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final _Weatherdata = weatherProvider.currentWeather;
    return Container(
      width: 165,
      margin: const EdgeInsets.fromLTRB(18, 15, 0, 0),
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
          weatherProvider.isLoding?
          const Center(child: CircularProgressIndicator(),):
          _Weatherdata==null?
          const Text("The data not avilable"):

          Center(
            child: Text('${
              
              //  getWindSpeed
                _Weatherdata?['wind']['speed'].round()
                
              } m/s',
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.white),
            
            )
            ),
        ],
      ),
    );
  }
}







