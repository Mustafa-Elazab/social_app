class UserModel{

  String name;
  String email;
  String phone;
  String profileImage;
  String coverImage;
  String uId;
  String bio;
  bool isEmailVertified;
  UserModel({this.name, this.email, this.phone, this.profileImage,this.coverImage, this.uId,this.bio,this.isEmailVertified});

  UserModel.fromjson(Map<String,dynamic> json){

    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    profileImage=json['profileImage'];
    coverImage=json['coverImage'];
    uId=json['uId'];
    bio=json['bio'];
    isEmailVertified=json['isEmailVertified'];

  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'email':email,
      'phone':phone,
      'profileImage':profileImage,
      'cover_image':coverImage,
      'isEmailVertified':isEmailVertified,
      'bio':bio,

    };
  }

}