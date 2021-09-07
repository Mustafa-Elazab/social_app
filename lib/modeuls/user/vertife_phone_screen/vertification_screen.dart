
import 'package:flutter/material.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/user/login_screen/login_screen.dart';
import 'package:social_app/shared/styles/color.dart';

class VertificationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController verification1 = new TextEditingController();
  TextEditingController verification2 = new TextEditingController();
  TextEditingController verification3 = new TextEditingController();
  TextEditingController verification4 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String number = ModalRoute.of(context).settings.name;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                    child: Image.asset(
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? "assets/images/Logo_light.png"
                          : "assets/images/Logo_dark.png",
                      height: 146,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Verification',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Verification code will be sent',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                   Container(
                     child:Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         builOtpWidget(first: true, last: false),

                         builOtpWidget(first: false, last: false),

                         builOtpWidget(first: false, last: false),

                         builOtpWidget(first: false, last: true),
                       ],
                     )
                   ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: buildBtn(
                        'Next',
                        kPrimaryColor,
                            () {
                          if (formKey.currentState.validate()) {
                            navigateTo(context, LoginScreen());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
