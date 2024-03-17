import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/navbar/logic.dart';

import '../models/User.dart';
import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileLogic>(
        init: ProfileLogic(),
        builder: (profileLogic) {
      return GetBuilder<NavbarLogic>(
        init: NavbarLogic(),
        builder: (navbarLogic) {
          return  SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: FutureBuilder<User?>(
                future:navbarLogic.fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null) {
                    return const Center(child: Text('User data not found'));
                  } else {
                    User user = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('${user.posts.length}')
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      );
    },);
  }
}
