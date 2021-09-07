
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/user/login_screen/login_screen.dart';
import 'package:social_app/shared/styles/color.dart';


class PhoneScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  TextEditingController phoneController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:  Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/4,
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
                    Text(
                      'OTP Sign In',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            child: defaultTextFormField(
                                controller: phoneController,
                                type: TextInputType.text,
                                label: "Phone Number",
                                validate_message: 'Name must not be empty',
                                prefixIcon: Icons.call),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                              condition: true,
                              builder: (context) => buildBtn(
                                'Continue',
                                kPrimaryColor,
                                    () {
                                  navigateAndFinish(context, LoginScreen());
                                  if (formKey.currentState.validate()) {
                                  /*  UserCubit.get(context).otpRegister(
                                        phoneNumber: phoneController.text.toString());*/
                                  }
                                },
                                width: MediaQuery.of(context).size.width/2,
                              ),
                              fallback: (context) => CircularProgressIndicator()),


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
        Text('Already have an account'),
        Container(
          child: TextButton(
            onPressed: () => navigateTo(context, LoginScreen()),
            child: Text(
              'Sign In',
            ),
          ),
        ),
      ],
    ),
    );
  }
}
