import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/splash_view/splash_view.dart';
import 'package:social_app/modeuls/user/bloc/cubit.dart';
import 'package:social_app/shared/bloc/app_cubit.dart';
import 'package:social_app/shared/bloc/myblocobserver.dart';
import 'package:social_app/shared/bloc/app_states.dart';
import 'package:social_app/shared/network/local/sharedpreferenceHelper.dart';
import 'package:social_app/shared/network/remote/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:social_app/shared/translations/codegen_loader.g.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await DioHelper.init();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();

  var firebaseMessgaingtoken = FirebaseMessaging.instance.getToken();
  print(firebaseMessgaingtoken);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  bool mode = CacheHelper.sharedPreferences.getBool('mode');
  String lang = CacheHelper.sharedPreferences.getString('lang');

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: Phoenix(
      child: MyApp(
        lang: lang,
        mode: mode,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String lang;
  final bool mode;

  MyApp({this.lang, this.mode});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(mode: mode),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getUserData()
            ..getAllPosts()
            ..getAllUsers()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashView(),
          );
        },
      ),
    );
  }
}
