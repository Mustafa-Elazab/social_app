import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/model/comment_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';

// ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  CommentScreen({
    Key key,
    @required this.postModel,
    @required this.uId,
    @required this.index,
  }) : super(key: key);

  final PostModel postModel;
  final int index;
  final String uId;
  TextEditingController commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var dateTime = DateFormat.jm().add_E().format(DateTime.now());
    HomeCubit.get(context).getComment(
        postId: HomeCubit.get(context).postsId[index],
        userId: uId,
        dateTime: dateTime);
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is PostCommentSucessState) {
        navigateAndFinish(context, HomeLayout());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Write Comment ')),
        ),
        body: ConditionalBuilder(
          condition: HomeCubit.get(context).listCommentModel != null,
          builder: (context) => Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => buildComment(context,
                            HomeCubit.get(context).listCommentModel[index]),
                        separatorBuilder: (context, index) => MyDivder(),
                        itemCount:
                            HomeCubit.get(context).listCommentModel.length)),
                bottomCommentArea(context, dateTime),
              ],
            ),
          ),
          fallback: (context) => SizedBox(
            width: 400,
            height: 200,
            child: Lottie.asset('assets/images/amongus.json'),
          ),
        ),
      );
    });
  }

  Widget buildComment(context, CommentModel model) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    HomeCubit.get(context).userCommentModel.profileImage,
                  ),
                  radius: MediaQuery.of(context).size.height / 34,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20.0),
                          bottomEnd: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(HomeCubit.get(context).userCommentModel.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                          Text(
                            model.commenttext,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.dateTime,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      );
  Widget bottomCommentArea(context, dateTime) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    HomeCubit.get(context).userModel.profileImage,
                  ),
                  radius: MediaQuery.of(context).size.height / 40,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                        hintText: 'Write a comment', border: InputBorder.none),
                    onFieldSubmitted: (String vlaue) {
                      HomeCubit.get(context).writeComment(
                          postId: HomeCubit.get(context).postsId[index],
                          comment: commentController.text.toString(),
                          dateTime: dateTime,
                          userId: uId);
                      commentController.text = '';
                    }),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(IconBroken.Send, color: Colors.lightBlueAccent),
                  onPressed: () {
                    var dateTime =
                        DateFormat.jm().add_E().format(DateTime.now());
                    HomeCubit.get(context).writeComment(
                        postId: HomeCubit.get(context).postsId[index],
                        comment: commentController.text.toString(),
                        dateTime: dateTime,
                        userId: uId);
                    commentController.text = '';
                  }),
            )
          ],
        ),
      );
}
