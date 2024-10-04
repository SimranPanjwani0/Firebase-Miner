import 'package:chat_app/appRoutes/app_routes.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/todo_helper.dart';
import 'package:chat_app/modals/user_model.dart';
import 'package:flutter/material.dart';

class AllFriends extends StatefulWidget {
  const AllFriends({super.key});

  @override
  State<AllFriends> createState() => _AllFriendsState();
}

class _AllFriendsState extends State<AllFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AuthHelper.instance.auth.currentUser!.email?.split('@')[0]
            as String),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: StreamBuilder(
                stream: TodoHelper.tHelper.getFriendsStream(),
                builder: (context, snapshot) {
                  List<UserModel> allFriend = snapshot.data?.docs
                          .map(
                            (e) => UserModel.fromJson(e.data()),
                          )
                          .toList() ??
                      [];
                  return allFriend.isEmpty
                      ? const Center(
                          child: Text("You don't have any friend"),
                        )
                      : GestureDetector(
                          onLongPress: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => BottomSheet(
                                onClosing: () {},
                                builder: (context) => Container(
                                  height: 500,
                                  width: 500,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(),
                                      const CircleAvatar(
                                        backgroundColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ListView.builder(
                            itemCount: allFriend.length,
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.instance.chatPage,
                                    arguments: allFriend[index],
                                  );
                                },
                                leading: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    allFriend[index].photoUrl ??
                                        "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
                                  ),
                                ),
                                title: Text(
                                  allFriend[index].email?.split("@")[0] ??
                                      "Guest",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    TodoHelper.tHelper.deleteFriend(
                                      userModel: allFriend[index],
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
