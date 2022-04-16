import 'package:flutter/material.dart';
import 'package:fruit/provider/auth_provider.dart';
import 'package:fruit/screen/login_screen.dart';
import 'package:fruit/screen/register_screen.dart';
import 'package:fruit/screen/splash_screen.dart';
import 'package:fruit/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color(0xFF6B8E23),
          scaffoldBackgroundColor: const Color(0xFFF7FBEC),
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Color(0xFF444939)),
          ),
        ),
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route:(context)=> SplashScreen(),
          LoginScreen.route:(context)=> LoginScreen(),
          RegisterScreen.route:(context)=> RegisterScreen(),
          WelcomeScreen.route:(context)=> WelcomeScreen(),
        },
      ),
    );
  }
}