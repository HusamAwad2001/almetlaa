import 'package:almetlaa/controller/events_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/widgets/shimmer/videos_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../dialogs/video_dialog.dart';

class EventsPage extends GetView<EventsController> {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("الفعاليات",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            30.ph,
            TextField(
              onSubmitted: (v){
                if(v.isEmpty){
                  controller.getEvents();
                }else{
                  controller.searchEvents(v);
                }
              },
              decoration: InputDecoration(
                hintText: 'البحث',
                prefixIcon: Container(
                  width: 22.w,
                  height: 22.h,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 22.w,
                    height: 22.h,
                    color: Constants.primaryColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.r),
                  borderSide: const BorderSide(
                      width: 1, color: Color(0xFFF0F0F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.r),
                  borderSide: const BorderSide(
                      width: 1, color: Color(0xFFF0F0F0)),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
              ),
            ),
            30.ph,
            GetBuilder<EventsController>(
              init: EventsController(),
              builder: (controller) {
                return controller.loadingEvents? const VideosShimmer() : controller.events.isEmpty? const Text("لا يوجد بيانات").paddingOnly(top: Get.height/3.5) : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.events.length,
                  separatorBuilder: (_, __) => 29.ph,
                  itemBuilder: (_, index) {
                    final item = controller.events[index];
                    return Container(
                      height: 207.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: SizedBox(
                        height: 207.h,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          child: Column(children: [
                            Expanded(child: Image.network(
                              item['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black12,
                            ),
                            Text(item['name']).paddingAll(10)
                          ],),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            20.ph,
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
