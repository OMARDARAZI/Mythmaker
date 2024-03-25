import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/widgets/userTile.dart';
import 'logic.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final logic = Get.put(SearchLogic());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GetBuilder<SearchLogic>(
        init: SearchLogic(),
        builder: (logic) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Iconsax.arrow_left_2,
                    color: Colors.black,
                    size: 35.sp,
                  ),
                ),
                title: Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                    color: black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        autofocus: true,
                        cursorColor: Colors.grey,
                        controller: logic.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: IconButton(
                              onPressed: () {
                                logic.clearSearch();
                              },
                              icon: Icon(
                                Icons.highlight_remove_outlined,
                                color: Colors.grey,
                              )),
                          prefixIcon: const Icon(
                            Iconsax.search_normal,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 25.0,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TabBar(
                      indicatorColor: Colors.black,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      indicatorWeight: 1,
                      labelColor: Colors.black,
                      isScrollable: false,
                      labelStyle: TextStyle(fontSize: 20.sp),
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'People'),
                        Tab(text: 'Posts'),
                      ],
                    ),
                    SizedBox(
                      height:MediaQuery.sizeOf(context).height,
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return userTile(userName: 'userName', pfpLink: 'pfpLink');
                            },
                          ),
                          const Center(child: Text('People Search')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
