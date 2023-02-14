import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/login/end_points.dart';
import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/shop%20app/models/register_model.dart';
import 'package:mansour_/modules/shop%20app/register/cubit%20login/states.dart';
import 'package:mansour_/modules/social%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/social%20app/social%20register/cubit%20register/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // late RegisterModel registerModel;

  void userRegister(
      {required String name,
      required String email,
      required String phone}) {
    emit(SocialRegisterLoadingState());
    DioHelperSocial.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone
      },
      onSuccess: (response) {
        // registerModel = RegisterModel.fromJson(response.data);
        // emit(SocialRegisterSuccessState(registerModel));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(SocialRegisterErrorState(myError.toString()));
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
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
