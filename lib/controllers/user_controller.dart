import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserController extends GetxController{
  UserModel? user;
  var token;
  var userId;

  UserModel? getUser() {
    return user;
  }


  setUserDetails(response) async {
    UserModel user = UserModel.fromJson(response);
    this.user = user;
  }

  setToken(token)async{
    await const FlutterSecureStorage().write(key:"token", value: token);
    this.token = token;
  }


}