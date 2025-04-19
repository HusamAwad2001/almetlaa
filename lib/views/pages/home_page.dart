import '../../views/fragments/videos_channel_fragment.dart';

import '../../controller/home_controller.dart';
import '../../values/constants.dart';
import '../../views/fragments/home_fragment.dart';
import '../../views/fragments/profile_fragment.dart';
import '../../views/fragments/questions_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedPage,
            children: [
              const HomeFragment(),
              const VideosChannelFragment(),
              // const SuggestionsPage(),
              const QuestionsFragment(),
              const ProfileFragment(),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                height: 0,
                color: Colors.grey[300],
                // color: Constants.primaryColor.withValues(alpha: 0.3),
              ),
              NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle: WidgetStateProperty.resolveWith(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return TextStyle(
                        // color: Constants.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      );
                    }
                    return TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    );
                  }),
                  indicatorShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                    ),
                  ),
                  indicatorColor: Constants.primaryColor,
                  backgroundColor: Colors.white,
                ),
                child: NavigationBar(
                  selectedIndex: controller.selectedPage,
                  onDestinationSelected: (index) {
                    if (index != controller.selectedPage) {
                      controller.selectedPage = index;
                      controller.update();
                    }
                  },
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: 'الرئيسية',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.video_collection_outlined),
                      selectedIcon: Icon(
                        Icons.video_collection,
                        color: Colors.white,
                      ),
                      label: 'الفيديوهات',
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.question_answer_outlined),
                      selectedIcon: const Icon(
                        Icons.question_answer,
                        color: Colors.white,
                      ),
                      label: 'الاسئلة',
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.person_outline),
                      selectedIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: 'حسابي',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
