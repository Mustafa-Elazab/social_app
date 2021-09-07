import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';
import 'package:social_app/modeuls/app/home_app/account_screen.dart';
import 'package:social_app/shared/styles/icon/icon_broken.dart';
import 'package:social_app/shared/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  QuerySnapshot<Map<String, dynamic>> snapshotData;

  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (comtext, state) {},
        builder: (comtext, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(IconBroken.Search),
                      onPressed: () {
                        HomeCubit.get(context).getSearchResult(controller.text);
                      }),
                ],
                title: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: LocaleKeys.search_text.tr(),
                    ),
                    controller: controller,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'search is empty!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      HomeCubit.get(context).getSearchResult(controller.text);
                    },
                  ),
                ),
              ),
              body: controller.text.isNotEmpty
                  ? buildSearchResult(context)
                  : Container(
                      child: Center(
                          child: Text(LocaleKeys.search_error_text.tr())),
                    ));
        });
  }

  Widget buildSearchResult(context) {
    return ListView.builder(
        itemCount: HomeCubit.get(context).snapshotData.docs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                  settings: RouteSettings(
                      arguments: HomeCubit.get(context).snapshotData.docs[index]
                          ['uId']),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(HomeCubit.get(context)
                    .snapshotData
                    .docs[index]['profileImage']),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(HomeCubit.get(context).snapshotData.docs[index]['name']),
                  Text(
                    HomeCubit.get(context).snapshotData.docs[index]['bio'],
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
