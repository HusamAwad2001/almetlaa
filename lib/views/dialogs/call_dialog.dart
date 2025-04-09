import 'package:almetlaa/views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDialog {
  dialog() {
    Get.bottomSheet(
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () => launchUrl(
                  Uri.parse("https://api.whatsapp.com/send?phone=96550000488")),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/124/124034.png?w=360",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("50000488"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(
                  Uri.parse('https://www.instagram.com/almutlacity/')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/87/87390.png?w=360",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("almutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://t.me/almutlacity')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/2111/2111646.png?w=360",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("almutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () =>
                  launchUrl(Uri.parse('https://www.twitter.com/al_mutlacity/')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/124/124021.png?w=360",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("al_mutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () =>
                  launchUrl(Uri.parse('https://www.youtube.com/@almutlaacity')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/1384/1384060.png?w=360",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("almutlaacity"))
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ).paddingOnly(right: 30),
      ),
      isScrollControlled: true,
    );
  }
}
