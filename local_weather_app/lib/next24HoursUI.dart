import 'package:flutter/material.dart';
import 'package:local_weather_app/next24HoursService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


  class next24HoursSection extends StatefulWidget {
  const next24HoursSection({super.key});

  @override
  State<next24HoursSection> createState() => _next24HoursSectionState();
}

class _next24HoursSectionState extends State<next24HoursSection> {
  final double lat=31.9544; //example latitude
  final double lon=35.9106; //example longitde
  final weatherService _weatherService=weatherService();  
  Map<String,dynamic>? _Weatherdata;
  bool _isLoading=false;

void _getWeather() async{
  setState(() {
    _isLoading=true;
  });

  try{
        // Fetch hourly weather data
    final data=await _weatherService.fetchHourlyWeather(lat, lon);

        // Extract the hourly weather data
    setState(() {
      _Weatherdata=data; //store the full response  
    });
  } catch(e){
      throw Exception("Error:$e");
  } finally{
      setState(() {
        _isLoading=false;
      });
  }
}

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 15.0), // Space between columns
                    child: Column(
                      children: [
                        // Displays the hour dynamically based on the index
                        Text(
                          "${5 + index} pm", // Example: "5 pm", "6 pm", etc.
                          style: const TextStyle(color: Colors.white54), // Light gray text
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        // Displays an icon for the weather
                        const Image(
                          image: AssetImage("Materials/heavy-rain.png"), // Weather icon image
                          width: 30,
                          height: 30,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),

                        // Displays the temperature
                        const Text(
                          "18°", // Example temperature
                          style: TextStyle(color: Colors.white54), // Light gray text
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