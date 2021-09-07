import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modeuls/user/bloc/states.dart';
import 'package:social_app/shared/network/local/sharedpreferenceHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserLoginIntinalState());

  static UserCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required String password, context}) {
    emit(UserLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      CacheHelper.saveData(key: 'uId', value: value.user.uid);
      emit(UserLoginSucessState());
      navigateAndFinish(context, HomeLayout());
    }).catchError((error) {
      toast(message: error.toString(), color: Colors.redAccent);
      emit(UserLoginErrorState(error.toString()));
    });
  } //userLogin

  bool isPasswordShow = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void passwordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffixIcon = isPasswordShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(UserShowPasswordState());
  }

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    String profileImage,
    String coverImage,
    String bio,
  }) {
    emit(UserRegisterLoadingState());
    print('hello');

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      CacheHelper.saveData(key: 'uId', value: value.user.uid);

      emit(UserRegisterSucessState());
      createUser(uId: value.user.uid, email: email, name: name);
    }).catchError((error) {
      emit(UserRegisterErrorState(error.toString()));
    });
  } //userRegister

  /*void otpRegister({
    @required String phoneNumber,
  }) {
    FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber).then((value) {
      print(value.verificationId);
      emit(UserOtpRegisterSucessState());
    }).catchError((error) {
      emit(UserOtpRegisterErrorState(error.toString()));
    });
  }*/ //registerByPhone

  void createUser({
    @required String name,
    @required String email,
    String phone,
    @required String uId,
    String profileImage,
    String coverImage,
    String bio,
    bool isEmailVertified,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio: 'Write a bio..',
        isEmailVertified: false,
        profileImage:
            'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png',
        coverImage:
            'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSucessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  } //saveUserToFireBAse

}
