import 'dart:io';

import 'package:chat_app/helpers/todo_helper.dart';
import 'package:chat_app/modals/chat_model.dart';
import 'package:chat_app/modals/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String selected = "";
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    TextEditingController msg = TextEditingController();
    List<Chat> allChat = [];
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email?.split("@")[0] ?? "Guest"),
        actions: [
          const Icon(Icons.call),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.video_call),
          PopupMenuButton(
            onSelected: (val) {
              selected = val;
              setState(() {});
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  setState(() {});
                },
                value: 'Wallpaper',
                child: const Text('Wallpaper'),
              ),
              const PopupMenuItem(
                value: 'Setting',
                child: Text('Setting'),
              ),
              const PopupMenuItem(
                value: 'More',
                child: Text('More'),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_image ?? File('')) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: TodoHelper.tHelper.getChats(userModel: user),
                    builder: (c, s) {
                      if (s.hasData) {
                        allChat = s.data?.docs
                                .map(
                                  (e) => Chat.fromJson(
                                    e.data(),
                                  ),
                                )
                                .toList() ??
                            [];
                        return ListView.builder(
                          itemCount: allChat.length,
                          itemBuilder: (c, i) {
                            Chat chat = allChat[i];
                            if (chat.type == "received") {
                              TodoHelper.tHelper
                                  .seenMsg(user: user, chat: chat);
                            }
                            return Row(
                              mainAxisAlignment: chat.type == "sent"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                  ),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      await TodoHelper.tHelper.deleteChat(
                                        userModel: user,
                                        chat: chat,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            chat.msg,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "${chat.time.hour > 12 ? chat.time.hour - 12 : chat.time.hour.toString()} : ${chat.time.minute.toString()}:${chat.time.second.toString()} ",
                                          ),
                                          Text(
                                            chat.time.hour > 12 ? "PM" : "AM",
                                          ),
                                          Visibility(
                                            visible: chat.type == "sent",
                                            child: Icon(
                                              Icons.done_all_rounded,
                                              color: chat.status == "seen"
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: msg,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.black,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: s.height * 0.3,
                                          padding: const EdgeInsets.all(16),
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                },
                                                child: const Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _pickImage(
                                                      ImageSource.camera);
                                                },
                                                child: const Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.link),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _pickImage(ImageSource.camera);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.camera_alt),
                                ),
                              ],
                            ),
                            hintText: "Enter Message",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (msg.text.toString().isNotEmpty) {
                            TodoHelper.tHelper.chatWithFriend(
                              userModel: user,
                              chat: Chat(
                                DateTime.now(),
                                msg.text,
                                "sent",
                                "Unseen",
                              ),
                            );
                            msg.clear();
                          }
                        },
                        icon: const Icon(Icons.send_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
