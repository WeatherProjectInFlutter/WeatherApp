import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:local_weather_app/GetCurrentLocation.dart';
import 'package:local_weather_app/WeatherProvider.dart';
// import 'package:local_weather_app/WeekAndDayService.dart';
import 'package:provider/provider.dart';

class WeekWeatherBlock extends StatelessWidget {
  const WeekWeatherBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final WeekWeather = weatherProvider.weeklyWeather;
    if (WeekWeather == null) {
      return const Center(child: Text('No data available'));
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out items in the Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(7, (index) {
                // Generate rows dynamically for 7 days
                return Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 0 : 20), // Space between rows
                  child: Row(
                    children: [
                      // Low temperature
                      Container(
                        child: Text(
                          "${WeekWeather?['data'][index]['low_temp'].round()}°",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      // High temperature
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${WeekWeather?['data'][index]['high_temp'].round()}°",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      // Icon 1
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Image.asset(
                          'Materials/night-moon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      // Icon 2
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'Materials/sunny.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      // Humidity
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Image.asset(
                              'Materials/humidity-icon.png', // Replace with your humidity icon
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(
                                width: 5), // Spacing between icon and text
                            Text(
                              "${WeekWeather?['data'][index]['rh']}%", // Humidity value
                              style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // Day name
                      Container(
                        margin: const EdgeInsets.only(left: 40),
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
                                textAlign: TextAlign.end,
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

/*

          Row(
            children: [
              weatherProvider.isLoding
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : WeekWeather == null
                      ? const Text("The data is not avilable")
                      : 
              Container(
                          child: Text(
                            "${
                            // convertToInt
                            WeekWeather?['data'][0]['low_temp'].round()}°",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "${WeekWeather?['data'][0]['high_temp'].round()}°",
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
                child: Text(
                  "${WeekWeather?['data'][0]['rh']}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(left: 40),
                margin: const EdgeInsets.only(left: 40),
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
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][1]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][1]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][1]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][1]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][2]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][2]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][2]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][2]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][3]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][3]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][3]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][3]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][4]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][4]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][4]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][4]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][5]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][5]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][5]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][5]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "${
                    // convertToInt
                    WeekWeather?['data'][6]['low_temp'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['data'][6]['high_temp'].round()}°",
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
                  child: Text(
                    "${WeekWeather?['data'][6]['rh']}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: FutureBuilder<String>(
                    future: () async {
                      final date =
                          WeekWeather?['data'][6]['datetime'];
                      print("Date from API: $date");

                      return getDayName(date);
                    }(),
                    //snapsot : it will give me a state of the api call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("************ loding");

                        return const Text("Loading...");
                      } else if (snapshot.hasError) {
                        print("************* Erorr: ${snapshot.error}");
                        return const Text("Error...");
                      } else if (snapshot.hasData) {
                        print("************ Sucses");
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        print("************ No data available");
                        return const Text("wait...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),


    
        */
  }
}
