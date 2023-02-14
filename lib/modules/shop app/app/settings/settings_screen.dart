import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/cubit/cubit.dart';
import 'package:mansour_/modules/shop%20app/cubit/states.dart';
import 'package:mansour_/modules/shop%20app/register/cubit%20login/cubit.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            var model = ShopCubit.get(context).userModel;
            nameController.text = model!.data.name;
            emailController.text = model.data.email;
            phoneController.text = model.data.phone;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20),
                    defaultField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icon(Icons.person)),
                    SizedBox(height: 20),
                    defaultField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icon(Icons.lock)),
                    SizedBox(height: 20),
                    defaultField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icon(Icons.phone)),
                    SizedBox(height: 20),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'Update'),
                    SizedBox(height: 20),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout')
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
