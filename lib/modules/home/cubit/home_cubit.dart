
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../chat/chat_screen.dart';
import '../../feeds/feeds_screen.dart';
import '../../settings/settings_screen.dart';
import '../../users/users_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chat",
    "Add Post",
    "Users",
    "Settings",
  ];

  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(HomeNewPostState());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavBarState());
    }
  }

  void getUserData() {
    emit(HomeLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      // //print("DocumentSnapshot : ${value.data()}");
      // //print("user Id : $uId");
      userModel = UserModel.fromJson(value.data());
      //print("User Model : \n name :${userModel!.name}\n image :${userModel!.image}\n cover :${userModel!.cover}\n email :${userModel!.email}\n");
      emit(HomeSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(HomeErrorState());
    });
  }

  File? pickedProfileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedProfileImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccessState());
      //print("pickedProfileImage : $pickedProfileImage");
      if (pickedProfileImage != null) {
        uploadProfileImage();
        //print("Done Upload Profile Image");
      }
    } else {
      showToast(text: "No Image Selected", state: ToastStates.WARNING);
      emit(HomeProfileImagePickedErrorState());
    }
  }

  File? pickedCoverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedCoverImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccessState());
      //print("pickedCoverImage : $pickedCoverImage");
      if (pickedCoverImage != null) {
        uploadCoverImage();
        //print("Done Upload Cover Image");
      }
    } else {
      showToast(text: "No Image Selected", state: ToastStates.WARNING);
      emit(HomeProfileImagePickedErrorState());
    }
  }

  String? profileImageUrl = userModel?.image;
  void uploadProfileImage() {
    //print("Profile Image : $pickedProfileImage");
    //print("Profile Image Path : ${Uri.file(pickedProfileImage!.path).pathSegments.last}");
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(pickedProfileImage!.path).pathSegments.last}")
        .putFile(pickedProfileImage!)
        .then((value) {
      //print("Task : ${value.toString()}");
      value.ref.getDownloadURL().then((value) {
        //print("Profile Image Download URL $value");
        profileImageUrl = value;
        emit(HomeUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadProfileImageErrorState());
      });
    }).catchError((error) {
      //print(error.toString());
      emit(HomeUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl = userModel?.cover;

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(pickedCoverImage!.path).pathSegments.last}")
        .putFile(pickedCoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //print("Cover Image Download URL $value");
        coverImageUrl = value;
        emit(HomeUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadCoverImageErrorState());
      });
    }).catchError((error) {
      //print(error.toString());
      emit(HomeUploadCoverImageErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
    required String bio,
  }) {
    emit(HomeUserUpdateLoadingState());

    UserModel uploadModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      image: profileImageUrl ?? userModel!.image,
      cover: coverImageUrl ?? userModel!.cover,
      email: email,
      isVerified: false,
    );
    //print("on Send image URL : $profileImageUrl");
    //print("on Send User Model image : ${userModel?.image}");
    //print("on Send cover URL : $coverImageUrl");
    //print("on Send User Model cover : ${userModel?.cover}");
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update(uploadModel.toMap())
        .then((value) {
      getUserData();
      emit(HomeUserUpdateSuccessState());
    }).catchError((error) {
      emit(HomeUserUpdateErrorState());
    });
  }
}
