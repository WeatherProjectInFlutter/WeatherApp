import 'package:flutter/material.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:provider/provider.dart';

class WeekWeatherBlock extends StatelessWidget {
  const WeekWeatherBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final WeekWeather = weatherProvider.weeklyWeather;

    Future<String> getDayName(String? s) async {
      List<String> weekdays = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ];
      // await Future.delayed(const Duration(seconds: 3));
      if (s == null || s.isEmpty) {
        throw ArgumentError("Date string cannot be null or empty");
      }

      try {
        List<String> l1 = s.split('-');
        List<int> l2 = l1.map(int.parse).toList();
        DateTime date = DateTime(l2[0], l2[1], l2[2]);
        return weekdays[date.weekday - 1];
      } catch (e) {
        throw Exception(e);
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 320,
      decoration: BoxDecoration(
        color: const Color.fromARGB(124, 207, 216, 220),
        borderRadius: BorderRadius.circular(20),
      ),
      child: weatherProvider.isLoding
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(7, (index) {
                // Generate rows dynamically for 7 days
                return Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 0 : 20), // Space between rows
                  child: Row(
                    children: [
                      // Low temperature
                      SizedBox(
                        width: 40, // Fixed width
                        child: Text(
                          "${WeekWeather?['data'][index]['low_temp'].round()}°",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // High temperature
                      SizedBox(
                        width: 40, // Fixed width
                        child: Text(
                          "${WeekWeather?['data'][index]['high_temp'].round()}°",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Icon 1
                      SizedBox(
                        width: 30, // Fixed width
                        child: Image.asset(
                          'Materials/night-moon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      // Icon 2
                      SizedBox(
                        width: 30, // Fixed width
                        child: Image.asset(
                          'Materials/sunny.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      // Humidity
                      SizedBox(
                        width: 70, // Fixed width
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'Materials/humidity-icon.png',
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${WeekWeather?['data'][index]['rh']}%",
                              style: const TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Day name
                      SizedBox(
                        width: 90, // Fixed width
                        child: FutureBuilder<String>(
                          future: () async {
                            final date =
                                WeekWeather?['data'][index]['datetime'];
                            return getDayName(date);
                          }(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading...");
                            } else if (snapshot.hasError) {
                              return const Text("Error...");
                            } else if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text("wait...");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
    );
  }
}
