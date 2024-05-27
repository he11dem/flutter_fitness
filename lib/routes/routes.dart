import 'package:flutter_fitness/pages/home_page.dart';
import 'package:flutter_fitness/pages/login/complete_sign_up_page.dart';
import 'package:flutter_fitness/pages/login/main_tab_view.dart';
import 'package:flutter_fitness/pages/login/sign_in.dart';
import 'package:flutter_fitness/pages/login/sign_up.dart';
import 'package:flutter_fitness/pages/login/welcome_page.dart';
import 'package:flutter_fitness/pages/login/what_your_goal_page.dart';
import 'package:flutter_fitness/pages/personal_data_page.dart';
import 'package:flutter_fitness/pages/profile/profile_page.dart';
import 'package:flutter_fitness/pages/search_page.dart';
import 'package:flutter_fitness/pages/settings_page.dart';

final routs = {
  '/': (context) => const MainTabView(),
  '/sign_in': (context) => const SignInPage(),
  '/sign_up': (context) => const SignUpPage(),
  '/home': (context) => const HomePage(),
  '/what': (context) => const WhatYourGoalPage(),
  '/wel': (context) => const WelcomePage(),
  '/set': (context) => const SettingsPage(),
  '/search': (context) => const SearchPage(),
  '/profile': (context) => const ProfilePage(),
  '/complete': (context) => const CompleteSignUpPage(),
  '/person': (context) => const UserProfilePage(),
};
