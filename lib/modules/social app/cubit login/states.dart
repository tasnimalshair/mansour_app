import 'package:mansour_/modules/shop%20app/models/login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  // SocialLoginModel shopLoginModel;
  // SocialLoginSuccessState(this.shopLoginModel);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}
