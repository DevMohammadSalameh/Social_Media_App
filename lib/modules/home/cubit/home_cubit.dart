import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());

  HomeCubit get(context) => BlocProvider.of(context);

}