import 'package:flutter/material.dart';
import 'package:local_weather_app/WeekAndDayService.dart';
import 'package:local_weather_app/curent_weather_service.dart';
import 'package:local_weather_app/next24HoursService.dart';

class WeatherProvider with ChangeNotifier{

  //make obj from the weekAndDayServise and the currentWeather service:
  final WeatherService weatherService=WeatherService();
  final WeekAndDayService weekAndDayService=WeekAndDayService();
  final Next24HoursService nextHoursService=Next24HoursService();

  Map<String,dynamic>?currentWeather; //A map to store data fetched for the current weather.
  Map<String,dynamic>?weeklyWeather;
  Map<String,dynamic>?hourlyWeather;

  bool isLoding=false;  // A boolean flag to indicate whether the data fetching process is in progress

  Future<void>featchData() async{ //This method is responsible for fetching weather data.

    isLoding=true;
    notifyListeners();    //Notifies all listeners (widgets) to rebuild based on the updated state.

    try {
      currentWeather=await weatherService.featchWeather();
      weeklyWeather=await weekAndDayService.featchWeather();
      hourlyWeather=await nextHoursService.featchWeather();
    } catch (e) {
      print(e);
    }finally{
      isLoding=false;
      notifyListeners();
    }

  }



}