import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiDocs {
  static String baseUrl = 'https://ubenwa-cat-api-stage.herokuapp.com/api/v1';
  static String loginUrl = '$baseUrl/login';
  static String signUpUrl = '$baseUrl/signup';
  static String forgotPasswordUrl = '$baseUrl/password/forgot';
  static String changePasswordUrl = '$baseUrl/password/change';

  static makePostRequest({url, data, token}) async {
    final uri = Uri.parse(url);
    final jsonString = json.encode(data);
    var headers;

    if (token == null) {
      print('AUTH NULL');
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.post(uri, body: jsonString, headers: headers);
  }

  static makePatchRequest({url, data, token}) async {
    final uri = Uri.parse(url);
    final jsonString = json.encode(data);
    var headers;

    if (token == null) {

      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.patch(uri, body: jsonString, headers: headers);
  }

  static makePutRequest({url, data, token}) async {
    final uri = Uri.parse(url);
    final jsonString = json.encode(data);
    var headers;

    if (token == null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.put(uri, body: jsonString, headers: headers);
  }

  static makeDeleteRequest({url, data, token}) async {
    final uri = Uri.parse(url);
    final jsonString = json.encode(data);
    var headers;

    if (token == null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.delete(uri, body: jsonString, headers: headers);
  }

  static makeGetRequest({url, token}) async {
    var uri = Uri.parse(url);
    var headers;
    if (token == null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.get(uri, headers: headers);
  }

  static isRequestSuccessful(int? statusCode) {
    return statusCode! >= 200 && statusCode < 300;
  }

  static handleError( error) {
    switch (error[0]['status']) {
      case 400:
        throw error[0]['detail'];

      case 401:
        throw 'Unauthorized - ${error[0]['detail']}';

      case 403:
        throw 'Forbidden - ${error[0]['detail']}';

      case 404:
        throw 'Not found - ${error[0]['detail']}';

      case 422:
        throw 'Unable to process - ${error[0]['detail']}';

      case 500:
        throw 'Server - ${error[0]['detail']}';
      default:
        throw 'Error occurred try again';
    }
  }
}
