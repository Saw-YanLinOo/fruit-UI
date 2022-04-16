import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruit/provider/auth_provider.dart';
import 'package:fruit/screen/login_screen.dart';
import 'package:fruit/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const route = '/splash';
  @override
  Widget build(BuildContext context) {
    ///Have Login User
    Provider.of<AuthProvider>(context).haveLoginUser().then((value){
      if(value == true){
        Timer(Duration(seconds: 2),(){
          Navigator.pushReplacementNamed(context, WelcomeScreen.route);
        });
      }else{
        Timer(Duration(seconds: 2),(){
          Navigator.pushReplacementNamed(context, LoginScreen.route);
        });;
      }
    });

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          overflow: Overflow.clip,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Hero(tag: 'logo',
                    child: Image.asset('assets/logo.png')),
              ),
            ),
            Positioned(
              top: -50,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xFF6B8E23),
                    shape: BoxShape.circle
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xFF6B8E23),
                    shape: BoxShape.circle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
