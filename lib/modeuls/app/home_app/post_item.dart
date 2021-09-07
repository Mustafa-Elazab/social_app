import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/Helper/compoments.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/account_screen.dart';
import 'package:social_app/modeuls/app/home_app/comment_screen.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Item extends StatelessWidget {
  const Item({
    Key key,
    @required this.postModel,
    @required this.index,
  }) : super(key: key);

  final PostModel postModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is GetPostsSucessState) {}
    }, builder: (context, state) {
      return Container(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                            settings: RouteSettings(arguments: postModel.uId),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(postModel.profileImage),
                        radius: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.3),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          if (postModel.isEmailVertified)
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
                        postModel.dateTime,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.3),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
                ],
              ),
              MyDivder(),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  postModel.text,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (postModel.postImage != '')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image(
                    image: NetworkImage(postModel.postImage),
                    fit: BoxFit.scaleDown,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context)
                          .likePost(HomeCubit.get(context).postsId[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Icon(HomeCubit.get(context).likeIcon),
                          Text(
                              '${HomeCubit.get(context).likes[index]} ${LocaleKeys.like_text.tr()}'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          CommentScreen(
                            postModel: HomeCubit.get(context).posts[index],
                            uId: uId,
                            index: index,
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Icon(IconBroken.Chat),
                          Text(
                              '${HomeCubit.get(context).listCommentModel.length} ${LocaleKeys.comment_text.tr()}'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Icon(IconBroken.Send),
                          Text(LocaleKeys.share_text.tr()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}
