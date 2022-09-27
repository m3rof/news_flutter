import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapi2/datasource/Message/Message.dart';
import 'package:newsapi2/datasource/Message/MessageWidget.dart';
import 'package:newsapi2/datasource/MyUser/my_user.dart';
import 'package:newsapi2/utils/FireBase_utils.dart';
import 'package:provider/provider.dart';

import '../../repository/UserProvider.dart';

class chat extends StatefulWidget {
  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  var messageController = TextEditingController();
  String messageText = '';
  MyUser? user;

  @override

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Text('chat',style: TextStyle(color: Colors.white,fontSize: 18),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot<Message>>(
                stream: DataBaseUtils.getMessage(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  var messages=snapshot.data?.docs.map((docs) => docs.data()).toList();
                  return ListView.builder(itemBuilder: (context, index) {
                    return MessageWidget(messages!.elementAt(index))  ;
                  },itemCount:messages?.length??0 ,);
                },),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: messageController,
                  onChanged: (value) {
                    messageText = value;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return 'Enter your message';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'your masseage here',
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12)),
                      borderSide: new BorderSide(
                        color: Colors.white,
                        width: .4,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if(messageText.trim().isEmpty)return;
                    try {
                      var message = Message(
                          content: messageText,
                          dataTime: DateTime.now().microsecondsSinceEpoch.toString(),
                          senderId:  userProvider.firebaseUser!.uid,
                          );//userProvider.user!.userName!);
                      var task = await DataBaseUtils.createDBMessage(message);
                      messageController.clear();
                      return;
                    } catch (e) {
                      print(messageText);
                      print('error message $e');
                    }
                  },
                  child: Row(
                    children: [
                      Text('send'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.send_outlined)
                    ],
                  ))
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
