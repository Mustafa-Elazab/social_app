class ChatModel {
  String chattext;
  String dateTime;
  String receiverId;
  String senderId;

  
  ChatModel({
    this.chattext,
    this.dateTime,
    this.receiverId,
    this.senderId,
  });

  ChatModel.fromjson(Map<String, dynamic> json) {
    chattext = json['chattext'];
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chattext': chattext,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime,
    };
  }
}
