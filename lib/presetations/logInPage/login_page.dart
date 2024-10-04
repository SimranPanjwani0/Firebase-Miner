import 'package:chat_app/appRoutes/app_routes.dart';
import 'package:chat_app/extensions.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/todo_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            250.h,
            const Text(
              "LogIn",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            40.h,
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                labelText: 'Email',
              ),
            ),
            20.h,
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                labelText: 'Password',
              ),
            ),
            30.h,
            ElevatedButton(
              onPressed: () async {
                AuthHelper.instance
                    .signIn(
                        email: emailController.text,
                        password: passwordController.text)
                    .then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Sign In Successfully !!!",
                        ),
                      ),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoutes.instance.home,
                    );
                  },
                );

                // TodoHelper.tHelper.addUser(user: user).
                //
                // if (user != null) {
                //
                // }
              },
              child: const Text("LogIn"),
            ),
            5.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.instance.signUp,
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            15.h,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    height: 2,
                  ),
                ),
                Text("   Or LogIn with    "),
                Expanded(
                  child: Divider(
                    height: 2,
                  ),
                ),
              ],
            ),
            10.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    UserCredential userCredential =
                        await AuthHelper.instance.signInWithGoogle();

                    User? user = userCredential.user;
                    if (user != null) {
                      TodoHelper.tHelper.addUser(user: user).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Sign In Successfully !!!",
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.g_mobiledata_rounded,
                    size: 40,
                    color: Colors.blue,
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
