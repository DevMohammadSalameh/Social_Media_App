// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/home_cubit.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserDate(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).userModel != null,
            builder:(context) =>  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Text("Home"),
                  ),
                ),
                ConditionalBuilder(
                  condition: FirebaseAuth.instance.currentUser!.emailVerified,
                  builder: (context) {
                    return Container();
                  },
                  fallback: (context) => Container(
                    margin: EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [primaryColor.withOpacity(.7),primaryColor,primaryColor.withOpacity(.8)]),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.0,),
                        Icon(Icons.info_outline,size:35,),
                        SizedBox(width: 10.0,),
                        Text("Please Verify Your Email",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),),
                        Spacer(),
                        defaultTextButton(
                          function: (){
                            FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                              showToast(text: "Check Your Email", state: ToastStates.SUCCESS);
                            }).catchError((error){
                              showToast(text: error.toString(), state: ToastStates.ERROR);
                            });

                          },
                          child: Text("SEND"
                            ,style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),),
                          borderRadius: 50.0,
                          btnHeight: 40.0,
                          btnWidth: 70.0,
                          background: secondaryColor[300]!,
                        ),
                        SizedBox(width: 10.0,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },),
    );
  }
}
