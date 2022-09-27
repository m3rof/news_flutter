import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../../utils/FireBase_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String userName = '';
  String email = '';
  String password = '';
  bool hide = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Text(
          'Create Account',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
          padding: EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    firstName = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'First name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    lastName = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your Last name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Last name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    userName = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your user name';
                    }
                    else if (value.contains(' ')) {
                      return 'User name must contains white space';
                    }
                    else if(value.length>8){
                      return 'User name Must be no more than 8 characters ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'User name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your email';
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return 'Email format not valid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password shoud be at least chars';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {});
                            hide = !hide;
                          },
                          child: hide == false
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                )
                              : Icon(Icons.visibility_off_outlined))),
                  obscureText: hide,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.cyan[600]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0)))),
                            onPressed: () async {
                              if (formKey.currentState!.validate() == true) {
                                try {
                                  var result = await firebaseAuth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  var user = MyUser(
                                      profileImage: profileImageUrl,
                                      id: result.user!.uid,
                                      fName: firstName,
                                      lName: lastName,
                                      userName: userName,
                                      email: email);
                                  var task =
                                      await DataBaseUtils.createDBUser(user);
                                  Navigator.pushReplacementNamed(
                                      context, 'one');
                                  return;
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == FireBaseErrors.weakPassword) {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Text(
                                                  'The password provided is too weak.'),
                                            ));
                                    print('The password provided is too weak.');
                                  } else if (e.code ==
                                      FireBaseErrors.email_in_use) {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Text(
                                                  'The account already exists for that email'),
                                            ));
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            content:
                                                Text('Somthing went wrong'),
                                          ));
                                  print(e);
                                }
                              }
                            },
                            child: Text('create account'))),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'five');
                    },
                    child: Text(
                      "Aleardy Have An Account",
                      style: TextStyle(color: Colors.cyan[600]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var picker = ImagePicker();
  File? profileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    } else {
      print('No image selected');
    }
    setState(() {});
  }

  String profileImageUrl = '';

  void uploadprofileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          setState(() { value.ref.getDownloadURL().then((value) {
            setState(() {
              profileImageUrl = value;
            });
          });});
    });
    setState(() {});
  }
}
