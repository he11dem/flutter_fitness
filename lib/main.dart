import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/database/auth/service.dart';
import 'package:flutter_fitness/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYqjiOhWZy53flm_vvako-3R0WYp5k6rU",
      appId: "1:767589688938:android:3b8aa2034bfbcbd0e18c13",
      messagingSenderId: "767589688938",
      projectId: "fits-be455",
      storageBucket: "fits-be455.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().currentUser,
      child: MaterialApp(
        title: 'Fitness',
        theme: ThemeData(
            textTheme:
                const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
            fontFamily: 'NotoSansKR',
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(color: Colors.white)),
        routes: routs,
        initialRoute: "/sign_in",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
