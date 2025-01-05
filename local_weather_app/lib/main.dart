import 'package:flutter/material.dart';
import 'package:local_weather_app/CurrentWeatherUI.dart';
import 'package:local_weather_app/WeatherProvider.dart';
import 'package:local_weather_app/WeekWeatherUI.dart';
import 'package:local_weather_app/next24HoursUI.dart';
import 'package:local_weather_app/seaLivelAndWindSpeed.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
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
              elevation: 0, //Removes the shadow below the AppBar for a flat design.

              // title: const Text("Amman",style:TextStyle(color: Colors.white),),

              title: weatherProvider.isLoding
                  ? const Center(child: CircularProgressIndicator())
                  : Weatherdata == null
                      ? const Text(
                          "Data is not available",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      : Text(
                          "${Weatherdata['name']}",
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
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
        // backgroundColor: Colors.white,
        
        
        width: 350,
        child: Builder( // Provides a new context that is specific to the Drawer
          builder: (context) {
            final weatherProvider = Provider.of<WeatherProvider>(context, listen: false); //The listen: false ensures the drawer doesn't rebuild when weatherProvider changes.
            final cityController = TextEditingController(); //A TextEditingController to capture and manage the city name entered in the TextField.



            return ListView( //A scrollable column that holds multiple widgets in the drawer
              children: [
                ListTile( //Represents a single row with content and an action
                  leading: const Icon(Icons.arrow_back_rounded), // Adds an icon on the left of the ListTile
                  iconColor: const Color.fromARGB(255, 98, 154, 200),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextField(
                    controller: cityController, // The cityController binds to the TextField to manage its value.
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration( //Adds styling to the TextField, including a label (City Name) and a border.
                      label: Text('City Name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,5,8,20),
                  child: ElevatedButton( // A button for submitting the city name.
                    onPressed: () async { //when press it :
                      final cityName = cityController.text.trim();
                      if (cityName.isNotEmpty) {
                        final IsCityFound=await weatherProvider.fetchDataByCityName(cityName);
                        if(IsCityFound)
                        {
                        Navigator.pop(context);
                        }
                        else{
                        //this when the user enter invalidci city the daialog error will appear

                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            body: const Center(child: Text(
                                    'There is no city with this name',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),),
                            title: 'This is Ignored',
                            desc:   'This is also Ignored',
                            btnOkOnPress: () {},
                          ).show();

                        } // Close the drawer
                      }
                      else{
                        //this when the user enter null(no input )the daialog error will appear
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            body: const Center(child: Text(
                                    'There is no city enter',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),),
                            title: 'This is Ignored',
                            desc:   'This is also Ignored',
                            btnOkOnPress: () {},
                          ).show();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:const Size(20, 50),
                      backgroundColor: const Color.fromARGB(255, 153, 189, 243),
                      
                    ),
                    child: const Text('Search',style: TextStyle(color:Colors.white,fontSize: 18),),
                    
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Saved Cities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ),
                  
                  //Display saved cities 
                  ...weatherProvider.cities.map((city)=>ListTile( //The ... (spread operator) is used to include these widgets directly into the parent widget (like a Column or ListView).
                            // The map function is used to transform each item in the cities list into a new widget.
                            // The map function takes a callback function as an argument. Here, the callback function is (city) => ListTile(...).
                            //ListTile(...): Each city is transformed into a ListTile widget, which represents a row in the drawer.
                    title:Text(city),
                    onTap: () async{
                      await weatherProvider.fetchDataByCityName(city);
                      Navigator.pop(context);
                    }, 
                  )) 
              ],
            );
          },
        ),
      ),

            //To make a secroll up refreash
            body: RefreshIndicator(
                onRefresh: () async {
                  await weatherProvider.featchData();
                },
                child: SingleChildScrollView(
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


                        //This block is for the today weather (over 24 hour)

                        Next24hours(),

                        //this block is for the weekly weather (7 days)
                        WeekWeatherBlock(),

                        WindSpeedAndSeaLevel(),
                      ],
                    ),
                  ),
                ))));
  }
}

