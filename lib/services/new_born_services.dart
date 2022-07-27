import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'api_docs.dart';
import 'api_scheme.dart';

class NewBornServices {
  static createNewBorn({name, gestation, gender}) async {
    var data = {
      "data": {
        "type": "newborns",
        "attributes": {"name": name, "gestation": gestation, "gender": gender}
      }
    };
   var token =  await const FlutterSecureStorage().read(key:"token");

    return await ApiScheme.initialisePostRequest(
        url: ApiDocs.newBornUrl, data: data, token: token, isNewBorn: true);
  }

  static getNewBorn(token) async {
    return await ApiScheme.initialiseGetRequest(
        url: ApiDocs.newBornUrl, token: token);
  }
}
