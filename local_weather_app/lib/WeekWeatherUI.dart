import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeekAndDayService.dart';

class WeekWeatherBlock extends StatefulWidget {
  const WeekWeatherBlock({super.key});

  @override
  State<WeekWeatherBlock> createState() => _WeekWeatherBlockState();
}

class _WeekWeatherBlockState extends State<WeekWeatherBlock> {
  Map<String, dynamic>? WeekWeather;
  final WeekAndDayService weekService = WeekAndDayService();
  bool isLooding = false;

  void getWeekWeather() async {
    setState(() {
      isLooding = true;
    });

    try {
      final position = await getCurrentLocation();
      final data = await weekService.featchWeather(
          position.latitude, position.longitude);
      setState(() {
        WeekWeather = data;
      });
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isLooding = false;
    }

    @override
    void initState() {
      super.initState();
      getWeekWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 320,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          //   child: Row(
          //     children: [
          //       Text(
          //         "The weather for this week",
          //         style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500,
          //             color: Color.fromARGB(255, 237, 237, 237)),
          //       )
          //     ],
          //   ),
          // ),

          // Divider(
          //   color: Colors.white38,
          //   thickness: 2.0,
          // )

          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Row(
            children: [],
          ),
          Text(),
        ],
      ),
    );
  }
}
