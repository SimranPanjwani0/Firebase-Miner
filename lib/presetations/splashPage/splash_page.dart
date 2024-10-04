import 'package:chat_app/appRoutes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void navigateToLogIn({required BuildContext context}) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.instance.guest,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToLogIn(context: context);
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
