import 'package:chat_app/appRoutes/app_routes.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/todo_helper.dart';
import 'package:flutter/material.dart';

class GuestLogInPage extends StatelessWidget {
  const GuestLogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.instance.logIn,
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      TodoHelper.tHelper
                          .addUser(
                            user: AuthHelper.instance.auth.currentUser!,
                          )
                          .then(
                            (value) => AuthHelper.instance
                                .anonymousLogIn()
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("You are logged in as guest"),
                                ),
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.instance.home,
                              );
                            }),
                          );
                    },
                    child: Container(
                      height: s.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("Guest"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
