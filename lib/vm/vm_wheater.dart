import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheather_app/common/app_const.dart';
import 'package:wheather_app/model/model_wheather.dart';
import 'package:wheather_app/services/web_services.dart';

class VmWheather with ChangeNotifier {
  ModelWheather wheatherData;
  requestResponseState responseState = requestResponseState.Loading;

  Future<void> getData() async {
    String api = 'http://api.openweathermap.org/data/2.5/forecast';
    String appId = '09c698e79d6e9c2a91fd987397e6b041';
    Position position;
    position = await takeGPSLocation();
    double latitude = position.latitude;
    double longitude = position.longitude;
    String url = "$api?lat=$latitude&lon=$longitude&APPID=$appId";
    try {
      responseState = requestResponseState.Loading;
      var resData = await getRequest(url: url);
      wheatherData = modelWheatherFromJson(resData);
      responseState = requestResponseState.DataReceived;
      notifyListeners();
    } catch (error) {
      responseState = requestResponseState.Error;
      notifyListeners();
      throw error;
    }
  }
}
