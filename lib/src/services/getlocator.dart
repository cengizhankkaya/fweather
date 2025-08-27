import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  // bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Konum izinleri reddedildi');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Konum izinleri kalıcı olarak reddedildi, izin isteyemiyoruz.',
    );
  }

  return await Geolocator.getCurrentPosition();
}
