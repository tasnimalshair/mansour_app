import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/login/end_points.dart';
import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/shop%20app/models/register_model.dart';
import 'package:mansour_/modules/shop%20app/register/cubit%20login/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;

  void userRegister(
      {required String name,
      required String email,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelperShop.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone
      },
      onSuccess: (response) {
        registerModel = RegisterModel.fromJson(response.data);
        emit(ShopRegisterSuccessState(registerModel));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(ShopRegisterErrorState(myError.toString()));
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
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
