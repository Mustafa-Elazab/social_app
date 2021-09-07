class PostModel {
  String name;
  String profileImage;
  String uId;
  bool isEmailVertified;
  String text;
  String dateTime;
  String postImage;
  String tags;
  Map likes;

  PostModel(
      {this.name,
      this.dateTime,
      this.postImage,
      this.profileImage,
      this.tags,
      this.uId,
      this.text,
      this.isEmailVertified,
      this.likes});

  PostModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
    tags = json['tags'];
    uId = json['uId'];
    text = json['text'];
    isEmailVertified = json['isEmailVertified'];
    likes = json['likes'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'postImage': postImage,
      'profileImage': profileImage,
      'tags': tags,
      'isEmailVertified': isEmailVertified,
      'text': text,
      'likes': likes,
    };
  }
}
