import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is UserCreatePostSucessState) {
        navigateAndFinish(context, HomeLayout());
        HomeCubit.get(context).removePostImage();
        textController.text = '';
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: TextButton(
                onPressed: () {
                  var dateFormat =
                      DateFormat.yMEd().add_jms().format(DateTime.now());
                  if (HomeCubit.get(context).postImage == null) {
                    HomeCubit.get(context).createPost(
                      postText: textController.text,
                      dateTime: dateFormat.toString(),
                    );
                  } else {
                    HomeCubit.get(context).uploadPostImage(
                      postText: textController.text,
                      dateTime: dateFormat.toString(),
                    );
                  }
                },
                child: Text(
                  '${LocaleKeys.post_text.tr()}',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is UserCreatePostLoadingState)
                  LinearProgressIndicator(
                    minHeight: 4.0,
                    backgroundColor: Colors.yellowAccent,
                  ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            HomeCubit.get(context).userModel.profileImage),
                        radius: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      HomeCubit.get(context).userModel.name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.3),
                    ),
                  ],
                ),
                Container(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: LocaleKeys.post_area_text.tr(),
                        border: InputBorder.none),
                    maxLength: 240,
                    minLines: 2,
                    maxLines: 7,
                  ),
                ),
                if (HomeCubit.get(context).postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4)),
                                  image: DecorationImage(
                                      image: FileImage(
                                          HomeCubit.get(context).postImage),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onPressed: () {
                                    HomeCubit.get(context).removePostImage();
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FabCircularMenu(
            fabMargin: EdgeInsets.all(40),
            ringColor: Colors.grey.shade100,
            fabElevation: 2,
            fabSize: 60,
            fabOpenColor: Colors.blueAccent,
            children: [
              IconButton(
                  icon: Icon(
                    IconBroken.Camera,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).getpostCameraImage();
                  }),
              IconButton(
                  icon: Icon(
                    IconBroken.Image_2,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).getpostImage();
                  }),
              IconButton(
                  icon: Icon(
                    IconBroken.User1,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    IconBroken.Document,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    IconBroken.Location,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {}),
            ]),
      );
    });
  }
}

  


 /*_getImageList() async {
    var resultList = await MultiImagePicker.pickImages(
      maxImages: 6,
      enableCamera: true,
    );

    // The data selected here comes back in the list
    for (var imageFile in resultList) {
      await postImage(imageFile).then((downloadUrl) {
        // Get the download URL and do your stuff here
      }).catchError((err) {
        print(err);
      });
    }
  }*/
  

