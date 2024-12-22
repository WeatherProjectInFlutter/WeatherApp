import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:local_weather_app/next24HoursService.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:provider/provider.dart';
import 'WeatherProvider.dart';

  class Next24hours extends StatelessWidget {
  const Next24hours({super.key});

 

  @override
  Widget build(BuildContext context) {
    final weatherProvider=Provider.of<WeatherProvider>(context);
    final hourlyWeather=weatherProvider.hourlyWeather;

    
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0), // Adds margin outside the container
      padding: const EdgeInsets.all(20), // Adds padding inside the container
      height: 170, // Fixed height for the container
      decoration: BoxDecoration(
        // Adds a background color and rounded corners to the container
        color: const Color.fromARGB(124, 207, 216, 200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start horizontally
        children: [
          // The scrollable weather forecast row
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Row(
                // Generate multiple weather columns dynamically
                children: List.generate(24,(index) => Padding(   // Number of weather columns (10 in this example)
                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Space between columns
                    child: Column(
                      children: [
                        // Displays the hour dynamically based on the index
                        Text(
                          "${hourlyWeather?['forecast']['forecastday'][0]['hour'][index]['time'].split(' ')[1]}", // Example: "5 pm", "6 pm", etc.
                          style: const TextStyle(color: Colors.white), // Light gray text
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        // Displays an icon for the weather
                        
                        //to change the default API night 
                        (hourlyWeather?['forecast']['forecastday'][0]['hour'][index]['condition']['icon']=="//cdn.weatherapi.com/weather/64x64/night/113.png")?
                        Image.asset("Materials/night-moon.png",width: 45,height: 45,):

                        (hourlyWeather?['forecast']['forecastday'][0]['hour'][index]['condition']['icon']=="//cdn.weatherapi.com/weather/64x64/night/116.png")?
                        Image.asset("Materials/heavycloud.png",width: 45,height: 45,):
      
                        Image.network(
                                'https:${hourlyWeather?['forecast']['forecastday'][0]['hour'][index]['condition']['icon']}', // Weather icon
                                width: 45,
                                height: 45,),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),

                        // Displays the temperature
                          Text(
                          "${hourlyWeather?['forecast']['forecastday'][0]['hour'][index]['temp_c'].round()} C°", // Example temperature
                          style: const TextStyle(color: Colors.white), // Light gray text
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } 
}