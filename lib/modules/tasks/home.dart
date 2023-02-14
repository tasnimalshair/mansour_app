import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_/modules/tasks/archived.dart';
import 'package:mansour_/modules/tasks/done.dart';
import 'package:mansour_/modules/tasks/helper.dart';
import 'package:mansour_/modules/tasks/tasks.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:mansour_/shared/cubit/cubit.dart';
import 'package:mansour_/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDBState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titlesList[AppCubit.get(context).currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isShow) {
                  if (formKey.currentState!.validate()) {
                    cubit.inserToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  cubit.ChangeButtomSheetState(icon: Icons.add, isShow: true);
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultField(
                                            controller: titleController,
                                            type: TextInputType.text,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'Title must not be empty';
                                              }
                                              return null;
                                            },
                                            label: 'Task Title',
                                            prefix: Icon(Icons.title)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        defaultField(
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                timeController.text = value!
                                                    .format(context)
                                                    .toString();
                                              });
                                            },
                                            controller: timeController,
                                            type: TextInputType.datetime,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'Time must not be empty';
                                              }
                                              return null;
                                            },
                                            label: 'Task Time',
                                            prefix: Icon(
                                                Icons.watch_later_outlined)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        defaultField(
                                            onTap: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2029-05-03'))
                                                  .then((value) => {
                                                        dateController.text =
                                                            DateFormat.yMMMd()
                                                                .format(value!)
                                                      });
                                            },
                                            controller: dateController,
                                            type: TextInputType.datetime,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'Date must not be empty';
                                              }
                                              return null;
                                            },
                                            label: 'Task Date',
                                            prefix: Icon(Icons.calendar_today)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          elevation: 20)
                      .closed
                      .then((value) => {
                            cubit.ChangeButtomSheetState(
                                icon: Icons.edit, isShow: false),
                            // AppCubit.get(context).icon = Icons.edit,
                            // AppCubit.get(context).isShow = false
                          });

                  // AppCubit.get(context).icon = Icons.add;
                  // AppCubit.get(context).isShow = true;
                }

                // InserToDatabase();

                // getName().then((value) {
                //   print(value);
                //   print('lama');
                //   throw ('error!!!!!');
                // }).catchError((error) {
                //   print(error.toString());
                // });
              },
              child: Icon(AppCubit.get(context).icon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.ChangeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ]),
            body: ConditionalBuilder(
              condition: state is! AppGetLoadingFromDBState,
              builder: (context) => cubit.widgetsList[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
