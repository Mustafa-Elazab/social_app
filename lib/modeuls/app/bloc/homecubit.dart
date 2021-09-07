import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Helper/compoments.dart';
import 'package:social_app/model/chats_model.dart';
import 'package:social_app/model/comment_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/add_post_screen.dart';
import 'package:social_app/modeuls/app/home_app/home_screen.dart';
import 'package:social_app/modeuls/app/home_app/notification_screen.dart';
import 'package:social_app/modeuls/app/home_app/search_screen.dart';
import 'package:social_app/modeuls/app/home_app/user_screen.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:easy_localization/easy_localization.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntinalState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    NotificationScreen(),
    UserScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Home),
        label: '',
        activeIcon: Text(LocaleKeys.home_text.tr())),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Search),
        label: '',
        activeIcon: Text(LocaleKeys.search_text.tr())),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Plus),
        label: '',
        activeIcon: Text(LocaleKeys.add_post_text.tr())),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Activity),
        label: '',
        activeIcon: Text(LocaleKeys.activity.tr())),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Profile),
        label: '',
        activeIcon: Text(LocaleKeys.account_text.tr())),
  ];

  void changebottomnavbar(int index) {
    currentIndex = index;
    if (index == 1) {
      getAllUsers();
    }
    if (index == 3) {
      getAccountData(FirebaseAuth.instance.currentUser.uid);
    }
    emit(ChangeBottomNavigationBarState());
  }

  UserModel userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromjson(value.data());
      print(value.data());
      emit(GetUserDataSucessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  UserModel accountModel;
  void getAccountData(String uId) {
    emit(GetAccountDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      accountModel = UserModel.fromjson(value.data());
      print(value.data());
      emit(GetAccountDataSucessState());
    }).catchError((error) {
      emit(GetAccountDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  File profileImage;
  final picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage.toString());
      emit(GetUserProfileSucessState());
    } else {
      print('No image selected.');
      emit(GetUserProfileErrorState());
    }
  }

  File coverImage;
  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetUserCoverSucessState());
    } else {
      print('No image selected.');
      emit(GetUserCoverErrorState());
    }
  }

  String profileImageUrl = '';
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(value);
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        print('coverImage$value');
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
    });
  }

  void updateUserData({
    String name,
    String phone,
    String coverImage,
    String profileImage,
    String bio,
    String uId,
    String email,
    bool isEmailVertified,
  }) {
    print('im in userUpdate');
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else {
      UserModel model = UserModel(
          name: name,
          bio: bio,
          phone: phone,
          email: userModel.email,
          uId: userModel.uId,
          profileImage: profileImageUrl,
          coverImage: coverImageUrl,
          isEmailVertified: userModel.isEmailVertified);

      emit(UpdateUserDataLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        emit(UpdateUserDataErrorState());
        print(error.toString());
      });
    }
  }

  File postImage;
  Future getpostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage.toString());
      emit(GetPostImageSucessState());
    } else {
      print('No image selected.');
      emit(GetPostImageErrorState());
    }
  }

  Future getpostCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage.toString());
      emit(GetPostImageSucessState());
    } else {
      print('No image selected.');
      emit(GetPostImageErrorState());
    }
  }

  String postImageUrl = '';
  void uploadPostImage({
    String name,
    String dateTime,
    String profieImage,
    bool isEmailVertified,
    String postText,
    String tags,
    String uId,
  }) {
    emit(UserCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;
        {
          emit(UserCreatePostSucessState());
          print('postImage$value');
          createPost(postText: postText, dateTime: dateTime, postimage: value);
        }
      }).catchError((error) {
        emit(UserCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(UserCreatePostErrorState(error.toString()));
    });
  }

  void createPost({
    String name,
    String dateTime,
    String profieImage,
    bool isEmailVertified,
    String postText,
    String tags,
    String uId,
    String postimage,
  }) {
    PostModel postModel = PostModel(
      name: userModel.name,
      dateTime: dateTime,
      profileImage: userModel.profileImage,
      isEmailVertified: userModel.isEmailVertified,
      postImage: postimage ?? '',
      uId: userModel.uId,
      text: postText,
      tags: tags,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(UserCreatePostSucessState());

      getAllPosts();
    }).catchError((error) {
      emit(UserCreatePostErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  var postId;
  void getAllPosts() {
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);

          postsId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));

          emit(GetPostsSucessState());
        }).catchError((error) {
          emit(GetPostsErrorState(error.toString()));
        });
      });
      emit(GetPostsSucessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  bool isLikeClicked = false;
  IconData likeIcon = Icons.favorite_border;
  void likePost(String postId) {
    isLikeClicked = !isLikeClicked;
    likeIcon = Icons.favorite_outline_outlined;
    emit(ChangeLikeIcon());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': isLikeClicked}).then((value) {
      emit(LikePostSucessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void writeComment(
      {@required String postId,
      @required String comment,
      @required String dateTime,
      @required String userId}) {
    CommentModel commentModel =
        CommentModel(dateTime: dateTime, commenttext: comment, userId: userId);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userId)
        .collection('user_comment')
        .add(commentModel.toMap())
        .then((value) {
      emit(PostCommentSucessState());
    }).catchError((error) {
      emit(PostCommentErrorState(error.toString()));
    });
  }

  var commentUserId;

  List<CommentModel> listCommentModel = [];
  void getComment(
      {@required String postId,
      @required String userId,
      @required String dateTime}) {
    listCommentModel = [];
    print('helllllllo world');
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userId)
        .collection('user_comment')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        print('myCommentData${element.data()}');
        commentUserId = element.data()['userId'];
        print('myId${commentUserId.toString()}');
        listCommentModel.add(CommentModel.fromjson(element.data()));
        emit(GetCommentSucessState());
        getUserCommentData();
      });
    });
  }

  UserModel userCommentModel;
  void getUserCommentData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(commentUserId)
        .get()
        .then((value) {
      userCommentModel = UserModel.fromjson(value.data());
      print('UserDataModel ${value.data().toString()}');
      emit(GetUserCommentDataSucessState());
    }).catchError((error) {
      emit(GetUserCommentDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<UserModel> listUserModel = [];
  void getAllUsers() {
    if (listUserModel.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != FirebaseAuth.instance.currentUser.uid)
            listUserModel.add(UserModel.fromjson(element.data()));
        });
        emit(GetAllUserDataSucessState());
      }).catchError((error) {
        emit(GetAllUserDataErrorState(error.toString()));
      });
  }

  void sentMessage({
    @required String dateTime,
    @required String receiverId,
    @required String message,
  }) {
    ChatModel chatModel = ChatModel(
      chattext: message,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSucessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSucessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<ChatModel> listChatModel = [];

  void getMessage({@required receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      listChatModel = [];
      event.docs.forEach((element) {
        listChatModel.add(ChatModel.fromjson(element.data()));
        var data = element.data();
        print(data);
      });
      emit(ReceiveMessageSucessState());
    });
  }

  QuerySnapshot<Map<String, dynamic>> snapshotData;
  Future getSearchResult(String search) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: search)
        .get()
        .then((value) {
      snapshotData = value;
      print(snapshotData.docs.length);
      emit(GetSearchResultSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchResultErrorState());
    });
  }

  Color buttonColor = Colors.grey;
  String buttonText = 'Follow';
  bool isClicked;
  void ChangeFollowUnFollow() {
    isClicked = !isClicked;
    buttonText = 'UnFollow';
    buttonColor = Colors.blueAccent;
  }

  void addFollowers(currentUserId) {
    FirebaseFirestore.instance
        .collection('followers')
        .doc(currentUserId)
        .collection('userFollowers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'follow': true}).then((value) {
      emit(AddFollowersSucessState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void addFollowing(currentUserId) {
    FirebaseFirestore.instance
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFollowers')
        .doc(currentUserId)
        .set({'follow': true}).then((value) {
      emit(AddFollowersSucessState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  dynamic followersLength;
  void getFollowers(currentUserId) {
    FirebaseFirestore.instance
        .collection('followers')
        .doc(currentUserId)
        .collection('userFollowers')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((element) {
        var data = element.data();
        print(data.toString());
      });
      followersLength = value.docs.length;
    }).catchError((error) {
      print(error.toString());
    });
  }

  dynamic followingLength;
  void getFollowing() {
    FirebaseFirestore.instance
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFollowers')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((element) {
        var data = element.data();
        print(data.toString());
      });
      followersLength = value.docs.length;
    }).catchError((error) {
      print(error.toString());
    });
  }
}
