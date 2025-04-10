import '../../views/pages/ar_page.dart';
import '../../views/pages/blocks_page.dart';
import '../../views/pages/regions_page.dart';
import '../../views/pages/categories_page.dart';
import '../../views/pages/companies_page.dart';
import '../../views/pages/home_page.dart';
import '../../views/pages/internet_page.dart';
import '../../views/pages/login_page.dart';
import '../../views/pages/news_details_page.dart';
import '../../views/pages/news_page.dart';
import '../../views/pages/register_page.dart';
import '../../views/pages/splash_page.dart';
import '../../views/pages/videos_page.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../views/pages/allowance_details_page.dart';
import '../views/pages/allowance_page.dart';
import '../views/pages/company_profile_page.dart';
import '../views/pages/construction_bills_page.dart';
import '../views/pages/construction_material_prices_page.dart';
import '../views/pages/contract_bills_page.dart';
import '../views/pages/create_exchange_page.dart';
import '../views/pages/create_surpluses_page.dart';
import '../views/pages/events_page.dart';
import '../views/pages/notifications_page.dart';
import '../views/pages/post_page.dart';
import '../views/pages/surpluses_details_page.dart';
import '../views/pages/surpluses_page.dart';
import '../views/pages/video_details_page.dart';

class Pages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: Routes.splashPage,
        page: () => const SplashPage(),
      ),
      GetPage(
        name: Routes.eventsPage,
        page: () => const EventsPage(),
      ),
      GetPage(
        name: Routes.internetPage,
        page: () => const InternetPage(),
      ),
      GetPage(
        name: Routes.homePage,
        page: () => const HomePage(),
      ),
      GetPage(
        name: Routes.newsPage,
        page: () => const NewsPage(),
      ),
      GetPage(
        name: Routes.newsDetailsPage,
        page: () => const NewsDetailsPage(),
      ),
      GetPage(
        name: Routes.videosPage,
        page: () => const VideosPage(),
      ),
      GetPage(
        name: Routes.videoDetailsPage,
        page: () => const VideoDetailsPage(),
      ),
      GetPage(
        name: Routes.loginPage,
        page: () => const LoginPage(),
      ),
      GetPage(
        name: Routes.registerPage,
        page: () => const RegisterPage(),
      ),
      GetPage(
        name: Routes.categoriesPage,
        page: () => const CategoriesPage(),
      ),
      GetPage(
        name: Routes.companiesPage,
        page: () => const CompaniesPage(),
      ),
      GetPage(
        name: Routes.companyProfilePage,
        page: () => const CompanyProfilePage(),
      ),
      GetPage(
        name: Routes.aRPage,
        page: () => const ARPage(),
      ),
      // GetPage(
      //   name: Routes.panoramaPage,
      //   page: () => const PanoramaPage(),
      // ),
      GetPage(
        name: Routes.constructionMaterialPricesPage,
        page: () => const ConstructionMaterialPricesPage(),
      ),
      GetPage(
        name: Routes.allowancePage,
        page: () => const AllowancePage(),
      ),
      GetPage(
        name: Routes.allowanceDetailsPage,
        page: () => const AllowanceDetailsPage(),
      ),
      GetPage(
        name: Routes.surplusesPage,
        page: () => const SurplusesPage(),
      ),
      GetPage(
        name: Routes.surplusesDetailsPage,
        page: () => const SurplusesDetailsPage(),
      ),
      GetPage(
        name: Routes.constructionBillsPage,
        page: () => const ConstructionBillsPage(),
      ),
      GetPage(
        name: Routes.contractBillsPage,
        page: () => const ContractBillsPage(),
      ),
      GetPage(
        name: Routes.createSurplusesPage,
        page: () => const CreateSurplusesPage(),
      ),
      GetPage(
        name: Routes.regionsPage,
        page: () => const RegionsPage(),
      ),
      GetPage(
        name: Routes.blocksPage,
        page: () => const BlocksPage(),
      ),
      GetPage(
        name: Routes.postPage,
        page: () => const PostPage(),
      ),
      GetPage(
        name: Routes.notificationsPage,
        page: () => const NotificationsPage(),
      ),
      GetPage(
        name: Routes.createExchangePage,
        page: () => const CreateExchangePage(),
      ),
    ];
  }
}
