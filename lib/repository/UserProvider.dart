import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:newsapi2/utils/FireBase_utils.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? firebaseUser;
  UserProvider(){
     firebaseUser=FirebaseAuth.instance.currentUser;
     initMyUser();
  }
  void initMyUser()async {
    if(firebaseUser==null){
      user=await DataBaseUtils.readUser(firebaseUser!.uid);
    }
  }
}

