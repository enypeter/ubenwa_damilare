import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_docs.dart';
import 'api_scheme.dart';

class NewBornServices {
  static createNewBorn() async {
    var data = {
      "data": {
        "type": "newborns",
        "attributes": {
          "name": 'Alake James',
          "gestation": '6',
          "gender": 'male'
        }
      }
    };
    var isEnabled =
    await const FlutterSecureStorage().read(key: "enableBackground");
    log('$isEnabled');

    if (isEnabled == 'true') {
    var token = await const FlutterSecureStorage().read(key: "token");
    return await ApiScheme.initialisePostRequest(
        url: ApiDocs.newBornUrl, data: data, token: token, isNewBorn: true);}
  }

  static getNewBorn() async {
    var token = await const FlutterSecureStorage().read(key: "token");
    return await ApiScheme.initialiseGetRequest(
        url: ApiDocs.newBornUrl, token: token);
  }
}
