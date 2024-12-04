import 'package:flutter/material.dart';
import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/curent_weather_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class test{
  
}

class CurrentWeatherSection extends StatefulWidget {
  const CurrentWeatherSection({super.key});

  @override
  State<CurrentWeatherSection> createState() => _CurrentWeatherSectionState();
}

class _CurrentWeatherSectionState extends State<CurrentWeatherSection> {
  Map<String, dynamic>? Weatherdata;
  final WeatherService weatherService = WeatherService();
  String city = '';

  bool isLoading = false;
  String weatherCondition="Sunny"; //default condition 

  void getWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      //this var to get the lat and lon for the user 
      final position =await getCurrentLocation();
      final data = await weatherService.featchWeather(position.latitude,position.longitude);
      setState(() {
        Weatherdata = data;
      });
    } catch (e) {
      throw Exception("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getWeatherImage(String condition){
    Map<String,String>weatherImages={
      "Sunny":"Materials/sunny.png",
      "Clear":"Materials/sunny.png",
      "Clouds":"Materials/heavycloud.png",
      "Rain":"Materials/heavy-rain.png",
      "Drizzle":"Materials/heavy-rain.png",
      "Snow":"Materials/snowy.png",
      "Thunderstorm":"Materials/thunder.png",
      "Fog":"Materials/fog.png",
      "Haze":"Materials/fog.png",
      "Mist":"Materials/fog.png",
      "Smoke":"Materials/fog.png",
    };
    return weatherImages[condition]?? "Materials/sunny.png"; //Materials/$weatherCondition.png"
  }

  //To call the _getWeather(); when the widget reload
  @override
  void initState() { 
    super.initState();
    getWeather();
  }

  int getCurentTemp(double val) {
    return val.round();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Padding(padding: EdgeInsets.only(left: 25)),
          isLoading? const Center(
                  child: CircularProgressIndicator(),
                )
              : Weatherdata == null
                  ? const Text("The data is not avilable")
                  : Text(
                      '${getCurentTemp(Weatherdata!['main']['temp'])}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 140,
                      ),
                    ),
          Container(
            padding:
                const EdgeInsets.only(left: 5), //هاي على التلفون بتخرب الصورة
            child: Image.asset(getWeatherImage('${Weatherdata?['weather'][0]['main']}'), width: 140, height: 140),
          ),
        ]),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 50)),
            Text(
              '${Weatherdata?['weather'][0]['description']}',
              style: const TextStyle(color: Colors.white, fontSize: 23),
            )
          ],
        ),

        //Refresh button
        Row(textDirection: TextDirection.rtl, children: [
          // const Size(2, 2),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: SizedBox(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                onPressed: getWeather,
                shape: const CircleBorder(),
                //  backgroundColor: Color.fromARGB(255, 99, 134, 225),

                backgroundColor: const Color.fromARGB(255, 96, 114, 233),
                foregroundColor: Colors.white,
                child: Icon(Icons.refresh_rounded),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}




//  Text(
            //   "24",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 140,
            //   ),
            // ),







            