import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService{
  //The api key :
  final String ApiKey='575c6cc04b8db3ab5f5914d7cfabcf49';
  //The URL we will get the data from  :
  
  final String ApiURL='https://api.openweathermap.org/data/2.5/weather';

  //This method will take the city name to get the current weather :


  // Future<Map<String,dynamic>> featchWeather(double latitude, double longitude)async{
  Future<Map<String,dynamic>> featchWeather()async{
    //async-->(Asynchronous)  to share that the method is Future 
    //Future : mean that the operation will excude in the futuer (the result need some time)
    
    
    
    //To generate the requst :
    // final url=Uri.parse('$ApiURL?lat=$latitude&lon=$longitude&units=metric&appid=$ApiKey');
    final url=Uri.parse('$ApiURL?q=Zarqa&units=metric&appid=$ApiKey');

    try{
      //To send a requst to get the data from api using the methode GET
      //and save the response in this var :
      final response=await http.get(url);
      //await -->to wait the Future operation 


      //To handle the response if the response statusCode is 200 (success) the data
      //will returned as a dart map 
      if(response.statusCode==200) {
        return jsonDecode(response.body);
      } 
      //if the statusCode is not 200 then the exption will throws
      
      else {
        throw Exception('Faild to get the weather data');
      }
    }
    catch(e){
      throw Exception('Error :  $e');
    }
  }

}
