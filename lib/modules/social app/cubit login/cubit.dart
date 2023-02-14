import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/login/end_points.dart';
import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/social%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/social%20app/cubit%20login/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    DioHelperSocial.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
      onSuccess: (response) {
        // loginModel = SocialLoginModel.fromJson(response.data);
        // emit(SocialLoginSuccessState(loginModel));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(SocialLoginErrorState(myError.toString()));
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
    emit(SocialChangePasswordVisibilityState());
  }
}
