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
          useMaterial3: true,
        ),
        home: Scaffold(
            extendBodyBehindAppBar:true, // Allows the body to extend behind the AppBar, to make body&appbar in the same color without borders
            appBar: AppBar(
              backgroundColor: Colors.transparent, // Makes the AppBar transparent
              elevation: 0, // Removes the shadow under the AppBar
              toolbarHeight: 110,
              centerTitle: true,
              title: const Text("Zarqa",style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              leading: IconButton(
                  //this leading make the icon placed in the left
                  onPressed: () {},
                  icon: const Icon(Icons.menu,color: Colors.white,size: 35,)
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 170),// Prevents content from overlapping the AppBar
              
              //All the code till the end of box decoration is for make the background as a gradient
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
              Color(0xFF3A4ED0), // Start color (blue)
              Color(0xFF6C92F2), // End color (lighter blue)
            ],
              ),
              ),
              child:  Column(
                children: [
                  Row(
                    children: [
                      const Padding(padding:EdgeInsets.only(left: 30)),
                      const Text("24°" ,style: TextStyle(color: Colors.white,fontSize: 140,),),
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child:Image.asset("Materials/sunny.png",width: 140,height: 140),
                        )
                    ],
                  ),
                  const Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Text("Mostly Cloudy",style: TextStyle(color: Colors.white,fontSize: 19),)
                    ],
                  )

                ],
              ),
            )
            )
            );
  }
}
