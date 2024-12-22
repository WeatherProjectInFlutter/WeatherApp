import 'package:flutter/material.dart';
import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:local_weather_app/curent_weather_service.dart';
import 'package:provider/provider.dart';


class SeaLevel extends StatelessWidget {
  const SeaLevel({super.key});

  @override
  Widget build(BuildContext context) {

    final weatherProvider = Provider.of<WeatherProvider>(context);
    final _Weatherdata = weatherProvider.currentWeather;
    return Container(
      width: 165,
      margin: const EdgeInsets.fromLTRB(5, 15, 18, 0),
      padding: const EdgeInsets.all(20),
      height: 130,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    child: Image.asset(
                      'Materials/tide.png',
                      width: 30,
                      height: 25,
                      color: const Color.fromARGB(170, 255, 255, 255),
                      
                    ),
                  ),
                ),
                const Text(
                  "sea level",
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
            
             const Center(child: CircularProgressIndicator()):
             _Weatherdata==null?
              Text("the data not avilable"):

            Center(
            child:Text('${
              // getSeaLevel
                _Weatherdata?['main']['sea_level'].round()
              }',
            style: 
            const TextStyle(fontSize: 30
            ,color: Color.fromARGB(255, 231, 230, 230),
            fontWeight: FontWeight.w700
            ),
             
            ), 
          )
          
        
        ],
      ),
    );
  }
}



/*
class SeaLevel extends StatefulWidget {
  const SeaLevel({super.key});

  // final int seaLivelValue;
  // const SeaLevel(weatherdata, {super.key, required this.seaLivelValue});

  @override
  State<SeaLevel> createState() => _SeaLevelState();
}

class _SeaLevelState extends State<SeaLevel> {






 Map<String, dynamic>? _Weatherdata;
  final WeatherService _weatherServise = WeatherService();
  String city = '';
  bool _isLoading = false;

  Map<String,dynamic>?getWeatherData(){
    return _Weatherdata;
  }

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // final position =await getCurrentLocation();
      // final data = await _weatherServise.featchWeather(position.latitude,position.longitude);
      final data = await _weatherServise.featchWeather();
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
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 130,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    child: Image.asset(
                      'Materials/tide.png',
                      width: 30,
                      height: 25,
                      color: const Color.fromARGB(170, 255, 255, 255),
                      
                    ),
                  ),
                ),
                const Text(
                  "sea level",
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
         
          
          
            _isLoading?
            
             const Center(child: CircularProgressIndicator()):
             _Weatherdata==null?
              Text("the data not avilable"):

            Center(
            child:Text('${
              // getSeaLevel
                _Weatherdata?['main']['sea_level'].round()
              }',
            style: 
            const TextStyle(fontSize: 30
            ,color: Color.fromARGB(255, 231, 230, 230),
            fontWeight: FontWeight.w700
            ),
             
            ), 
          )
          
        
        ],
      ),
    );
  }
}

*/