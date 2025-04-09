import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/channel_model.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  String apiKey = 'AIzaSyDRl98VUYN7f6gQzIzRalAW-SK3KRVLfFE';
  final String channelId = 'UCxQPt13KP_y4LKy7xuriDnA';

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel() async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': apiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId ?? '',
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': apiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      for (var json in videosJson) {
        videos.add(
          Video.fromMap(json['snippet']),
        );
      }
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
