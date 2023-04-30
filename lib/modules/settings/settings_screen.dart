// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/modules/home/cubit/home_cubit.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../login/loginScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //profile screen
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor[50],
                    ),
                    child: Image(image: NetworkImage(userModel!.cover??"https://i.pinimg.com/564x/65/42/86/6542867f9f6907563dcd4e9756fa5027.jpg"),fit: BoxFit.fill,),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 190,
                            ),
                            InkWell(
                              onTap: () {
                                // print("General");
                                navigateTo(context, EditProfileScreen());
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundColor: primaryColor,radius: 25,child: Icon(Icons.settings,size: 30,color: Colors.white,)),
                                      SizedBox(width: 10,),
                                      Text("General",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("Privacy Settings");
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundColor: primaryColor,radius: 25,child: Icon(Icons.security,size: 30,color: Colors.white,)),
                                      SizedBox(width: 10,),
                                      Text("Privacy Settings",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("Payment History");
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundColor: primaryColor,radius: 25,child: Icon(Icons.payment,size: 30,color: Colors.white,)),
                                      SizedBox(width: 10,),
                                      Text("Payment History",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("Logout");
                                uId = null;
                                userModel = null;
                                HomeCubit.get(context).currentIndex = 0;
                                navigateAndFinish(context, LoginScreen());
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundColor: primaryColor,radius: 25,child: Icon(Icons.logout,size: 30,color: Colors.white,)),
                                      SizedBox(width: 10,),
                                      Text("Logout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 150, 10, 10),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 55.0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(55.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child:  Image(
                                  image: NetworkImage(
                                      userModel!.image??"https://i.pinimg.com/564x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            userModel!.name,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            userModel!.bio,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[900],
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                              "@${userModel!.uId}",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                          ),
                           ),
                          const SizedBox(
                            height: 10.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: primaryColor,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }
}
