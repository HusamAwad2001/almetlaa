import '../widgets/app_error_widget.dart';
import '../../views/widgets/home_news_widget.dart';
import '../../controller/news_controller.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/shimmer/news_shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController controller = Get.put(NewsController());
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !controller.loadingNews &&
          controller.hasMore) {
        controller.getNews();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الاخبار",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<NewsController>(
        builder: (_) {
          return controller.loadingNews && controller.news.isEmpty
              ? const NewsShimmer().paddingAll(20)
              : controller.news.isEmpty && controller.errorModel != null
                  ? Center(
                      child: AppErrorWidget(
                        errorMessage:
                            controller.errorModel?.message ?? 'حدث خطأ ما',
                        onRetry: () => controller.getNews(),
                      ),
                    )
                  : controller.news.isEmpty && controller.errorModel == null
                      ? const Center(
                          child: Text(
                            "لا يوجد اخبار",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(25),
                                mainAxisSpacing: 25.h,
                                crossAxisSpacing: 25.w,
                                shrinkWrap: true,
                                itemCount: controller.news.length,
                                crossAxisCount: 2,
                                itemBuilder: (_, index) {
                                  final item = controller.news[index];
                                  return HomeNewsWidget(item: item);
                                },
                              ),
                              if (controller.hasMore &&
                                  controller.news.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        );
        },
      ),
    );
  }
}
