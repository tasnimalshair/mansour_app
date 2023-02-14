import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/news/network/local/cash_helper.dart';
import 'package:mansour_/modules/tasks/archived.dart';
import 'package:mansour_/modules/tasks/done.dart';
import 'package:mansour_/modules/tasks/tasks.dart';
import 'package:mansour_/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInisialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> widgetsList = [Tasks(), Done(), Archived()];
  List<String> titlesList = ['Tasks', 'Done', 'Archived'];
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase('todo.db',
            version: 1,
            onCreate: (db, version) {
              db
                  .execute(
                      'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT ,date TEXT , time TEXT , status TEXT)')
                  .then((value) => print('suceess creating'))
                  .catchError((error) {
                print(error.toString());
              });
            },
            onOpen: (db) => {print('opened'), getDataFromDB(database)})
        .then((value) => {database = value, emit(AppCreateDBState())});
  }

  Future inserToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database
        .rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES ("$title" , "$date" , "$time" , "new")')
        .then((value) => {
              print('$value inserted successfully'),
              emit(AppInsertToDBState()),
              getDataFromDB(database),
            })
        .catchError((error) {
      print(error.toString());
    });
  }

  void getDataFromDB(database) {
    newTasks = [];
    archivedTasks = [];
    doneTasks = [];
    emit(AppGetLoadingFromDBState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status' == 'new'])
          newTasks.add(element);
        else if (element['status' == 'done'])
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetFromDBState());
    }).catchError((error) {
      print('Getting from open ERROR');
    });
  }

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeButtomNavBarState());
  }

  bool isShow = false;
  IconData icon = Icons.edit;

  void ChangeButtomSheetState({required IconData icon, required bool isShow}) {
    isShow = isShow;
    icon = icon;
    emit(AppChangeButtomNavBarState());
  }

  void UpdateDb({required String status, required int id}) async {
    await database.rawUpdate('UPDATE tasks SET status=? WHERE id=?', [
      '$status',
      id
    ]).then((value) => {
          getDataFromDB(database),
          emit(AppUpdateDBState()),
        });
  }

  void deleteDb({required int id}) async {
    await database
        .rawDelete('DELETE * FROM tasks WHERE id=?', [id]).then((value) => {
              getDataFromDB(database),
              emit(AppDeleteDBState()),
            });
  }

  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
