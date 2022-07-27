import 'api_docs.dart';
import 'api_scheme.dart';

class AuthenticationServices {
  static login(email, password) async {
    var data = {"email": email, "password": password};
    return await ApiScheme.initialisePostRequest(
        url: ApiDocs.loginUrl, data: data);
  }

  static register(
      {email, password, firstName, lastName}) async {
    var data = {
      "email": email,
      "password": password,
      "password_confirmation": password,
      "first_name": firstName,
      "last_name": lastName,
    };
    return await ApiScheme.initialisePostRequest(
        url: ApiDocs.signUpUrl, data: data);
  }
}
