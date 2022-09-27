class Message{
  static String collectionName='messages';
  String id;
  String content;
  String dataTime;
  String senderId;
  Message({this.id='',required this.content,required this.dataTime,required this.senderId});
  Message.fromjson(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    content: json['content'] as String,
    dataTime: json['dataTime'] as String,
    senderId: json['senderId'] as String,
  );

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'content': content,
      'dataTime': dataTime,
      'senderId': senderId,
    };
  }
}