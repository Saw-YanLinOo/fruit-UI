import 'package:flutter/widgets.dart';
import 'package:fruit/local/share_perferences.dart';

import '../model/User.dart';

class AuthProvider extends ChangeNotifier{

  SharedPref _sharedPref = SharedPref();


  Future<bool> haveLoginUser() async {
      User? user = await getUser();

      if(user != null && user.hadLogin == 'true'){
        return true;
      } else {
        return false;
      }
  }

  Future<bool> isCredentialValid(String phone,String password)async{

    var loginUser = await getUser();

    if(loginUser != null){
      if(loginUser.phone == phone && loginUser.password == password){

        User user = User(name: loginUser.name,phone: phone,password: password,hadLogin: 'true');
        await saveUser(user);

        return true;
      }else{
        return false;
      }
    } else {
      return false;
    }
  }

  Future<User?> getUser() async {
    try {
      User user = User.fromJson(await _sharedPref.read("user"));
      return user;

    } catch (e) {
      print("user ==> ${e.toString()}");
      return null;
    }
  }

  saveUser(User user) async{
    await _sharedPref.save("user", user);
    print('save user');
  }

}