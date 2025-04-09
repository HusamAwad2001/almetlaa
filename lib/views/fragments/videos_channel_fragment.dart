import 'package:almetlaa/views/pages/video_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../values/constants.dart';
import '../../../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';

import '../../models/channel_model.dart';
import '../../services/channel_service.dart';

class VideosChannelFragment extends StatefulWidget {
  const VideosChannelFragment({super.key});

  @override
  _VideosChannelFragmentState createState() => _VideosChannelFragmentState();
}

class _VideosChannelFragmentState extends State<VideosChannelFragment> {
  Channel? _channel;
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    await APIService.instance.fetchChannel().then((channel) {
      setState(() {
        _channel = channel;
      });
    }).catchError((_) {
      setState(() {
        _isError = true;
      });
    });
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId!);
    List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
    setState(() {
      _channel?.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الفيديوهات",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: _isError
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '⚠️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: Constants.primaryColor,
                    ),
                  ),
                  Center(
                    child: Text(
                      'حدث خطأ ما أثناء تحميل البيانات \nيرجى المحاولة مرة أخرى',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  20.ph,
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isError = false;
                      });
                      _initChannel();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Constants.primaryColor,
                      size: 24,
                    ),
                    label: const Text(
                      "حاول مرة أخرى",
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'amarai',
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Constants.primaryColor.withValues(alpha: 0.2),
                      side: const BorderSide(
                        color: Constants.primaryColor,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      textStyle: TextStyle(fontSize: 14.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : _channel != null
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!_isLoading &&
                        _channel!.videos!.length !=
                            int.parse(_channel!.videoCount!) &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      _loadMoreVideos();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: _channel!.videos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Video video = _channel!.videos![index];
                      return _VideoWidget(
                        video: video,
                        videos: _channel?.videos ?? [],
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
    );
  }
}

class _VideoWidget extends StatelessWidget {
  final Video video;
  final List<Video> videos;

  const _VideoWidget({required this.video, required this.videos});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (video.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoPlayerScreen(
                id: video.id!,
                videos: videos,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                AppImage(
                  imageUrl: video.thumbnailUrl!,
                  width: 150.0,
                ),
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
