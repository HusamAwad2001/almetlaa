import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/storage.dart';
import '../../routes/pages.dart';
import '../../routes/routes.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  Storage.getData();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale("ar"),
          title: 'بيتي',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Constants.primaryColor,
            // primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.almarai().fontFamily,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Constants.primaryColor,
            ),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.almarai().fontFamily,
              ),
            ),
          ),
          initialRoute: Routes.splashPage,
          getPages: Pages.getPages(),
        );
      },
    );
  }
}
