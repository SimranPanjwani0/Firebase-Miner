import 'package:chat_app/presetations/allFriends/allFriends_page.dart';
import 'package:chat_app/presetations/allUserPage/all_user_page.dart';
import 'package:chat_app/presetations/chatPage/chat_page.dart';
import 'package:chat_app/presetations/guestAccountPage/guestAccount_page.dart';
import 'package:chat_app/presetations/homePage/home_page.dart';
import 'package:chat_app/presetations/logInPage/login_page.dart';
import 'package:chat_app/presetations/signUpPage/signup_page.dart';
import 'package:chat_app/presetations/splashPage/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String splash = '/';
  String logIn = 'login';
  String guest = 'guest';
  String signUp = 'signup';
  String home = 'home';
  String allUser = 'allUser';
  String allFriends = 'allFriends';
  String chatPage = 'chatPage';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const SplashPage(),
    'guest': (context) => const GuestLogInPage(),
    'login': (context) => LogInPage(),
    'signup': (context) => SignUpPage(),
    'home': (context) => const HomePage(),
    'allUser': (context) => const AllUserPage(),
    'allFriends': (context) => const AllFriends(),
    'chatPage': (context) => const ChatPage(),
  };
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
}
