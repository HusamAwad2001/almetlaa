import 'package:get/get.dart';
import '../utils/api.dart';
import '../views/widgets/snack.dart';

class HomeController extends GetxController {
  int selectedPage = 0;
  @override
  void onInit() {
    getSlider();
    getNews();
    super.onInit();
  }

  List sliderImages = [];
  int currentPos = 0;
  bool loadingSlider = true;
  int sliderLimit = 10;
  Future<void> getSlider() async {
    API().get(
      url: '/images?limit=$sliderLimit',
      onResponse: (response) {
        loadingSlider = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            sliderImages = response.data['data'];
          }
        }
        update();
      },
      onError: (error) {
        loadingSlider = false;
        update();
      },
    );
  }

  List news = [];
  bool loadingNews = true;
  int newsLimit = 20;
  Future<void> getNews() async {
    API().get(
      url: '/news?limit=$newsLimit',
      onResponse: (response) {
        loadingNews = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            news = response.data['data'];
          }
        }
        update();
      },
      onError: (error) {
        loadingNews = false;
        update();
      },
    );
  }

  void checkWhenLoading(Function()? onClick) {
    if (loadingNews || loadingSlider) {
      Snack().show(
        type: true,
        message: 'الرجاء الانتظار قليلا حتى يتم تحميل البيانات',
      );
      return;
    }
    if (onClick != null) {
      onClick();
    }
  }
}
