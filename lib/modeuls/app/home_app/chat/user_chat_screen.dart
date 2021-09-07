import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/Helper/compoments.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/chats_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class UserChatScren extends StatelessWidget {
  UserModel model;
  UserChatScren({this.model});
  TextEditingController messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getMessage(receiverId: model.uId);
      return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is SendMessageSucessState) {
          messageController.clear();
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(model.profileImage),
                  radius: MediaQuery.of(context).size.height / 38,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(model.name, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: HomeCubit.get(context).listChatModel.length > 0,
                    builder: (context) => Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (uId ==
                                    HomeCubit.get(context)
                                        .listChatModel[index]
                                        .senderId) {
                                  return buildMyChat(HomeCubit.get(context)
                                      .listChatModel[index]);
                                } else {
                                  return buildChat(HomeCubit.get(context)
                                      .listChatModel[index]);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount:
                                  HomeCubit.get(context).listChatModel.length),
                        ),
                      ],
                    ),
                    fallback: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(LocaleKeys.message_error_area_text.tr()),
                      ],
                    ),
                  ),
                ),
                bottomChat(context),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget buildChat(ChatModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10.0),
                  )),
              child: Text(model.chattext),
            ),
            Text(
              model.dateTime,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );

  Widget buildMyChat(ChatModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                  )),
              child: Text(model.chattext),
            ),
            Text(
              model.dateTime,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );

  Widget bottomChat(context) => Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 2, color: kPrimaryColor.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.message_text.tr(),
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (String value) {
                      var dateTime =
                          DateFormat.jm().add_E().format(DateTime.now());
                      HomeCubit.get(context).sentMessage(
                          dateTime: dateTime.toString(),
                          receiverId: model.uId,
                          message: messageController.text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                border:
                    Border.all(width: 1, color: kPrimaryColor.withOpacity(.2)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconButton(
                  icon: Icon(IconBroken.Send, color: Colors.white),
                  onPressed: () {
                    var dateTime =
                        DateFormat.jm().add_E().format(DateTime.now());
                    HomeCubit.get(context).sentMessage(
                        dateTime: dateTime.toString(),
                        receiverId: model.uId,
                        message: messageController.text);
                  }),
            ),
          ],
        ),
      );
}
