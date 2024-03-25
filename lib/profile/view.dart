import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/navbar/logic.dart';
import 'package:myth_maker/utils/TokenUtils.dart';

import '../models/Post.dart';
import '../models/User.dart';
import '../widgets/customeLoading.dart';
import 'logic.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileLogic>(
      init: ProfileLogic(),
      builder: (profileLogic) {
        return GetBuilder<NavbarLogic>(
          init: NavbarLogic(),
          builder: (navbarLogic) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: FutureBuilder<User?>(
                  future: profileLogic.userDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: customeLoading(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data == null) {
                      return const Center(child: Text('User data not found'));
                    } else {
                      User user = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                            ),
                            Text(user.name),
                            Text('${user.posts.length}'),
                            Text('${user.id}'),
                            FutureBuilder<List<Post>>(
                              future: profileLogic.postsFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (snapshot.hasData) {
                                  return Container(
                                    width: 300,
                                    height: 500,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Post post = snapshot.data![index];
                                        return ListTile(
                                          title: Text(post.title),
                                          subtitle: Text(post.story),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Center(child: Text('No posts found'));
                                }
                              },
                            ),
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
      },
    );
  }
}
