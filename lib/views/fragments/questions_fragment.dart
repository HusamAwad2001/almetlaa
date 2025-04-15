import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/questions_controller.dart';
import '../widgets/shimmer/questions_shimmer.dart';

class QuestionsFragment extends StatelessWidget {
  const QuestionsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "سؤال و جواب",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<QuestionsController>(
        init: QuestionsController(),
        builder: (controller) {
          return controller.loadingQuestions
              ? const QuestionsShimmer()
              : controller.questions.isEmpty
                  ? const Center(
                      child: Text('لا يوجد أسئلة'),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(20.w),
                      itemCount: controller.questions.length,
                      separatorBuilder: (context, index) => 10.ph,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          clipBehavior: Clip.antiAlias,
                          expandedAlignment: Alignment.centerRight,
                          collapsedIconColor: const Color(0xFF374957),
                          childrenPadding: EdgeInsets.only(
                            left: 18.w,
                            right: 18.w,
                            bottom: 25.h,
                          ),
                          // trailing: const SizedBox(),
                          onExpansionChanged: (value) =>
                              controller.checkOpened(value),
                          title: Text(
                            controller.questions[index]['question'],
                            style: TextStyle(
                              fontSize: 15.sp,
                              height: 1.5.h,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF545454),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: const BorderSide(
                              color: Color(0xFFE9E9E9),
                              width: 1,
                            ),
                          ),
                          iconColor: const Color(0xFF374957),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: const BorderSide(
                              color: Color(0xFFE9E9E9),
                              width: 1,
                            ),
                          ),
                          children: [
                            Text(
                              controller.questions[index]['answer'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 2.h,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF545454),
                              ),
                            ),
                          ],
                        );
                      },
                    );
        },
      ),
    );
  }
}
