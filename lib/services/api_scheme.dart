import 'dart:convert';

import '../views/widgets/snackbar.dart';
import 'api_docs.dart';
import 'internet_services.dart';

class ApiScheme {
  static initialisePostRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response =
            await ApiDocs.makePostRequest(url: url, data: data, token: token);
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
      return SnackBars.showErrorSnackBar(
          'No Internet', 'Check your internet connection');
    }
  }

  static initialisePutRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response =
            await ApiDocs.makePutRequest(url: url, data: data, token: token);
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
      return SnackBars.showErrorSnackBar(
          'No Internet', 'Check your internet connection');
    }
  }

  static initialisePatchRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response =
            await ApiDocs.makePatchRequest(url: url, data: data, token: token);
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
      return SnackBars.showErrorSnackBar(
          'No Internet', 'Check your internet connection');
    }
  }

  static initialiseDeleteRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response =
            await ApiDocs.makeDeleteRequest(url: url, data: data, token: token);
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
      return SnackBars.showErrorSnackBar(
          'No Internet', 'Check your internet connection');
    }
  }

  static initialiseGetRequest({data, required String url, token}) async {
    if (await InternetServices.checkConnectivity()) {
      try {
        var response = await ApiDocs.makeGetRequest(url: url, token: token);
        if (ApiDocs.isRequestSuccessful(response.statusCode)) {
          return jsonDecode(response.body);
        } else {
          return ApiDocs.handleError(response);
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return SnackBars.showErrorSnackBar(
          'No Internet', 'Check your internet connection');
    }
  }
}
