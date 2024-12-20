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
    final weatherProvider=Provider.of<WeatherProvider>(context);
    final WeekWeather=weatherProvider.weeklyWeather;
    if ( WeekWeather == null) {
      return Center(child: Text('No data available'));
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
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 320,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              weatherProvider.isLoding
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
                child: Text(
                  "${WeekWeather?['forecast']['forecastday'][0]['day']['avghumidity']}%",
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
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][1]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][1]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][2]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][2]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][2]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][2]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][3]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][3]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][3]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][3]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][4]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][4]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][4]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][4]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][5]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][5]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][5]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][5]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][6]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][6]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][6]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][6]['date'];
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
                        return Text("Error...");
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
        ],
      ),
    );
    
  }
}






/*
class WeekWeatherBlock extends StatefulWidget {
  const WeekWeatherBlock({super.key});

  @override
  State<WeekWeatherBlock> createState() => _WeekWeatherBlockState();
}

class _WeekWeatherBlockState extends State<WeekWeatherBlock> {
  //Map<String, dynamic>? WeekWeather;
  //final WeekAndDayService weekService = WeekAndDayService();
  //bool isLooding = false;
    final weatherProvider = Provider.of<WeatherProvider>(context);

/*
  void getWeekWeather() async {
    setState(() {
      isLooding = true;
    });

    try {
      // final position = await getCurrentLocation();
      // await Future.delayed(Duration(seconds: 2));
      // final data = await weekService.featchWeather(
      //     position.latitude, position.longitude);
      final data = await weekService.featchWeather();
      print(data);
      setState(() {
        WeekWeather = data;
        print(WeekWeather);
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
*/
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
                child: Text(
                  "${WeekWeather?['forecast']['forecastday'][0]['day']['avghumidity']}%",
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
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][1]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][1]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][2]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][2]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][2]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][2]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][3]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][3]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][3]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][3]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][4]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][4]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][4]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][4]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][5]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][5]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][5]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][5]['date'];
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
                        return Text("Error...");
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
                    WeekWeather?['forecast']['forecastday'][6]['day']['mintemp_c'].round()}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${WeekWeather?['forecast']['forecastday'][6]['day']['maxtemp_c'].round()}°",
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
                    "${WeekWeather?['forecast']['forecastday'][6]['day']['avghumidity']}%",
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
                          WeekWeather?['forecast']['forecastday'][6]['date'];
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
                        return Text("Error...");
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
        ],
      ),
    );
  }
}
*/