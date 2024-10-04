import 'package:chat_app/helpers/todo_helper.dart';

class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? photoUrl;
  String? phoneNumber;
  List<UserModel> allFriend = [];

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  }) {
    load();
  }

  Future<void> load() async {
    allFriend = await TodoHelper.tHelper.getFriends();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"] ?? "Undefined",
        displayName: json["displayName"] ?? "Guest",
        photoUrl: json["photoURL"] ??
            "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
        phoneNumber: json["phoneNumber"] ?? "Undefined",
      );

  Map<String, dynamic> get toJson => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "photoURL": photoUrl,
        "phoneNumber": phoneNumber,
      };
}
