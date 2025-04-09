import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_embed/controller/video_controller.dart';
import 'package:youtube_player_embed/youtube_player_embed.dart';
import 'package:flutter/material.dart';
import '../../models/channel_model.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String id;
  final List<Video> videos;

  const VideoPlayerScreen({required this.id, required this.videos, super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoController? videoController;
  late Video _selectedVideo;
  late List<Video> videos;
  late UniqueKey _playerKey;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedVideo = widget.videos.firstWhere(
      (video) => video.id == widget.id,
    );
    _playerKey = UniqueKey();
    removeSelectedVideo();
  }

  //create a function to remove the selected video from videos = widget.videos.where((video) => video.id != _selectedVideo.id).toList();
  void removeSelectedVideo() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        videos = widget.videos
            .where((video) => video.id != _selectedVideo.id)
            .toList();
      });
    });
  }

  void _playVideo(Video video) {
    setState(() {
      _selectedVideo = video;
      _playerKey = UniqueKey();
      removeSelectedVideo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayerEmbed(
                    key: _playerKey,
                    callBackVideoController: (controller) {
                      videoController = controller;
                    },
                    customVideoTitle: '',
                    videoId: _selectedVideo.id!,
                    autoPlay: true,
                    hidenVideoControls: false,
                    aspectRatio: 16 / 9,
                    onVideoEnd: () {
                      print("video ended");
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedVideo.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ).paddingSymmetric(horizontal: 16.w),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return ListTile(
                          leading:
                              Image.network(video.thumbnailUrl!, width: 100),
                          title: Text(video.title!, maxLines: 2),
                          subtitle: Text(video.channelTitle!),
                          onTap: () => _playVideo(video),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
