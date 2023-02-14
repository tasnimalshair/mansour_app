import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:mansour_/shared/cubit/cubit.dart';
import 'package:mansour_/shared/cubit/states.dart';

class Archived extends StatelessWidget {
  const Archived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return tasksBuilder(tasks: AppCubit.get(context).archivedTasks);
      },
    );
  }
}
