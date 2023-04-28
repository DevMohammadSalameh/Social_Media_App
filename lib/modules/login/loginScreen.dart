// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/home_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../register/registerScreen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showToast(text: state.Error, state:
            ToastStates.ERROR);
          }
          if(state is LoginSuccessState){
            showToast(text: "Login Success", state: ToastStates.SUCCESS);
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "login in now to browse your friends and chat with them",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else {
                              if (!(value.contains('@') ||
                                  value.contains('.'))) {
                                return "pleas enter a valid email, example@mail.com ";
                              }
                            }
                            return null;
                          },
                          label: "email",
                          labelStyle: TextStyle(color: primaryColor),
                          suffix: Icons.email),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "password cannot be empty";
                          }
                          return null;
                        },
                        label: "password",
                        labelStyle: TextStyle(color: primaryColor),
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        suffix: LoginCubit.get(context).passwordIcon,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordState();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Text(
                              "JOIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            fallback: (context) => CircularProgressIndicator(
                              color: secondaryColor,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Don't have an account ?"),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              ),
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                "Create an account",
                                style: TextStyle(color: primaryColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
