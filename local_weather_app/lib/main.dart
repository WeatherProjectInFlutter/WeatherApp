import 'package:flutter/material.dart';
import 'package:local_weather_app/CurrentWeatherUI.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:local_weather_app/WeekWeatherUI.dart';
import 'package:local_weather_app/seaLivelAndWindSpeed.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => WeatherProvider()..featchData(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//comment for example
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final Weatherdata = weatherProvider.currentWeather;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
              title: const Text("Amman",style:TextStyle(color: Colors.white),),
              // title: weatherProvider.isLoding
              //     ? const Center(child: CircularProgressIndicator())
              //     : Weatherdata == null
              //         ? const Text(
              //             "Data is not available",
              //             style: TextStyle(fontSize: 20, color: Colors.white),
              //           )
              //         : Text(
              //             "${Weatherdata['location']['name']}",
              //             style: const TextStyle(
              //                 fontSize: 30, color: Colors.white),
              //           ),
              centerTitle: true,

              //To change the color and the size for the menu icon :
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 35,
              ),

              backgroundColor: const Color.fromARGB(255, 64, 83, 211),
            ),

            //To make the drawer in the menu icon in the appbar
            drawer: Drawer(
              backgroundColor: Colors.white,
              width: 350,
              //we use the builder becuse the context point to the my app and my app not in the
              //Navigator so we need to make the context point to the drawer like this
              child: Builder(
                builder: (context) => ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.arrow_back_rounded),
                      iconColor: const Color.fromARGB(255, 98, 154, 200),
                      onTap: () {
                        //to back when I click in the back arrow
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 20, bottom: 40),
                      child: const TextField(
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            label: Text('city name'),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
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
      margin: const EdgeInsets.fromLTRB(
          15, 50, 15, 0), // Adds margin outside the container
      padding: const EdgeInsets.fromLTRB(
          20, 10, 20, 10), // Adds padding inside the container
      height: 170, // Fixed height for the container
      decoration: BoxDecoration(
        // Adds a background color and rounded corners to the container
        color: const Color.fromARGB(124, 207, 216, 200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Aligns children to the start horizontally
        children: [
          // The scrollable weather forecast row
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Row(
                // Generate multiple weather columns dynamically
                children: List.generate(
                  10,
                  (index) => Padding(
                    // Number of weather columns (10 in this example)
                    padding: const EdgeInsets.fromLTRB(
                        15, 15, 15, 15), // Space between columns
                    child: Column(
                      children: [
                        // Displays the hour dynamically based on the index
                        Text(
                          "${5 + index} pm", // Example: "5 pm", "6 pm", etc.
                          style: const TextStyle(
                              color: Colors.white54), // Light gray text
                        ),
                        // Displays an icon for the weather
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0,
                                0)), //padding between the elements in the columns
                        const Image(
                          image: AssetImage(
                              "Materials/heavy-rain.png"), // Weather icon image
                          width: 30,
                          height: 30,
                        ),
                        // Displays the temperature
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        const Text(
                          "18°", // Example temperature
                          style: TextStyle(
                              color: Colors.white54), // Light gray text
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

// class WeekWeatherBlock extends StatelessWidget {
//   const WeekWeatherBlock({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
//       padding: const EdgeInsets.all(20),
//       height: 320,
//       decoration: BoxDecoration(
//           color: const Color.fromARGB(124, 207, 216, 220),
//           borderRadius: BorderRadius.circular(20)),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
//           //   child: Row(
//           //     children: [
//           //       Text(
//           //         "The weather for this week",
//           //         style: TextStyle(
//           //             fontSize: 18,
//           //             fontWeight: FontWeight.w500,
//           //             color: Color.fromARGB(255, 237, 237, 237)),
//           //       )
//           //     ],
//           //   ),
//           // ),

//           // Divider(
//           //   color: Colors.white38,
//           //   thickness: 2.0,
//           // )

//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//           Row(
//             children: [],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WindSpeedAndSeaLevel extends StatelessWidget {
//   const WindSpeedAndSeaLevel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [ WindSpeed(), SeaLevel()],
//     );
//   }
// }

// class WindSpeed extends StatelessWidget {
//   const WindSpeed(weatherServise, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
//       padding: const EdgeInsets.all(20),
//       height: 130,
//       decoration: BoxDecoration(
//           color: const Color.fromARGB(124, 207, 216, 220),
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 5.0),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 9.0),
//                   child: Container(
//                       child: Image.asset(
//                     "Materials/windy.png",
//                     width: 30,
//                     height: 35,
//                     color: Colors.white,
//                   )),
//                 ),
//                 const Text(
//                   "Wind",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       color: Color.fromARGB(255, 237, 237, 237)),
//                 )
//               ],
//             ),
//           ),
//           const Divider(
//             color: Colors.white38,
//             thickness: 2.0,
//           )
//         ],
//       ),
//     );
//   }
// }
/*
class SeaLevel extends StatelessWidget {

   SeaLevel(weatherdata, {super.key});
  // final CurrentWeatherSection weatherData=CurrentWeatherSection();

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
*/

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

