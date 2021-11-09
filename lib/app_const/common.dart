import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// enum for server request
enum requestResponseState { Error, DataReceived, Loading }

const defaultPadding = 16.0;
const defaultPaddingTwo = 8.0;
const defaultHeightSmall = 10.0;
const defaultHeightMedium = 20.0;
const defaultHeightLarge = 30.0;

const defaultWidthSmall = 10.0;
const defaultWidthMedium = 20.0;
const defaultWidthLarge = 30.0;

// get current location
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
