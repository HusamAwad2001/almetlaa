import 'package:baiti/values/constants.dart';
import 'package:baiti/views/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDialog {
  dialog() {
    Get.bottomSheet(
      Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.ph,
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              10.ph,
              const Text(
                "تواصل معنا",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildContactTile(
                imageUrl: "assets/icons/whats_app.jpeg",
                label: "55512322",
                url: 'http://wa.me/96555512322',
              ),
              _buildContactTile(
                imageUrl: "assets/icons/x.png",
                label: "baitiexpo",
                url: 'https://x.com/baitiexpo',
              ),
              _buildContactTile(
                imageUrl: "assets/icons/telegram.png",
                label: "baitiexpo",
                url: 'https://t.me/baitiexpo',
              ),
              _buildContactTile(
                imageUrl: "assets/icons/instagram.png",
                label: "baitiexpo",
                url: 'https://www.instagram.com/baitiexpo',
              ),
              _buildContactTile(
                imageUrl: "assets/images/snapchat.png",
                label: "snapchat",
                url: 'https://snapchat.com/t/uFQJl3VC',
              ),
              _buildContactTile(
                imageUrl: "assets/icons/tiktok.png",
                label: "baitiexpo",
                url: 'https://www.tiktok.com/@baitiexpo',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildContactTile({
    required String imageUrl,
    required String label,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              Snack().show(message: 'لا يمكن فتح الرابط', type: false);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
