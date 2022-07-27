import 'package:get/get.dart';

import '../model/model.dart';

class UserController extends GetxController{
  UserModel? user;
  var token;

  UserModel? getUser() {
    return user;
  }

  getToken() {
    return this.token;
  }

  setUserDetails(response) async {
    UserModel user = UserModel.fromJson(response);
    this.user = user;
  }

  setToken(token)async{
    this.token = token;
  }
}