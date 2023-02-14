import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/shop%20app/models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  RegisterModel shopLoginModel;
  ShopRegisterSuccessState(this.shopLoginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
