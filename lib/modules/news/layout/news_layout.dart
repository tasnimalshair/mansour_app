import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/layout/news_app/cubit/cubit.dart';
import 'package:mansour_/layout/news_app/cubit/states.dart';
import 'package:mansour_/modules/news/network/remote/dio_helper.dart';
import 'package:mansour_/modules/news/search/search_screen.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:mansour_/shared/cubit/cubit.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.list,
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeIndex(value),
            ),
            body: cubit.widgetsList[cubit.currentIndex],
          );
        });
  }
}
