import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import '../../controller/surpluses_details_controller.dart';
import '../widgets/shimmer/offers_shimmer.dart';
import '../widgets/text_field_widget.dart';

class SurplusesDetailsPage extends StatelessWidget {
  const SurplusesDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurplusesDetailsController>(
      init: SurplusesDetailsController(),
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 300.h,
                backgroundColor: Constants.primaryColor,
                elevation: 0,
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.back(),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isCollapsed = constraints.biggest.height <=
                        kToolbarHeight + MediaQuery.of(context).padding.top;
                    return FlexibleSpaceBar(
                      background: Hero(
                        tag: controller.arguments['_id'],
                        child: AppImage(
                          imageUrl: controller.arguments['image'],
                          width: Get.width,
                          height: 300.h,
                          fit: BoxFit.cover,
                          indicatorColor: Colors.white,
                        ),
                      ),
                      centerTitle: true,
                      title: isCollapsed
                          ? Builder(
                              builder: (_) {
                                final duration = controller.remainingTime;
                                if (duration.inSeconds <= 0) {
                                  return Text(
                                    'انتهت المزايدة',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF8E8E8E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                final hours = duration.inHours;
                                final minutes = duration.inMinutes % 60;
                                final seconds = duration.inSeconds % 60;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'تنتهي المناقصة خلال ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      duration.inDays == 0
                                          ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                                          : '${duration.inDays + 1} أيام',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : null,
                      collapseMode: CollapseMode.parallax,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    25.ph,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: controller.listProposals.isEmpty
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        children: [
                          Builder(
                            builder: (_) {
                              final duration = controller.remainingTime;
                              if (duration.inSeconds <= 0) {
                                return Text(
                                  'انتهت المزايدة',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF8E8E8E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              final hours = duration.inHours;
                              final minutes = duration.inMinutes % 60;
                              final seconds = duration.inSeconds % 60;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'تنتهي المناقصة خلال',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  5.ph,
                                  Text(
                                    duration.inDays == 0
                                        ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                                        : '${duration.inDays + 1} أيام',
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          if (controller.listProposals.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'أعلى سعر',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                5.ph,
                                Text(
                                  '${controller.listProposals.last['price']} دينار',
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 16.w),
                    20.ph,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.arguments['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.arguments['description'],
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 16.w),
                    20.ph,
                    Text(
                      'العروض',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ).paddingSymmetric(horizontal: 16.w),
                    10.ph,
                    const Divider(height: 0),
                  ],
                ),
              ),
              controller.loadingProposals
                  ? SliverToBoxAdapter(child: OffersShimmer())
                  : controller.listProposals.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'لا يوجد عروض',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              controller.listProposals.sort(
                                (a, b) => b['price'].compareTo(a['price']),
                              );
                              final item = controller.listProposals[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.grey[300]!),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 4,
                                      color: const Color(0xFF737373)
                                          .withOpacity(0.25),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.h),
                                  leading: item['user']['image'] == null
                                      ? CircleAvatar(
                                          radius: 33.r,
                                          backgroundColor:
                                              const Color(0xFFbdc3c7),
                                          child: const Icon(
                                            Icons.perm_identity,
                                            color: Colors.white,
                                          ),
                                        )
                                      : AppImage(
                                          imageUrl: item['user']['image'],
                                          width: 66.w,
                                          height: 66.h,
                                          borderRadius:
                                              BorderRadius.circular(200.r),
                                          errorWidget: (_, __, ___) {
                                            return CircleAvatar(
                                              radius: 33.r,
                                              backgroundImage: const AssetImage(
                                                'assets/images/baiti_logo2.png',
                                              ),
                                            );
                                          },
                                        ),
                                  title: Text(
                                    item['user']['phoneNumber'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Constants.primaryColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      '${item['price']} دينار',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ).paddingSymmetric(horizontal: 15.w),
                              ).paddingOnly(top: index == 0 ? 15.h : 0);
                            },
                            childCount: controller.listProposals.length,
                          ),
                        ),
              SliverToBoxAdapter(child: 50.ph),
            ],
          ),
          floatingActionButton: !controller.loadingProposals &&
                  controller.remainingTime.inSeconds > 0
              ? FloatingActionButton(
                  onPressed: buildDefaultDialog,
                  backgroundColor: context.theme.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  tooltip: 'مزايدة',
                  child: Image.asset(
                    'assets/images/bid1.png',
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
        );
      },
    );
  }

  Future<dynamic> buildDefaultDialog() {
    final controller = Get.find<SurplusesDetailsController>();
    return Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 16.w,
      ),
      title: 'للمزايدة',
      content: TextFieldWidget(
        label: 'أضف سعر أعلى',
        textInputType: TextInputType.number,
        radius: 5.r,
        labelColor: const Color(0xFFAFAFAF),
        controller: controller.priceController,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => controller.validate(),
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(Constants.primaryColor),
          ),
          child: const Text(
            "إضافة",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).paddingOnly(top: 12, bottom: 12),
        ),
      ],
    );
  }
}
