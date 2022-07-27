import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';


class InternetServices {

  static final Duration _CONNECTIVITY_TIMEOUT = Duration(seconds: 5);

  static Future<bool> checkConnectivity() async {
    try {
      ConnectivityResult conn = await Connectivity().checkConnectivity();
      if (conn != ConnectivityResult.wifi && conn != ConnectivityResult.mobile) {
        return false;
      }
      final result = await InternetAddress.lookup('google.com').timeout(_CONNECTIVITY_TIMEOUT);
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty == true) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }






}
