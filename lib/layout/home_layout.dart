import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/app/bloc/homecubit.dart';
import 'package:social_app/modeuls/app/bloc/homestates.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocProvider(
      create: (context) => BlocProvider.of(context),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return new WillPopScope(
            onWillPop: () async {
              if (homeCubit.currentIndex == 0) return true;
              setState(() {
                homeCubit.currentIndex = 0;
              });
              return false;
            },
            child: Scaffold(
              body: HomeCubit.get(context).screens[homeCubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: homeCubit.bottomItem,
                currentIndex: homeCubit.currentIndex,
                onTap: (index) {
                  homeCubit.changebottomnavbar(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
