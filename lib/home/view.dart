import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/navbar/logic.dart';
import 'package:myth_maker/search/view.dart';
import 'package:myth_maker/widgets/pfp.dart';
import 'package:myth_maker/widgets/shimmer.dart';
import 'package:myth_maker/widgets/storyCard.dart';

import '../models/Post.dart';
import '../utils/userInfo.dart';
import '../widgets/customeLoading.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: GetBuilder<HomeLogic>(
        init: HomeLogic(),
        builder: (homeLogic) {
          return GetBuilder<NavbarLogic>(
            init: NavbarLogic(),
            builder: (navbarLogic) {
              return RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () => homeLogic.handleRefresh(),
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  body: SingleChildScrollView(
                    controller: navbarLogic.scrollController,
                    physics:ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MythMaker',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              pfp(
                                userName: '${UserData().name}',
                                pfpLink: '${UserData().pfp}',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => SearchPage(),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            child: Container(
                              width: 350.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const Icon(
                                    Iconsax.search_normal,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const Text(
                                    'Search',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder<List<Post>>(
                          future: homeLogic.fetchPostsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              //Shimmer
                              return GridView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 600.h,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 30),
                                            child: Row(
                                              children: [
                                                shimmerContainer(
                                                  width: 40,
                                                  height: 40,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                shimmerContainer(
                                                  width: 90,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 300,
                                                  height: 200,
                                                  child: shimmerContainer(),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: [
                                                shimmerContainer(
                                                  width: 200,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 300.w,
                                                  child: shimmerContainer(
                                                    width: 200,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: [
                                                shimmerContainer(
                                                  width: 80,
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: [
                                                shimmerContainer(
                                                  width: 80,
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {

                              return Container();
                            } else if (snapshot.hasData) {
                              return GridView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 600.h,
                                ),
                                itemBuilder: (context, index) {
                                  Post post = snapshot.data![index];

                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: storyCard(
                                      pfpLink: post.postedBy.pfp,
                                      story: post.story,
                                      title: post.story,
                                      image: post.image,
                                      comments: post.comments.length,
                                      likes: post.likes.length,
                                      username: post.postedBy.name,
                                      date: post.createdAt,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text('No posts found'));
                            }
                          },
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
