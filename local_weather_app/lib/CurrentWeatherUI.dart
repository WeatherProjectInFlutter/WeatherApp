import 'package:flutter/material.dart';
// import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeatherProvider.dart';
// import 'package:local_weather_app/curent_weather_service.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrentWeatherSection extends StatelessWidget {
  const CurrentWeatherSection({super.key});

  @override
  Widget build(BuildContext context) {

    final weatherProvider = Provider.of<WeatherProvider>(context);

    
    final Weatherdata = weatherProvider.currentWeather;
    String weatherCondition = "Sunny"; //default condition
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
    DateTime now=DateTime.now();
    String defultImage=(7<=now.hour&&now.hour<=19)?"Materials/sunny.png":"Materials/night-moon.png";

    return weatherImages[condition]??defultImage; //Materials/$weatherCondition.png"
  }

  int getCurentTemp(double val) {
    return val.round();
  }
  String getWeatherIconUrl(String iconCode) {
      return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
    }
    
    return Column(
      children: [
        Row(children: [
          const Padding(padding: EdgeInsets.only(left: 25)),
          weatherProvider.isLoding? const Center(
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

        
      ],
    );
  }
}
