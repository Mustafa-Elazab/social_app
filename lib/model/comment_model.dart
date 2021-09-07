class CommentModel {
  String commenttext;
  String dateTime;
  String userId;
  
  CommentModel({
    this.dateTime,
    this.commenttext,
    this.userId,
  });

  CommentModel.fromjson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    commenttext = json['commenttext'];
    userId = json['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'commenttext': commenttext,
      'userId': userId,
    };
  }
}
