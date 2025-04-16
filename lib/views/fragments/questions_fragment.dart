import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/questions_controller.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/shimmer/questions_shimmer.dart';

class QuestionsFragment extends StatefulWidget {
  const QuestionsFragment({super.key});

  @override
  State<QuestionsFragment> createState() => _QuestionsFragmentState();
}

class _QuestionsFragmentState extends State<QuestionsFragment> {
  final ScrollController _scrollController = ScrollController();
  final QuestionsController _controller = Get.put(QuestionsController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_controller.loadingQuestions &&
        _controller.hasMore) {
      _controller.getQuestions();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        builder: (controller) {
          if (controller.loadingQuestions && controller.questions.isEmpty) {
            return const QuestionsShimmer();
          }

          if (controller.errorModel != null && controller.questions.isEmpty) {
            return Center(
              child: AppErrorWidget(
                errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
                onRetry: () => controller.getQuestions(),
              ),
            );
          }

          if (controller.questions.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد أسئلة',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.all(20.w),
            itemCount: controller.questions.length,
            separatorBuilder: (context, index) => 10.ph,
            itemBuilder: (context, index) {
              if (index == controller.questions.length) {
                controller.hasMore
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Text(
                          'تم عرض كل الأسئلة',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
              }

              final question = controller.questions[index];
              return ExpansionTile(
                clipBehavior: Clip.antiAlias,
                expandedAlignment: Alignment.centerRight,
                collapsedIconColor: const Color(0xFF374957),
                childrenPadding: EdgeInsets.only(
                  left: 18.w,
                  right: 18.w,
                  bottom: 25.h,
                ),
                onExpansionChanged: (value) => controller.checkOpened(value),
                title: Text(
                  question['question'],
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
                    question['answer'],
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
