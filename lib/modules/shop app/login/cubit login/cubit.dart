import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/login/end_points.dart';
import 'package:mansour_/modules/shop%20app/models/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelperShop.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
      onSuccess: (response) {
        loginModel = ShopLoginModel.fromJson(response.data);
        emit(ShopLoginSuccessState(loginModel));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(ShopLoginErrorState(myError.toString()));
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordisibility() {
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(ShopChangePasswordVisibilityState());
  }
}
