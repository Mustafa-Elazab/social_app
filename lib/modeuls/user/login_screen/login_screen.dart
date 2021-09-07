import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modeuls/user/bloc/cubit.dart';
import 'package:social_app/modeuls/user/bloc/states.dart';
import 'package:social_app/modeuls/user/register_screen/register_screen.dart';
import 'package:social_app/modeuls/user/signinphone_screen/phone_screen.dart';
import 'package:social_app/shared/bloc/app_cubit.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Image.asset(
                              AppCubit.get(context).isDark
                                  ? "assets/images/Logo_dark.png"
                                  : "assets/images/Logo_light.png",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  LocaleKeys.sign_in_text.tr(),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  child: defaultTextFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      label: LocaleKeys.email_text.tr(),
                                      validate_message:
                                         LocaleKeys.email_error_text.tr(),
                                      prefixIcon: Icons.person_outline),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  child: defaultTextFormFieldWithSuffix(
                                    controller: passwordController,
                                    type: TextInputType.text,
                                    label: LocaleKeys.password_text.tr(),
                                    validate_message:
                                        LocaleKeys.password_error_text.tr(),
                                    prefixIcon: Icons.lock_outlined,
                                    suffix: UserCubit.get(context).suffixIcon,
                                    obscureText:
                                        UserCubit.get(context).isPasswordShow,
                                    onPressedSuffix: () {
                                      UserCubit.get(context)
                                          .passwordVisibility();
                                      print(UserCubit.get(context)
                                          .isPasswordShow);
                                    },
                                  ),
                                ),
                                buildForgotPasswordBtn(onPreesed: () {
                                  /*  NavigateTo(context, ResetScreen());*/
                                  navigateAndFinish(context, HomeLayout());
                                }),
                                ConditionalBuilder(
                                  condition: true,
                                  builder: (context) => buildBtn(
                                    LocaleKeys.sign_in_text.tr(),
                                    kPrimaryColor,
                                    () {
                                      if (formKey.currentState.validate()) {
                                        UserCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context);
                                      }
                                    },
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                  fallback: (context) => Center(
                                      child: CircularProgressIndicator()),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  LocaleKeys.or_text.tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, PhoneScreen());
                                  },
                                  child: Text(
                                    LocaleKeys.otp_text.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SignInButton.mini(
                                      buttonType: ButtonType.facebook,
                                      onPressed: () {},
                                    ),
                                    SignInButton.mini(
                                      buttonType: ButtonType.googleDark,
                                      onPressed: () {},
                                    ),
                                    SignInButton.mini(
                                      buttonType: ButtonType.twitter,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.no_account_text.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context, RegisterScreen());
                  },
                  child: Text(
                    LocaleKeys.sign_up_text.tr(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
