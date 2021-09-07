import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/chat/user_chat_screen.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.chat_text.tr(),
              ),
            ),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).listUserModel.length >0,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatsScreen(
                      context, HomeCubit.get(context).listUserModel[index]),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white,
                      ),
                  itemCount: HomeCubit.get(context).listUserModel.length - 1),
              fallback: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  Text(LocaleKeys.chat_area_text.tr()),
                ],
              ),
            ),
          );
        });
  }

  Widget buildChatsScreen(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              UserChatScren(
                model: model,
              ));
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: (model.profileImage == null)
                        ? AssetImage('assets/images/user.png')
                        : NetworkImage(model.profileImage),
                    radius: MediaQuery.of(context).size.height / 20,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(model.name,
                            style: Theme.of(context).textTheme.bodyText1)),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          model.email,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
