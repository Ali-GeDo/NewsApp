import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit_from_todoapp/app_cubit.dart';
import 'package:news_app/componants/components.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/mdoules/search_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsHomeScreen extends StatelessWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStats>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigatTo(context, SearchScreen());
                },
                icon:Icon(Icons.search),
              ),
              IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();
                },
                icon:Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: NewsCubit.get(context).bottomItems,
            onTap: (index) {
              cubit.changBottomNavbar(index);
            },
          ),
        );
      },
    );
  }
}
