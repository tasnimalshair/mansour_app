import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/layout/news_app/cubit/cubit.dart';
import 'package:mansour_/layout/news_app/cubit/states.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class SienceScreen extends StatelessWidget {
  const SienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sciences;
        return articleBuilder(list, context);
      },
    );
  }
}
