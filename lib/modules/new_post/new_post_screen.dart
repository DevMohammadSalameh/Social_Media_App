import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("New Post"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.close),
      )
    );
  }
}
