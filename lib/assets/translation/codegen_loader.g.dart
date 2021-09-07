// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "add_post_text": "اضافة",
  "notification_text": "الأشعارات",
  "name_text": "الاسم",
  "email_text": "البريد الالكتروني",
  "password_text": "كلمة المرور",
  "like_text": "اعجاب",
  "comment_text": "تعليق",
  "share_text": "مشاركة",
  "search_text": "بحث",
  "search_error_text": "لايوجد حساب بعد ",
  "create_post_text": "انشاء ",
  "post_text": "نشر",
  "post_area_text": "ماذا يدور في ذهنك ؟",
  "followers_text": "متابعين",
  "following_text": "متابعه",
  "home_text": "الرئسية",
  "activity": "التنبيهات",
  "account_text": "حسابي",
  "bio_text": "نبذة مختصرة",
  "phone_text": "رقم الهاتف",
  "edit_profile_text": "تعديل الحساب",
  "update_text": "تحديث"
};
static const Map<String,dynamic> en = {
  "add_post_text": "add",
  "notification_text": "notifications",
  "name_text": "name",
  "email_text": "E-mail",
  "password_text": "Password",
  "like_text": "like",
  "comment_text": "comment",
  "share_text": "share",
  "search_text": "search",
  "search_error_text": "there is no user yet",
  "create_post_text": "create",
  "post_text": "post",
  "post_area_text": "what is on your mind ?",
  "followers_text": "followers",
  "following_text": "following",
  "home_text": "home",
  "activity": "activity",
  "account_text": "account",
  "bio_text": "bio",
  "phone_text": "phone",
  "edit_profile_text": "Edit_Profile",
  "update_text": "update"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
