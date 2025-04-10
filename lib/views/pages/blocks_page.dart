import '../../controller/blocks_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlocksPage extends StatelessWidget {
  const BlocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "التوزيعات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder(
          init: BlocksController(),
          builder: (controller) {
            return controller.loadingBlocks
                ? const Center(child: CircularProgressIndicator())
                : controller.listBlocks.isEmpty
                    ? const Center(child: Text('لا يوجد توزيعات'))
                    : ListView.separated(
                        padding: EdgeInsets.only(
                          top: 40.h,
                          right: 22.w,
                          left: 22.w,
                        ),
                        itemCount: controller.listBlocks.length,
                        separatorBuilder: (context, index) => 15.ph,
                        itemBuilder: (context, index) {
                          final item = controller.listBlocks[index];
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: const Color(0xFFE9E9E9),
                              ),
                            ),
                            child: Column(
                              children: [
                                AppImage(
                                  imageUrl: item['image'],
                                  width: Get.width,
                                  height: 254.h,
                                ),
                                20.ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['name'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller
                                            .saveNetworkImage(item['image']);
                                      },
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.download),
                                      color: Constants.primaryColor,
                                    )
                                  ],
                                ).paddingSymmetric(horizontal: 15.w),
                                20.ph,
                              ],
                            ),
                          );
                        },
                      );
          }),
    );
  }
}
