import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/bloc/app_states.dart';
import 'package:social_app/shared/network/local/sharedpreferenceHelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntinalState());

  static AppCubit get(context) => BlocProvider.of(context);

  var isDark = false;
  void changeAppMode({bool mode}) {
    if (mode != null)
      isDark = mode;
    else
      isDark = !isDark;
    CacheHelper.saveData(key: 'mode', value: isDark).then((value) {
      emit(ModeAppChangeState());
    });
    print(isDark);
  }

  var lang = 'en';
  void changeAppLang({String language}) {
    if (language != null)
      lang = language;
    else
      lang = 'ar';
    CacheHelper.saveData(key: 'lang', value: lang).then((value) {
      emit(LangAppChangeState());
    });
    print(lang);
  }
}
