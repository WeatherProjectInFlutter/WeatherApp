// import 'package:flutter/material.dart';
// import 'weather_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WeatherScreen(),
//     );
//   }
// }

// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   final WeatherService _weatherService = WeatherService();
//   String _city = 'Amman'; // Default city
//   Map<String, dynamic>? _weatherData;
//   bool _isLoading = false;

//   void _getWeather() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final data = await _weatherService.fetchWeather(_city);
//       setState(() {
//         _weatherData = data;
//       });
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getWeather();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : _weatherData == null
//                 ? const Text('No data available')
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'City: ${_weatherData!['name']}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         'Temperature: ${_weatherData!['main']['temp']}°C',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         'Weather: ${_weatherData!['weather'][0]['description']}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ],
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getWeather,
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
