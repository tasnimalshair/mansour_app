import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/social%20app/cubit%20login/cubit.dart';
import 'package:mansour_/modules/social%20app/cubit%20login/states.dart';
import 'package:mansour_/modules/social%20app/social%20register/cubit%20register/social_register_screen.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailControoler = TextEditingController();
  var passwordControoler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialLoginCubit>(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {},
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
                          'login now to communicate with friends',
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
                                // SocialLoginCubit.get(context).userLogin(
                                //     email: emailControoler.text,
                                //     password: passwordControoler.text);
                              }
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPasswordShown,
                            suffix: SocialLoginCubit.get(context).suffix,
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
                              SocialLoginCubit.get(context)
                                  .changePasswordisibility();
                            }),
                        SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  // SocialLoginCubit.get(context).userLogin(
                                  //     email: emailControoler.text,
                                  //     password: passwordControoler.text);
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
                                  navigateTo(context, SocialRegisterScreen());
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
