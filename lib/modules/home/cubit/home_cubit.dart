import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';
import 'package:social_app/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserDate() {
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
}
