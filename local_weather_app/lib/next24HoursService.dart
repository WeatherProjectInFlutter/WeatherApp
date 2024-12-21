import 'dart:convert';
import 'package:http/http.dart'as http; //for making http requests

class weatherService{
  // final String _baseUrl = "https://api.openweathermap.org/data/2.5/onecall";


//lat: The latitude of the location ,lon: The longitude of the location.
Future<Map<String,dynamic>>fetchHourlyWeather(double lat,double lon)async{
  
  const String apiKey="03065372363de81d3bacfee096b445b6";
  final String apiURL = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";


  final response=await http.get(Uri.parse(apiURL)); //make an http get request to the API endpoint

  //chech if the request was successful
  if(response.statusCode==200){
    return json.decode(response.body); //parse the JSON body and return it as a map
    }
    else{
      throw Exception("Failed to fetch 24-hour weather data. Status code: ${response.statusCode}");
  }
}
}