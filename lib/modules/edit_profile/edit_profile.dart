// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../home/cubit/home_cubit.dart';
import '../home/cubit/home_states.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeUserUpdateSuccessState) {
            showToast(
              text: "Profile updated successfully",
              state: ToastStates.SUCCESS,
            );
          }else if(state is HomeUserUpdateErrorState){
            showToast(
              text: "Error updating profile",
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          var fromKey = GlobalKey<FormState>();
          var nameController = TextEditingController();
          var bioController = TextEditingController();
          var phoneController = TextEditingController();
          var emailController = TextEditingController();

          nameController.text = userModel!.name;
          bioController.text = userModel!.bio;
          phoneController.text = userModel!.phone;
          emailController.text = userModel!.email;

          return ConditionalBuilder(
            condition: userModel != null,
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: const BackButton(
                  color: Colors.black,
                ),
                title: const Center(
                    child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: TextButton(
                      onPressed: () {
                        if (fromKey.currentState!.validate()) {
                          HomeCubit.get(context).updateUserData(
                            name: nameController.text,
                            bio: bioController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                      child: ConditionalBuilder(
                        condition: state is! HomeUserUpdateLoadingState,
                        builder: (context) => const Text(
                          "UPDATE",
                          style: TextStyle(color: Colors.black),
                        ),
                        fallback: (context) => const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.passthrough,
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryColor[50],
                              ),
                              child: HomeCubit.get(context).coverImage == null
                                  ? Image(
                                      image: NetworkImage(userModel!.cover ??
                                          "https://i.pinimg.com/564x/65/42/86/6542867f9f6907563dcd4e9756fa5027.jpg"),
                                      fit: BoxFit.fill,
                                    )
                                  : Image(
                                      image: FileImage(
                                          HomeCubit.get(context).coverImage!)),
                            ),
                            Column(
                              children: [
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 40,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .getCoverImage();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: primaryColor,
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: const EdgeInsets.fromLTRB(10, 50, 10, 1),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                                key: fromKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Username",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                      controller: nameController,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Name must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Bio",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                      controller: bioController,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Bio must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                      controller: phoneController,
                                      type: TextInputType.number,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "number must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Email Address",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Email must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container()),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
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
                                  child: HomeCubit.get(context).profileImage ==
                                          null
                                      ? Image(
                                          image: NetworkImage(userModel!
                                                  .image ??
                                              "https://i.pinimg.com/564x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg"),
                                          fit: BoxFit.cover,
                                        )
                                      : Image(
                                          image: FileImage(
                                              HomeCubit.get(context)
                                                  .profileImage!),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[50],
                                child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).getProfileImage();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Expanded(flex: 3, child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
          );
        },
      ),
    );
  }
}
