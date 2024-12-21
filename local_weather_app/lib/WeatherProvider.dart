import 'package:flutter/material.dart';
import 'package:local_weather_app/WeekAndDayService.dart';
import 'package:local_weather_app/curent_weather_service.dart';


class WeatherProvider with ChangeNotifier{

  //make obj from the weekAndDayServise and the currentWeather servise:
  final WeatherService weatherService=WeatherService();
  final WeekAndDayService weekAndDayService=WeekAndDayService();

  Map<String,dynamic>?currentWeather;
  Map<String,dynamic>?weeklyWeather;

  bool isLoding=false;

  Future<void>featchData() async{
    isLoding=true;
    notifyListeners();

    try {
      currentWeather=await weatherService.featchWeather();
      weeklyWeather=await weekAndDayService.featchWeather();
    } catch (e) {
      print(e);
    }finally{
      isLoding=false;
      notifyListeners();
    }

  }



}