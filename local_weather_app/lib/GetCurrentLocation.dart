
import 'package:geolocator/geolocator.dart' show Geolocator, LocationPermission, Position;

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Request permission
  //Checks if the app has permission to access the user's location
  permission = await Geolocator.checkPermission();

  //If permission is denied, it requests permission using requestPermission
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    

  // If permission is still denied or denied permanently:
  // Returns an error stating that permissions are denied or permanently denied.

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }

  // Get the current location
  return await Geolocator.getCurrentPosition();
}


