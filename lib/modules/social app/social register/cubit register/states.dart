import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/shop%20app/models/register_model.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  // RegisterModel shopLoginModel;
  // SocialRegisterSuccessState(this.shopLoginModel);
}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}
