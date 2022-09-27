import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:newsapi2/datasource/MyUser/my_user.dart';

import '../datasource/Message/Message.dart';

class FireBaseErrors {
  static const String weakPassword = 'weak-password';
  static const String email_in_use = 'email-already-in-use';
}

class DataBaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, _) => MyUser.fromjson(snapshot.data()!),
          toFirestore: (user, options) => user.tojson(),
        );
  }

  static Future<void> createDBUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String id) async {
    final docUser =
        FirebaseFirestore.instance.collection(MyUser.collectionName).doc('$id');
    final snapshot = await docUser.get();
    return MyUser.fromjson(snapshot.data()!);
  }

  static void UpdateUser(
      {required String id,
      required String firstName,
      required String lastName,
      required String userName}) {
    final docUser =
        FirebaseFirestore.instance.collection(MyUser.collectionName).doc('$id');
    docUser.update({
      'fname': firstName,
      'lName': lastName,
      'userName': userName,
    });
  }

  static CollectionReference<Message> getMessagerCollection() {
    return FirebaseFirestore.instance.collection('message').withConverter(
          fromFirestore: (snapshot, _) => Message.fromjson(snapshot.data()!),
          toFirestore: (Message, options) => Message.tojson(),
        );
  }

  static Future<void> createDBMessage(Message message) async {
    return getMessagerCollection().doc(message.dataTime).set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessage() {
    return DataBaseUtils.getMessagerCollection().orderBy('dataTime').snapshots();
  }
}
