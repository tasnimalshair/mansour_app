import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/cubit.dart';
import 'package:mansour_/modules/shop%20app/login/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/register/cubit%20login/cubit.dart';
import 'package:mansour_/modules/shop%20app/register/cubit%20login/states.dart';
import 'package:mansour_/modules/shop%20app/sharedPreferences.dart/cash_helper.dart';
import 'package:mansour_/modules/shop%20app/shop%20layout/shop_layout.dart';
import 'package:mansour_/shared/components/constans.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopRegisterCubit>(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.shopLoginModel.status!) {
              CashHelperShop.saveData(
                      key: 'token', value: state.shopLoginModel.data!.token)
                  .then((value) {
                token = state.shopLoginModel.data!.token!;
                navigateAndFinish(context, ShopLayoutScreen());
              });
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(height: 30),
                        defaultField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icon(Icons.person)),
                        SizedBox(height: 15),
                        defaultField(
                            controller: emailController,
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
                            onFieldSubmitted: (p0) {},
                            isPassword:
                                ShopRegisterCubit.get(context).isPasswordShown,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            controller: passwordController,
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
                              ShopRegisterCubit.get(context)
                                  .changePasswordisibility();
                            }),
                        SizedBox(height: 15),
                        defaultField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icon(Icons.phone)),
                        SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  // ShopRegisterCubit.get(context).userRegister(
                                  //     name: nameController.text,
                                  //     email: emailController.text,
                                  //     phone: phoneController.text);
                                }
                              },
                              isUpperCase: true,
                              text: 'register'),
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
