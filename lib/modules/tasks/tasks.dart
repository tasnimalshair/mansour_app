import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/tasks/helper.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:mansour_/shared/cubit/cubit.dart';
import 'package:mansour_/shared/cubit/states.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return tasksBuilder(tasks: AppCubit.get(context).newTasks);
      },
    );
  }
}
