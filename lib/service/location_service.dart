import 'dart:async';
//import 'dart:html';
import 'package:location/location.dart';
import 'package:trackingbwa_v2/model/user_location.dart';
import 'package:trackingbwa_v2/service/user_location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
  StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamController.add(UserLocation(
                latitude: locationData.latitude,
                longtitude: locationData.longitude));
          }
        });
      }
    });
  }

  void dispose() => _locationStreamController.close();
}
