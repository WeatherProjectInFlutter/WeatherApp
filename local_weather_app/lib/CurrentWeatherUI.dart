import 'package:flutter/material.dart';
import 'package:local_weather_app/curent_weather_service.dart';





class CurrentWeatherSection extends StatefulWidget {
  const CurrentWeatherSection({super.key});

  @override
  State<CurrentWeatherSection> createState() => _CurrentWeatherSectionState();
}

class _CurrentWeatherSectionState extends State<CurrentWeatherSection> {
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

  int getCurentTemp(double val) {
    return val.round();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


       


        Row(children: [
          const Padding(padding: EdgeInsets.only(left: 25)),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _Weatherdata == null
                  ? const Text("The data is not avilable")
                  : Text(
                      '${getCurentTemp(_Weatherdata!['main']['temp'])}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 140,
                      ),
                    ),
          Container(
            padding:
                const EdgeInsets.only(left: 5), //هاي على التلفون بتخرب الصورة
            child: Image.asset("Materials/sunny.png", width: 140, height: 140),
          ),
        ]),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 50)),
            Text(
              '${_Weatherdata?['weather'][0]['description']}',
              style: TextStyle(color: Colors.white, fontSize: 23),
            )
          ],
        ),

         Row(
                 
                 textDirection: TextDirection.rtl,
                 children:[
                 // const Size(2, 2),
                 Padding(
                   padding: const EdgeInsets.only(right: 40.0),
                   child: SizedBox(
                    
                    width: 30,
                    height: 30,
                     child: FloatingActionButton(
                     onPressed: _getWeather,
                     shape: CircleBorder(),
                    //  backgroundColor: Color.fromARGB(255, 99, 134, 225),
                     
                     backgroundColor:const Color.fromARGB(255, 96, 114, 233),
                     child: Icon(Icons.refresh_sharp,),
                     foregroundColor: Colors.black,
                     
                     ),
                   ),
                 ),
                 ]
                 ),

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







            