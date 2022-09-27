import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:newsapi2/presentation/home/HomeView.dart';
import 'package:newsapi2/utils/FireBase_utils.dart';
import 'package:provider/provider.dart';

import '../../repository/UserProvider.dart';

class account extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstName = '';

  String lastName = '';

  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan[600],
              title: Text('account'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .1),
                    padding: EdgeInsets.all(12),
                    child: Form(
                        key: formKey,
                        child: Column(children: [
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
                            decoration:
                                InputDecoration(labelText: 'First name'),
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
                              if (value.contains(' ')) {
                                return 'User name must contains white space';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'User name'),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.cyan[600]),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)))),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate() ==
                                            true) {
                                          DataBaseUtils.UpdateUser(
                                              id: '${value.firebaseUser!.uid}',
                                              firstName: firstName,
                                              lastName: lastName,
                                              userName: userName);
                                          Navigator.pushReplacementNamed(
                                              context, 'one');
                                        }
                                      },
                                      child: Text('change account'))),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, 'one');
                              },
                              child: Text(
                                "I don't want to change ",
                                style: TextStyle(color: Colors.cyan[600]),
                              )),
                        ]
                        )
                    )
                )
            )
        )
    );
  }
}
