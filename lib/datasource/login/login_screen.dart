import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapi2/utils/FireBase_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool hide = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Text(
          'Sign in',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
          padding: EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
                                  final result = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  var userObj= DataBaseUtils.readUser(result.user!.uid);
                                  if(userObj==null){
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Text(
                                              'Faild to complete Sign in , please try register again'),
                                        ));
                                  }else {
                                    Navigator.pushReplacementNamed(
                                        context, 'one');
                                  }} on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Text(
                                                  'No user found for that email.'),
                                            ));
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Text(
                                                  'Wrong password provided for that user.'),
                                            ));
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                              }
                            },
                            child: Text('Sign in'))),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'four');
                    },
                    child: Text(
                      "Don't Have An Account ?",
                      style: TextStyle(color: Colors.cyan[600]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
