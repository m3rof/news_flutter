class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? fName;
  String? lName;
  String? userName;
  String? email;
  String? profileImage;

  MyUser(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.userName,
      required this.email,
      required this.profileImage});

  MyUser.fromjson(Map<String, dynamic> json)
      : this(
          fName: json['fname'] as String,
          lName: json['lName'] as String,
          userName: json['userName'] as String,
          email: json['email'] as String,
          id: json['id'] as String,
          profileImage: json['profileImage'] as String,
        );

  Map<String, dynamic> tojson() {
    return {
      'fname': fName,
      'lName': lName,
      'userName': userName,
      'email': email,
      'id': id,
      'profileImage': profileImage,
    };
  }
}
