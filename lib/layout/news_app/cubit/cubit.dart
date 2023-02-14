import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/layout/news_app/cubit/states.dart';
import 'package:mansour_/modules/news/business/business_screen.dart';
import 'package:mansour_/modules/news/network/remote/dio_helper.dart';
import 'package:mansour_/modules/news/sciences/science_screen.dart';
import 'package:mansour_/modules/news/settings/settings_screen.dart';
import 'package:mansour_/modules/news/sports/sport_screen.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> widgetsList = [
    BusinessScreen(),
    SportScreen(),
    SienceScreen(),
    // SettingScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    // if (index == 1) getSports();
    // if (index == 2) getSiences();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
// https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=dfcbcb60111f480587c2174c3d7bb2ba
  void getBusieness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apikey': 'dfcbcb60111f480587c2174c3d7bb2ba',
    }).then(
      (value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apikey': 'dfcbcb60111f480587c2174c3d7bb2ba',
      }).then(
        (value) {
          sports = value.data['articles'];
          emit(NewsGetSportSuccessState());
        },
      ).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List<dynamic> sciences = [];

  void getSiences() {
    emit(NewsGetScienceLoadingState());
    if (sciences.length == 0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apikey': 'dfcbcb60111f480587c2174c3d7bb2ba',
      }).then(
        (value) {
          sciences = value.data['articles'];
          emit(NewsGetScienceSuccessState());
        },
      ).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
// https://newsapi.org/v2/everything?q=tesla&apiKey=dfcbcb60111f480587c2174c3d7bb2ba
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    if (search.length == 0) {
      DioHelper.getData(path: 'v2/everything', query: {
        'q': '$value',
        'apikey': 'dfcbcb60111f480587c2174c3d7bb2ba',
      }).then(
        (value) {
          search = value.data['articles'];
          emit(NewsGetSearchSuccessState());
        },
      ).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }
}
