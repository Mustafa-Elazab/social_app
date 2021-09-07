import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/chat/chat_screen.dart';
import 'package:social_app/modeuls/app/home_app/post_item.dart';
import 'package:social_app/shared/bloc/app_cubit.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  TextEditingController postController = new TextEditingController();

  Map<String, TextEditingController> controllersmap = Map();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          /* List<TextEditingController> _controllers = List.filled(
              HomeCubit.get(context).posts.length, TextEditingController());*/

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'MaTea',
                  style: TextStyle(
                    fontFamily: 'Signatra',
                    fontSize: 30,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();
                      //AppCubit.get(context).changeAppLang();
                    },
                  ),
                  IconButton(
                    icon: Icon(IconBroken.Send),
                    onPressed: () {
                      navigateTo(context, ChatScreen());
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                    child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: HomeCubit.get(context).posts.length > 0,
                      builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Item(
                                postModel: HomeCubit.get(context).posts[index],
                                index: index,
                              ),

                          //  buildPostItem(context, HomeCubit.get(context).posts[index],index,commentController),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 0,
                              ),
                          itemCount: HomeCubit.get(context).posts.length),
                      fallback: (context) => Column(
                        children: [
                          SizedBox(
                            width: 400,
                            height: 200,
                            child: Lottie.asset('assets/images/amongus.json'),
                          ),
                          Text('There is no post Yet ! try add one')
                        ],
                      ),
                    ),
                  ],
                )),
              ));
        });
  }
}
