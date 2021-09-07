import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/user/bloc/cubit.dart';
import 'package:social_app/modeuls/user/bloc/states.dart';
import 'package:social_app/modeuls/user/login_screen/login_screen.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is CreateUserSucessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.asset(
                            MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? "assets/images/Logo_light.png"
                                : "assets/images/Logo_dark.png",
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                               LocaleKeys.sign_up_text.tr(),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                child: defaultTextFormField(
                                    controller: nameController,
                                    type: TextInputType.text,
                                    label: LocaleKeys.name_text.tr(),
                                    validate_message: LocaleKeys.name_error_text.tr(),
                                    prefixIcon: Icons.person),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: defaultTextFormField(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    label: LocaleKeys.email_text.tr(),
                                    validate_message: LocaleKeys.email_error_text.tr(),
                                    prefixIcon: Icons.email),
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
                                  prefixIcon: Icons.lock,
                                  suffix: UserCubit.get(context).suffixIcon,
                                  obscureText:
                                      UserCubit.get(context).isPasswordShow,
                                  onPressedSuffix: () {
                                    UserCubit.get(context).passwordVisibility();
                                    print(
                                        UserCubit.get(context).isPasswordShow);
                                  },
                                ),
                              ),
                              /* suffixIcon: Icons.visibility),*/
                              SizedBox(
                                height: 40.0,
                              ),
                              ConditionalBuilder(
                                  condition: true,
                                  builder: (context) => buildBtn(
                                        LocaleKeys.sign_up_text.tr(),
                                        kPrimaryColor,
                                        () {
                                          if (formKey.currentState.validate()) {
                                            UserCubit.get(context).userRegister(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password: passwordController
                                                    .text
                                                    .toString());
                                          }
                                        },
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      ),
                                  fallback: (context) =>
                                      CircularProgressIndicator()),
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
              Text(LocaleKeys.have_account_text.tr()),
              Container(
                child: TextButton(
                  onPressed: () => navigateTo(context, LoginScreen()),
                  child: Text(
                    LocaleKeys.sign_in_text.tr(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
