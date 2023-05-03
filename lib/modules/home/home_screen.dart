import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/home_cubit.dart';
import 'package:social_app/modules/home/cubit/home_states.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../new_post/new_post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeNewPostState) {
          navigateTo(context, const NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: userModel != null,
            builder: (context) => Scaffold(

              appBar: buildAppBar(context, HomeCubit.get(context).currentIndex),
              body: HomeCubit.get(context)
                  .screens[HomeCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: "Chats",
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box_outlined),
                    label: "Post",
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Users",
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings",
                    backgroundColor: primaryColor,
                  ),
                ],
                currentIndex: HomeCubit.get(context).currentIndex,
                onTap: (index) {
                  HomeCubit.get(context).changeBottomNavBar(index);
                },
              ),
            ),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator(color: primaryColor)),
          ),
        );
      },
    );
  }
  AppBar? buildAppBar(context,index) {
    if(index == 4) {
      return null;
    }
    return AppBar(
      title: Text(HomeCubit.get(context)
          .titles[HomeCubit.get(context).currentIndex]),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
