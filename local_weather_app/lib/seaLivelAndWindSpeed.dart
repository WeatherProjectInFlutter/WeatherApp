import 'package:flutter/material.dart';
import 'package:local_weather_app/seaLivel.dart';
import 'package:local_weather_app/windSpeed.dart';

class WindSpeedAndSeaLevel extends StatefulWidget {
  const WindSpeedAndSeaLevel({super.key});

  @override
  State<WindSpeedAndSeaLevel> createState() => _WindSpeedAndSeaLevelState();
}

class _WindSpeedAndSeaLevelState extends State<WindSpeedAndSeaLevel> {

 
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ WindSpeed(), SeaLevel()],
    );
  }
}