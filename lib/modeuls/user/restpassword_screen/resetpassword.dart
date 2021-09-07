/*
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/modeuls/user_screen/register_screen/register_screen.dart';
import 'package:shop_app2/shared/styles/styles.dart';
class ResetScreen extends StatelessWidget {
  TextEditingController emailAddress_controller=new TextEditingController();
  var FormKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Center(
      child: Text('Forget Password',style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54
    ),
      ),
      ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: FormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                Center(child: Text('Forget Password',style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),)),
                SizedBox(height: 20.0,),
                Text('Please enter your email and we will send you a link to reset your password',textAlign:TextAlign.center ,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 50.0,),
                defaultTextFormField(controller: emailAddress_controller, type: TextInputType.emailAddress, label: 'Email Address', validate_message: 'email address must be not empty'
                ,prefixIcon: Icons.email_outlined),
                SizedBox(height: 20,),
                buildBtn((){
                  if(FormKey.currentState.validate()){

                  }
                },'Send Request'),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''Don't have an account ?''',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(onPressed: (){
                        NavigateTo(context, RegisterScreen());
                      }
                        ,child: Text(
                          'Sign Up',
                          style: kLabelStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
