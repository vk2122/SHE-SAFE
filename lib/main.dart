import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication_demo/screens/home_screen.dart';
import 'package:flutter_firebase_authentication_demo/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_authentication_demo/screens/registration_screen.dart';

const Color1 = const Color(0xff555692);
const Color2 = const Color(0xff8587DC);
const Color3 = const Color(0xffACADFF);
const Color4 = const Color(0xffa1a4d5);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SHE-SAFE",
      home: LoginScreen(),
      //theme: ThemeData(primarySwatch: Color(Color3)),
      routes: {
        'landing': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegistrationScreen(),
      },
    );
  }
}
