import '../../controller/blocks_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/app_error_widget.dart';

class BlocksPage extends StatelessWidget {
  const BlocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return GetBuilder<BlocksController>(
      init: BlocksController(),
      builder: (controller) {
        scrollController.addListener(() {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100) {
            controller.getBlocks();
          }
        });

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.primaryColor,
            title: const Text(
              "التوزيعات",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            elevation: 0,
          ),
          body: Builder(
            builder: (_) {
              if (controller.loadingBlocks && controller.listBlocks.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorModel != null &&
                  controller.listBlocks.isEmpty) {
                return Center(
                  child: AppErrorWidget(
                    errorMessage:
                        controller.errorModel?.message ?? "حدث خطأ ما",
                    onRetry: () => controller.getBlocks(),
                  ),
                );
              }

              if (controller.listBlocks.isEmpty) {
                return Center(
                  child: Text(
                    'لا يوجد توزيعات',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => controller.getBlocks(isRefresh: true),
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    top: 40.h,
                    right: 22.w,
                    left: 22.w,
                    bottom: 80.h,
                  ),
                  itemCount: controller.listBlocks.length +
                      (controller.hasMore ? 1 : 0),
                  separatorBuilder: (context, index) => 15.ph,
                  itemBuilder: (context, index) {
                    if (index == controller.listBlocks.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final item = controller.listBlocks[index];
                    return BlockItem(item: item);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BlockItem extends GetView<BlocksController> {
  final Map<String, dynamic> item;
  const BlockItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE9E9E9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => FullImagePage(imageUrl: item['image']));
            },
            child: Hero(
              tag: item['image'],
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: AppImage(
                  imageUrl: item['image'],
                  width: double.infinity,
                  height: 220.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item['name'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.saveNetworkImage(item['image']),
                  icon: const Icon(Icons.download_rounded),
                  color: Constants.primaryColor,
                  tooltip: 'تحميل الصورة',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullImagePage extends StatefulWidget {
  final String imageUrl;
  const FullImagePage({super.key, required this.imageUrl});

  @override
  State<FullImagePage> createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage>
    with SingleTickerProviderStateMixin {
  Offset offset = Offset.zero;
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(opacity),
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              offset += Offset(0, details.delta.dy);
              opacity = (1 - (offset.dy.abs() / 300)).clamp(0.0, 1.0);
            });
          },
          onVerticalDragEnd: (details) {
            if (offset.dy > 150) {
              Get.back();
            } else {
              setState(() {
                offset = Offset.zero;
                opacity = 1.0;
              });
            }
          },
          child: Stack(
            children: [
              Center(
                child: Transform.translate(
                  offset: offset,
                  child: Hero(
                    tag: widget.imageUrl,
                    child: InteractiveViewer(
                      child: AppImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Opacity(
                  opacity: opacity,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
