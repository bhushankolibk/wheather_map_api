import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum requestResponseState { Error, DataReceived, Loading }

Future<dynamic> takeGPSLocation({BuildContext context}) async {
  bool serviceEnabled;
  LocationPermission permission;

  try {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Your mobile GSP is off. Turn on your Mobile GPS.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are permantly denied, we cannot request permissions.');
      }
    }

    return await Geolocator.getCurrentPosition();
  } catch (e) {
    throw e;
  }
}
