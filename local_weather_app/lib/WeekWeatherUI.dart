import 'package:flutter/material.dart';
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
      print(data);
      setState(() {
        WeekWeather = data;
      });
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      setState(() {
        isLooding = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeekWeather();
  }

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
    await Future.delayed(const Duration(seconds: 3));
    List<String> l1 = s!.split('-');
    List<int> l2 = l1.map(int.parse).toList();
    DateTime date = DateTime(l2[0], l2[1], l2[2]);
    return weekdays[date.weekday - 1];
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
      child: Column(
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
            children: [
              isLooding
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : WeekWeather == null
                      ? const Text("The data is not avilable")
                      : Container(
                          child: Text(
                            "${
                            // convertToInt
                            WeekWeather?['forecast']['forecastday'][0]['day']['mintemp_c'].round()}°",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "${WeekWeather?['forecast']['forecastday'][0]['day']['maxtemp_c'].round()}°",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Image.asset(
                  'Materials/night-moon.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  'Materials/sunny.png',
                  width: 20,
                  height: 20,
                  // style:const TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //     fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: const Text(
                  "20%",
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(left: 40),
                margin: const EdgeInsets.only(left: 80),
                child: const Text(
                  "Today",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                child: Text(
                  "${
                  // convertToInt
                  WeekWeather?['forecast']['forecastday'][1]['day']['mintemp_c'].round()}°",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "${WeekWeather?['forecast']['forecastday'][1]['day']['maxtemp_c'].round()}°",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Image.asset(
                  'Materials/night-moon.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  'Materials/sunny.png',
                  width: 20,
                  height: 20,
                  // style:const TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //     fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: const Text(
                  "20%",
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),

              // Container(
              //   // margin: EdgeInsets.only(left: 40),
              //   margin: const EdgeInsets.only(left: 80),
              //   child:Text(
              //     "${
              //     getDayName(WeekWeather ?['forecast']['forecastday'][1]['date'])
              //     }°"
              //     ,
              //     style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       color: Colors.white,
              //       fontSize: 15,
              //     ),
              //     textAlign: TextAlign.end,
              //   ),
              // ),

              Container(
                margin: const EdgeInsets.only(left: 80),
                child: FutureBuilder<String>(
                  future: getDayName(
                      WeekWeather?['forecast']['forecastday'][0]['date']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading...");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style:const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.end,
                      );
                    } else {
                      return const Text("No data available");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
