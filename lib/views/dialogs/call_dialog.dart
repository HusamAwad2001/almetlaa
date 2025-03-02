import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDialog {
  dialog() {
    Get.bottomSheet(
      Material(
        color: Colors.white,
        borderRadius:
            const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () => launchUrl(Uri.parse("https://api.whatsapp.com/send?phone=96550000488")),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/124/124034.png?w=360",
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("50000488"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.snapchat.com/add/almutlacity')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://assets.materialup.com/uploads/0a167b5f-425d-4b90-adeb-57016ccbcbcd/0x0ss-85.jpg",
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("almutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.instagram.com/almutlacity/')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://e7.pngegg.com/pngimages/866/916/png-clipart-logo-computer-icons-instagram-instagram-application-logo-text-trademark.png",
                      height: 30,
                    ),
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2021/12/27/10/50/telegram-6896827_960_720.png",
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("almutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.twitter.com/al_mutlacity/')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://i.pinimg.com/originals/9b/6e/cc/9b6ecceab5738b648bd9066f7e8de905.png",
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 100, child: Text("al_mutlacity"))
                ],
              ),
            ),
            const Divider().marginOnly(left: 50, right: 50),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.youtube.com/@almutlaacity')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://icons-for-free.com/iconfiles/png/512/app+global+ios+media+social+youtube+icon-1320193331371761915.png",
                      height: 30,
                    ),
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
