import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/todo_helper.dart';
import 'package:chat_app/modals/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUserPage extends StatelessWidget {
  const AllUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Friends"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: TodoHelper.tHelper.getAllUsers(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List<UserModel> allUser = [];
            if (snapshot.hasData) {
              allUser = snapshot.data?.docs
                      .map(
                        (e) => UserModel.fromJson(
                          e.data() as Map<String, dynamic>,
                        ),
                      )
                      .toList() ??
                  [];
            }
            allUser.removeWhere((element) =>
                element.uid == AuthHelper.instance.auth.currentUser!.uid);

            return ListView.builder(
              itemCount: allUser.length,
              itemBuilder: (context, index) {
                UserModel user = allUser[index];
                return ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(
                      user.photoUrl ??
                          "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
                    ),
                  ),
                  title: Text(user.displayName ?? "Guest"),
                  subtitle: Text(user.email ?? "Undefined"),
                  trailing: OutlinedButton(
                    onPressed: () {
                      TodoHelper.tHelper.addFriend(userModel: user);
                    },
                    child: const Text(
                      "Add Friend",
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
