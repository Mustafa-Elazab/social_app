import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

Widget MyDivder() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 2),
      child: Container(
        width: double.infinity,
        height: .5,
        color: Colors.grey[200],
      ),
    );

Widget defaultTextFormFieldWithSuffix({
  @required TextEditingController controller,
  IconData prefixIcon,
  @required TextInputType type,
  @required String label,
  String hint,
  @required String validate_message,
  Function onChange,
  Function onTap,
  bool isClickable = true,
  obscureText = true,
  Function onSubmit,
  Function onPressedSuffix,
  IconData suffix,
}) =>
    TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: kPrimaryColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onPressedSuffix,
        ),
        labelText: label,
        border: OutlineInputBorder(),
        hintText: hint,
      ),
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      enabled: isClickable,
      onTap: onTap,
      validator: (String value) {
        if (value.isEmpty) {
          return validate_message;
        }
        return null;
      },
      keyboardType: type,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Widget buildForgotPasswordBtn({Function onPreesed}) => Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPreesed,
        child: Text(
          LocaleKeys.forget_password_text.tr(),
        ),
      ),
    );

bool rememberMe = false;

Widget buildBtn(String btnName, Color color, Function onPressed,
        {width = double.infinity}) =>
    SizedBox(
      width: width,
      height: 48.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color,
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
              fontFamily: 'OpenSans', color: Colors.white, fontSize: 20),
        ),
      ),
    );

void toast({
  @required String message,
  @required Color color,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget defaultTextFormField({
  @required TextEditingController controller,
  IconData prefixIcon,
  @required TextInputType type,
  String label,
  String hint,
  @required String validate_message,
  Function onChange,
  Function onTap,
  Function onSubmit,
}) =>
    TextFormField(
      style: TextStyle(),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: kPrimaryColor,
        ),
        labelText: label,
        border: OutlineInputBorder(),
        hintText: hint,
      ),
      controller: controller,
      onChanged: onChange,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      validator: (String value) {
        if (value.isEmpty) {
          return validate_message;
        }
        return null;
      },
      keyboardType: type,
    );

/*Widget homeHeader(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {

            },
          ),
        ],
      ),
    );*/ //homeHeaderWithTo2Action

/*Widget SearchField() => Container(
      width: 200.0,
      decoration: BoxDecoration(
        color: default_color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );*/ //SearchForHomeHeader

Widget buildSearchWidget({
  @required TextEditingController controller,
  IconData prefixIcon,
  TextInputType type,
  String label,
  String hint,
  @required String validate_message,
  Function onChange,
  Function onTap,
  Function onSubmit,
  Color borderColor,
  Color preffixColor,
  Color inputColor,
  Color labelColor,
}) =>
    TextFormField(
      style: TextStyle(color: inputColor),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: labelColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: preffixColor,
        ),
        labelText: label,
        border: OutlineInputBorder(),
        hintText: hint,
      ),
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      validator: (String value) {
        if (value.isEmpty) {
          return validate_message;
        }
        return null;
      },
      keyboardType: type,
    );

Widget builOtpWidget({bool first, bool last, BuildContext context}) =>
    Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(10)),
            hintText: "*",
          ),
        ),
      ),
    );
