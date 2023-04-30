// ignore_for_file: avoid_print

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
      print("DocumentSnapshot : ${value.data()}");
      print("user Id : $uId");
      userModel = UserModel.fromJson(value.data());
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccessState());
    } else {
      showToast(text: "No Image Selected", state: ToastStates.WARNING);
      emit(HomeProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccessState());
    } else {
      showToast(text: "No Image Selected", state: ToastStates.WARNING);
      emit(HomeProfileImagePickedErrorState());
    }
  }

  String profileImageUrl = userModel != null ?userModel!.image: "https://i.pinimg.com/564x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg";
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        emit(HomeUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(HomeUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = userModel != null? userModel!.cover:"https://i.pinimg.com/564x/65/42/86/6542867f9f6907563dcd4e9756fa5027.jpg";
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        emit(HomeUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
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

      uploadProfileImage();

    uploadCoverImage();
      UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        uId: userModel!.uId,
        image: profileImageUrl,
        cover: coverImageUrl,
        email: email,
        isVerified: false,
      );
      FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(HomeUserUpdateSuccessState());
      }).catchError((error) {
        emit(HomeUserUpdateErrorState());
      });
  }
}
