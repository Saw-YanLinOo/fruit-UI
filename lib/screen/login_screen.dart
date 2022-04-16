import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruit/provider/auth_provider.dart';
import 'package:fruit/screen/register_screen.dart';
import 'package:fruit/screen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const route = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginBtnController = RoundedLoadingButtonController();
  bool _phoneCheck = false;
  bool _hiddenPw = true;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadWidget(context),
                BodyWidget(context),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: RoundedLoadingButton(
                    color: Theme.of(context).primaryColor,
                    successColor: Theme.of(context).primaryColor,
                    valueColor: Color(0xFFF7FBEC),
                    controller: _loginBtnController,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        ///is Credential Valid?
                        authProvider.isCredentialValid(phoneController.text,passwordController.text).then((value){
                          if(value){
                            _loginBtnController.success();
                            Timer(Duration(seconds: 2),(){
                              Navigator.pushReplacementNamed(context, WelcomeScreen.route);
                            });
                          }
                          else {
                            _loginBtnController.error();
                            _loginBtnController.reset();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Something wrong!!')));
                          }
                        });

                      } else{
                        _loginBtnController.error();
                        _loginBtnController.reset();
                      }

                    },
                    borderRadius: 10,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SourceSansPro',
                      ),
                    ),
                  ),
                ),
                ButtomWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ButtomWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical:40.0),
          width: double.maxFinite,
          child: Text(
            'or log in with',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.g_mobiledata,
                      size: 50,
                      color: Color(0xFFF7FBEC),
                    ),
                  ),
                ),
                Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.facebook,
                      size: 50,
                      color: Color(0xFFF7FBEC),
                    ),
                  ),
                ),
                Text(
                  'Facebook',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.apple,
                      size: 50,
                      color: Color(0xFFF7FBEC),
                    ),
                  ),
                ),
                Text(
                  'Apple',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                )
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top:20.0),
          width: double.maxFinite,
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,RegisterScreen.route);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            suffixIcon: Icon(
              Icons.check,
              color: !_phoneCheck ? Color(0xFFF7FBEC) : Theme.of(context).primaryColor,
            ),
          ),
          onChanged: (value){
            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = new RegExp(pattern);
            if (value.length == 0) {
              _phoneCheck = false;
            }
            else if (!regExp.hasMatch(value)) {
              _phoneCheck = false;
            }else{
              _phoneCheck = true;
            }
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: Text(
            'Password',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
        TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor)
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _hiddenPw = !_hiddenPw;
                  });
                },
                child: Icon(
                  _hiddenPw
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Theme.of(context).primaryColor,
                ),
              )),
          obscureText: _hiddenPw,
          validator: (value){
            if(value == null || value.isEmpty){
              return 'Please enter your Password';
            }
            return null;
          },
        ),
        Container(
          padding: const EdgeInsets.only(top:10.0),
          width: double.maxFinite,
          child: Text(
            'forgot password?',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
      ],
    );
  }

  HeadWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -30,
              right: -50,
              child: SizedBox(
                width: 50,
                height: 40,
                child: Image(
                    image: AssetImage('assets/duo.png',),
                    fit:BoxFit.fill
                ),
              ),
            ),
            Text('Login',
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceSansPro',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0,),
          child: Text('Enter your Phone number and password',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
      ],
    );
  }
}
