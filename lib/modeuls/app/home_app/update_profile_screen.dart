import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Helper/HelperMethods.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/splash_view/splash_view.dart';
import 'package:social_app/shared/network/local/sharedpreferenceHelper.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';

// ignore: must_be_immutable
class UpdateProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = cubit.userModel;
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.edit_profile_text.tr()),
            actions: [
              TextButton(
                onPressed: () {
                  cubit.updateUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: Text(
                  LocaleKeys.update_text.tr(),
                  style: TextStyle(color: Colors.blueAccent)
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is UpdateUserDataLoadingState)
                          LinearProgressIndicator(
                            minHeight: 4.0,
                            backgroundColor: Colors.yellowAccent,
                          ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3,
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            topLeft: Radius.circular(4)),
                                        image: DecorationImage(
                                            image: coverImage == null
                                                ? NetworkImage(
                                                    'https://pbs.twimg.com/profile_banners/2250678176/1622674034/1500x500')
                                                : FileImage(coverImage),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    IconButton(
                                        icon: CircleAvatar(
                                          child: Icon(
                                            IconBroken.Camera,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.getCoverImage();
                                        })
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                                  12 +
                                              1,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        backgroundImage: profileImage == null
                                            ? NetworkImage(
                                                cubit.userModel.profileImage)
                                            : FileImage(profileImage),
                                        radius:
                                            MediaQuery.of(context).size.height /
                                                12,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: CircleAvatar(
                                        child: Icon(
                                          IconBroken.Camera,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.getProfileImage();
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: defaultTextFormField(
                              controller: nameController,
                              type: TextInputType.text,
                              validate_message: LocaleKeys.name_error_text.tr(),
                              prefixIcon: IconBroken.Profile,
                              label: LocaleKeys.name_text.tr()),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: defaultTextFormField(
                              controller: bioController,
                              type: TextInputType.text,
                              validate_message: 'bio is Empty',
                              prefixIcon: IconBroken.Info_Circle,
                              label: LocaleKeys.bio_text.tr()),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: defaultTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate_message: 'phone is Empty',
                              prefixIcon: IconBroken.Call,
                              label: LocaleKeys.phone_text.tr()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () async {
                                  await context.setLocale(Locale('en'));
                                  Phoenix.rebirth(context);
                                },
                                child: Text('English')),
                            OutlinedButton(
                                onPressed: () async {
                                  await context.setLocale(Locale('ar'));
                                  Phoenix.rebirth(context);
                                },
                                child: Text('العربية'))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        buildBtn(LocaleKeys.sign_out_text.tr(), Colors.red, () {
                          CacheHelper.removeData();
                          FirebaseAuth.instance.signOut();
                          navigateAndFinish(context, SplashView());
                          Phoenix.rebirth(context);
                        }, width: MediaQuery.of(context).size.width / 2),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
