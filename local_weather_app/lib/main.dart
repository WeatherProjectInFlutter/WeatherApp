import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

                /*AppBar(

              
              
              
              backgroundColor:Colors.transparent,
                   // Makes the AppBar transparent
              
              
              
              elevation: 0, // Removes the shadow under the AppBar
              toolbarHeight: 110,
              centerTitle: true,
              title: const Text(
                "Amman",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              
              
              
              
              leading: IconButton(
                  //this leading make the icon placed in the left
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 35,
                  )),

            ),*/
                // PreferredSize(
                //     preferredSize: Size.fromHeight(100.0),
                //     child: AppBar(
                //       elevation: 0,
                //       title:const Text(
                //         "Amman",
                //         style: TextStyle(fontSize: 30, color: Colors.white),
                //       ),
                //       centerTitle: true,

                //       leading: IconButton(
                //           onPressed: () => {},
                //           icon: const Icon(
                //             Icons.menu,
                //             color: Colors.white,
                //             size: 35,
                //           )),
                //           backgroundColor:Color.fromARGB(255, 64, 83, 211) ,
                //       // flexibleSpace: Container(
                //       //   decoration: const BoxDecoration(
                //       //       gradient: LinearGradient(
                //       //     begin: Alignment.bottomCenter,
                //       //     end: Alignment.topCenter,
                //       //     colors: [
                //       //       Color(0xFF3A4ED0), // Start color (blue)
                //       //       Color(0xFF6C92F2), // End color (lighter blue)
                //       //     ],
                //       //   )),
                //       // ),
                //     )),






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

                    const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 50)),
                        Text(
                          "Mostly Cloudy",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )
                      ],
                    ),

                    //This block is for the today weather (over 24 hour)
                    const TodayWeaterWindow(),

                    //this block is for the weekly weather (7 days)
                    const WeekWeatherBlock(),

                    const WindSpeedAndSeaLevel(),
                  ],
                ),
              ),
            )));
  }
}

class TodayWeaterWindow extends StatelessWidget {
  const TodayWeaterWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      padding: const EdgeInsets.all(20),
      height: 170,
      //This for make the decoration for the block
      decoration: BoxDecoration(
          color: const Color.fromARGB(124, 207, 216, 220),
          borderRadius: BorderRadius.circular(20)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //this to make the header text in the block
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "The weather for the next 24 hour",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          Divider(
            //this to make line inside the block
            color: Colors.white38,
            thickness: 2.0,
          )
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
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "The weather for this week",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white38,
            thickness: 2.0,
          )
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Wind speed",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          Divider(
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Wind speed",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 237, 237, 237)),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white38,
            thickness: 2.0,
          )
        ],
      ),
    );
  }
}

class CurrentWeatherSection extends StatelessWidget {
  const CurrentWeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 30)),
        const Text(
          "24°",
          style: TextStyle(
            color: Colors.white,
            fontSize: 140,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset("Materials/sunny.png", width: 140, height: 140),
        )
      ],
    );
  }
}
