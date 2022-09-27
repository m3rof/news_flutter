import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapi2/datasource/Message/Message.dart';
import 'package:newsapi2/repository/UserProvider.dart';
import 'package:provider/provider.dart';

import '../../utils/FireBase_utils.dart';
import '../MyUser/my_user.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.firebaseUser?.uid == message.senderId
        ? SendMessage(message)
        : ReciveMessage(message);
  }
}

class SendMessage extends StatelessWidget {
  Message message;

  SendMessage(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FutureBuilder<MyUser?>(
            future: DataBaseUtils.readUser('${userProvider.firebaseUser!.uid}'),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat('KK:mm').format(DateTime.now())),
                    SizedBox(width: 15,),
                    Text(
                      '${user?.userName}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(width: 15),
                    CircleAvatar(
                      backgroundColor: Colors.cyan[600],
                      radius: 15,
                      child: Text(
                          '${user?.userName?.substring(0, 1).toUpperCase()}'),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height:4 ,),
          Container(
            margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.blue),
              child: Text(
                message.content,
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class ReciveMessage extends StatelessWidget {
  Message message;

  ReciveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<MyUser?>(
            future: DataBaseUtils.readUser('${message.senderId}'),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.cyan[600],
                      radius: 15,
                      child: Text(
                          '${user?.userName?.substring(0, 1).toUpperCase()}'),
                    ),
                    SizedBox(width: 15,),
                    Text(
                      '${user?.userName}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(width: 15),
                    Text(DateFormat('KK:mm').format(DateTime.now())),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height:4 ,),
          Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.grey[300]),
              child: Text(
                message.content,
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
    ;
  }
}
