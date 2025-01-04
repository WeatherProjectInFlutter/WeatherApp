import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeekAndDayService.dart';
import 'package:local_weather_app/curent_weather_service.dart';
import 'package:local_weather_app/next24HoursService.dart';

class WeatherProvider with ChangeNotifier {
  //make obj from the weekAndDayServise and the currentWeather service:
  final WeatherService weatherService = WeatherService();
  final WeekAndDayService weekAndDayService = WeekAndDayService();
  final Next24HoursService nextHoursService = Next24HoursService();

  Map<String, dynamic>? currentWeather; //A map to store data fetched for the current weather.
  Map<String, dynamic>? weeklyWeather;
  Map<String, dynamic>? hourlyWeather;

  bool isLoding =false; // A boolean flag to indicate whether the data fetching process is in progress

  final List<String>_cities =[]; //List to store city names
  List<String> get cities => _cities;

  void addCity(String cityName){ //to add cities to list (Saved Cities in the DRAWER)
    if(!_cities.contains(cityName)){
      _cities.add(cityName); // Add city if it's not already in the list
      notifyListeners();
    }
  }

  Future<void> featchData() async {
    //This method is responsible for fetching weather data.
    isLoding = true;
    Position position = await getCurrentLocation();

    notifyListeners();

    //Notifies all listeners (widgets) to rebuild based on the updated state.

    try {
      currentWeather = await weatherService.featchWeatherWithLongAndLat(
          position.latitude, position.longitude);
      weeklyWeather = await weekAndDayService.featchWeatherWithLongAndLat(
          position.latitude, position.longitude);
      hourlyWeather = await nextHoursService.featchWeatherWithLongAndLat(
          position.latitude, position.longitude);
    } catch (e) {
      print(e);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> fetchDataByCityName(String cityName) async{
    bool isLoding=true;
    notifyListeners();

    try{
      currentWeather=await weatherService.featchWeatherByCityName(cityName);
      weeklyWeather=await weekAndDayService.featchWeatherByCityName(cityName);
      hourlyWeather=await nextHoursService.featchWeatherByCityName(cityName);
      
      addCity(cityName); // Add city to the list after fetching data
    }
    catch(e){
      debugPrint("Error fetching weather: $e");
    }finally{
      isLoding=false;
      notifyListeners();
    }
    
}
}
