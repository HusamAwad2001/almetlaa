import 'package:almetlaa/views/widgets/app_image.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class VideoDialog {
  dialog(Map item) {
    Get.bottomSheet(
      SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.3)),
                margin: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () async {
                    await FlutterShare.share(
                      title: 'المطلاع',
                      text: item['title'],
                      linkUrl: item['video'],
                    );
                  },
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.3)),
                margin: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                ),
              )
            ],
          ),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                BetterPlayer.network(
                  item['video'],
                  betterPlayerConfiguration: BetterPlayerConfiguration(
                    placeholder: AppImage(imageUrl: item['image']),
                    autoPlay: true,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white54,
                ),
                Text(
                  item['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ).paddingAll(10),
              ],
            ),
          ),
        ],
      )),
      isScrollControlled: true,
    );
  }
}
