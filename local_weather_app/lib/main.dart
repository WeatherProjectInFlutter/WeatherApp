import 'package:flutter/material.dart';
import 'package:local_weather_app/CurrentWeatherUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//comment for example
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 64, 89, 188)),
          //  primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: Scaffold(
            extendBodyBehindAppBar:
                true, // Allows the body to extend behind the AppBar, to make body&appbar in the same color without borders
            appBar:
                //update the appbar

                AppBar(
              elevation: 0,
              title: const Text(
                "Amman",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 35,
                  )),
              backgroundColor: Color.fromARGB(255, 64, 83, 211),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 170,
                    bottom:
                        100), // Prevents content from overlapping the AppBar

                //All the code till the end of box decoration is for make the background as a gradient
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3A4ED0), // Start color (blue)
                      Color(0xFF6C92F2), // End color (lighter blue)
                    ],
                  ),
                ),
                child: const Column(
                  children: [
                    //The current weather widget :
                    CurrentWeatherSection(),
                    // CurrentWeatherSection(),

                    // Row(
                    //   children: [
                    //     Padding(padding: EdgeInsets.only(left: 50)),
                    //     Text(
                    //       "Mostly Cloudy",
                    //       style: TextStyle(color: Colors.white, fontSize: 19),
                    //     )
                    //   ],
                    // ),

                    //This block is for the today weather (over 24 hour)

                    TodayWeatherWindow(),

                    //this block is for the weekly weather (7 days)
                    WeekWeatherBlock(),

                    WindSpeedAndSeaLevel(),
                  ],
                ),
              ),
            )));
  }
}



class TodayWeatherWindow extends StatelessWidget {
  const TodayWeatherWindow({super.key});

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
          // Header for the weather section
          const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0), // Adds padding to the left
            child: Row(
              children: [
                Text(
                  "The weather for the next 24 hours", // Header text
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 237, 237, 237), // Light gray color
                  ),
                )
              ],
            ),
          ),
          const Divider(
            // A horizontal line to separate the header from the content
            color: Colors.white38,
            thickness: 1.5,
          ),

          // The scrollable weather forecast row
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Row(
                // Generate multiple weather columns dynamically
                children: List.generate(10,(index) => Padding(   // Number of weather columns (10 in this example)
                    padding: const EdgeInsets.symmetric(horizontal: 15.0), // Space between columns
                    child: Column(
                      children: [
                        // Displays the hour dynamically based on the index
                        Text(
                          "${5 + index} pm", // Example: "5 pm", "6 pm", etc.
                          style: const TextStyle(color: Colors.white54), // Light gray text
                        ),
                        // Displays an icon for the weather
                        const Image(
                          image: AssetImage("Materials/heavy-rain.png"), // Weather icon image
                          width: 30,
                          height: 30,
                        ),
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

class WeekWeatherBlock extends StatelessWidget {
  const WeekWeatherBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
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
        ],
      ),
    );
  }
}

class WindSpeedAndSeaLevel extends StatelessWidget {
  const WindSpeedAndSeaLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [WindSpeed(), SeaLevel()],
    );
  }
}

class WindSpeed extends StatelessWidget {
  const WindSpeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 130,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                      child: Image.asset(
                    "Materials/windy.png",
                    width: 30,
                    height: 35,
                    color: Colors.white,
                  )),
                ),
                const Text(
                  "Wind",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white38,
            thickness: 2.0,
          )
        ],
      ),
    );
  }
}

class SeaLevel extends StatelessWidget {
  const SeaLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 130,
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    child: Image.asset(
                      'Materials/tide.png',
                      width: 30,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "sea level",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white38,
            thickness: 2.0,
          )
        ],
      ),
    );
  }
}

// class CurrentWeatherSection extends StatefulWidget {
//   const CurrentWeatherSection({super.key});

  //   @override
//   State<CurrentWeatherSection> createState() => _CurrentWeatherSectionState();
// }

// class _CurrentWeatherSectionState extends State<CurrentWeatherSection> {
//   @override
//   Widget build(BuildContext context) {
//     return 
// }
// }
