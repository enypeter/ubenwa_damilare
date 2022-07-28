import 'dart:convert';

import '../views/widgets/snackbar.dart';
import 'api_docs.dart';
import 'internet_services.dart';

class ApiScheme {
  static initialisePostRequest(
      {required Map<String, dynamic> data,
      isNewBorn,
      required String url,
      token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response = await ApiDocs.makePostRequest(
            url: url, data: data, token: token, isNewBorn: isNewBorn);
        var body = jsonDecode(response.body);
        if (body['errors'] == null) {
          return body;
        } else {
          return ApiDocs.handleError(body['errors']);
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return  'Check your internet connection';
    }
  }

  static initialiseGetRequest({data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response = await ApiDocs.makeGetRequest(url: url, token: token);
        var body = jsonDecode(response.body);
        if (body['errors'] == null) {
          return body;
        } else {
          return ApiDocs.handleError(body['errors']);
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return  'Check your internet connection';
    }
  }
}
