import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/cubit.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';

import 'package:mansour_/modules/shop%20app/register/shop_register_screen.dart';
import 'package:mansour_/modules/shop%20app/sharedPreferences.dart/cash_helper.dart';
import 'package:mansour_/modules/shop%20app/shop%20layout/shop_layout.dart';
import 'package:mansour_/shared/components/constans.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class ShopLoginScreen extends StatelessWidget {
  // const ShopLoginScreen({Key? key}) : super(key: key);

  var emailControoler = TextEditingController();
  var passwordControoler = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              CashHelperShop.saveData(
                      key: 'token', value: state.shopLoginModel.data.token)
                  .then((value) {
                token = state.shopLoginModel.data.token;
                navigateAndFinish(context, ShopLayoutScreen());
              });

              // showToast(
              //     message: state.shopLoginModel.message,
              //     state: ToastStates.SUCCESS);
            } else {
              // showToast(
              //     message: state.shopLoginModel.message,
              //     state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(height: 30),
                        defaultField(
                            controller: emailControoler,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icon(Icons.email)),
                        SizedBox(height: 15),
                        defaultField(
                            onFieldSubmitted: (p0) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailControoler.text,
                                    password: passwordControoler.text);
                              }
                            },
                            isPassword:
                                ShopLoginCubit.get(context).isPasswordShown,
                            suffix: ShopLoginCubit.get(context).suffix,
                            controller: passwordControoler,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icon(Icons.lock_outlined),
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordisibility();
                            }),
                        SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailControoler.text,
                                      password: passwordControoler.text);
                                }
                              },
                              isUpperCase: true,
                              text: 'login'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                text: 'Register',
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
