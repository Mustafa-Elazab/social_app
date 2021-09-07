
import 'package:social_app/shared/network/local/sharedpreferenceHelper.dart';

String token=CacheHelper.sharedPreferences.get('token');
String uId=CacheHelper.sharedPreferences.get('uId');
String password=CacheHelper.sharedPreferences.get('password');
List<String> usersId;