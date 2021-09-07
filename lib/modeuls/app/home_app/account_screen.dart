import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/chat/user_chat_screen.dart';
import 'package:social_app/modeuls/app/home_app/update_profile_screen.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Color buttonColor = Theme.of(context).scaffoldBackgroundColor;
    //String buttonText = 'Follow';
    final userId = ModalRoute.of(context).settings.arguments as String;
    HomeCubit.get(context).getAccountData(userId);
    HomeCubit.get(context).getFollowers(userId);
    HomeCubit.get(context).getFollowing();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ConditionalBuilder(
          condition: HomeCubit.get(context).accountModel != null,
          builder: (context) => CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://pbs.twimg.com/profile_banners/537644733/1450564584/1500x500'),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height / 12 + 1,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      HomeCubit.get(context)
                                          .accountModel
                                          .profileImage),
                                  radius:
                                      MediaQuery.of(context).size.height / 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      HomeCubit.get(context).accountModel.name,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    if (HomeCubit.get(context)
                                        .accountModel
                                        .isEmailVertified)
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                        size: 12,
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  HomeCubit.get(context).accountModel.bio,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (HomeCubit.get(context).accountModel.uId ==
                              FirebaseAuth.instance.currentUser.uid)
                            Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                    onPressed: () {
                                      navigateTo(
                                          context, UpdateProfileScreen());
                                    },
                                    child: Icon(IconBroken.Edit))),
                          if (HomeCubit.get(context).accountModel.uId !=
                              FirebaseAuth.instance.currentUser.uid)
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        IconBroken.Chat,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            UserChatScren(
                                              model: HomeCubit.get(context)
                                                  .accountModel,
                                            ));
                                      }),
                                  OutlinedButton(
                                      onPressed: () {
                                        HomeCubit.get(context).addFollowers(
                                            HomeCubit.get(context)
                                                .accountModel
                                                .uId);
                                        HomeCubit.get(context).addFollowing(
                                            FirebaseAuth
                                                .instance.currentUser.uid);
                                      },
                                      child:
                                          Text(LocaleKeys.following_text.tr())),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '${HomeCubit.get(context).followingLength}  ${LocaleKeys.following_text.tr()}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '${HomeCubit.get(context).followersLength}  ${LocaleKeys.followers_text.tr()}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyDivder(),
                    ],
                  ),
                ),
              )
            ],
          ),
          fallback: (context) => SizedBox(
            width: 400,
            height: 200,
            child: Lottie.asset('assets/images/amongus.json'),
          ),
        ));
      },
    );
  }
}
