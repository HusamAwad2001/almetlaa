import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/channel_model.dart';
import '../utils/api.dart';

class VideosController extends GetxController {
  @override
  void onInit() {
    getVideos();
    super.onInit();
  }

  List videos = [];
  bool loadingVideos = true;
  getVideos() {
    loadingVideos = true;
    update();
    API().get(
        url: '/video?limit=100',
        onResponse: (response) {
          loadingVideos = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              videos = response.data['data'];
            }
          }
          update();
        });
  }

  searchVideos(String search) {
    loadingVideos = true;
    update();
    API().get(
        url: '/video?limit=100&search=$search',
        onResponse: (response) {
          loadingVideos = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              videos = response.data['data'];
            }
          }
          update();
        });
  }

  // ----------------------------------------------------------------------
  String apiKey = 'AIzaSyDRl98VUYN7f6gQzIzRalAW-SK3KRVLfFE';
  bool loadingChannelVideos = true;

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  Channel? channel;
  Future fetchChannel() async {
    final String channelId = 'baitiexpo';
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': apiKey,
    };
    Dio()
        .get(
      'https://$_baseUrl/youtube/v3/channels',
      queryParameters: parameters,
    )
        .then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['items'][0];
        channel = Channel.fromMap(data);
        if (channel != null) {
          channel!.videos = await fetchVideosFromPlaylist(
            playlistId: channel!.uploadPlaylistId!,
          );
        }
      }
    }).catchError((error) {
      print('Error: $error');
    }).whenComplete(() {
      loadingChannelVideos = false;
      update();
    });
    // API().get(
    //   baseURL: _baseUrl,
    //   url: '/youtube/v3/channels',
    //   queryParameters: parameters,
    //   onResponse: (ApiResponse response) async {
    //     if (response.statusCode == 200) {
    //       Map<String, dynamic> data = response.data['items'][0];
    //       channel = Channel.fromMap(data);
    //       if (channel != null) {
    //         channel!.videos = await fetchVideosFromPlaylist(
    //           playlistId: channel!.uploadPlaylistId!,
    //         );
    //       }
    //     }
    //     loadingChannelVideos = false;
    //     // throw response.data['error']['message'];
    //   },
    // );
    update();
  }

  List<Video> channelVideos = [];
  Future fetchVideosFromPlaylist({
    required String playlistId,
  }) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': apiKey,
    };
    Dio()
        .get(
      'https://$_baseUrl/youtube/v3/playlistItems',
      queryParameters: parameters,
    )
        .then((response) {
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = response.data;
        _nextPageToken = data['nextPageToken'] ?? '';
        List<dynamic> videosJson = data['items'];
        for (var json in videosJson) {
          channelVideos.add(Video.fromMap(json['snippet']));
        }
      }
    }).catchError((error) {
      print('Error: $error');
    }).whenComplete(() {
      loadingChannelVideos = false;
      update();
    });
    // await API().get(
    //   baseURL: _baseUrl,
    //   url: '/youtube/v3/playlistItems',
    //   queryParameters: parameters,
    //   onResponse: (ApiResponse response) async {
    //     if (response.statusCode == 200) {
    //       Map<dynamic, dynamic> data = response.data;
    //       _nextPageToken = data['nextPageToken'] ?? '';
    //       List<dynamic> videosJson = data['items'];
    //       for (var json in videosJson) {
    //         videos.add(Video.fromMap(json['snippet']));
    //       }
    //     }
    //     print('Videos: ${videos.length}');
    //     print('Videos: $videos');
    //     // throw response.data['error']['message'];
    //   },
    // );
  }
}
