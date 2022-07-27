import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.userConsent,
  required this.isActiveListening,
  required this.newborn,
  });

  String firstName;
  String lastName;
  String email;
  bool userConsent;
  bool isActiveListening;
  dynamic newborn;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    userConsent: json["user_consent"],
    isActiveListening: json["is_active_listening"],
    newborn: json["newborn"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "user_consent": userConsent,
    "is_active_listening": isActiveListening,
    "newborn": newborn,
  };
}
