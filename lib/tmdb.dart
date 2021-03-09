library tmdb;

import 'dart:async';
import 'dart:convert';

import 'package:tmdb/tmdb_image.dart';
import 'package:tmdb/tmdb_server_config.dart';
import 'package:tmdb/tmdb_types.dart';
import 'package:http/http.dart' as http;

/// A Calculator.
class Tmdb {
  static const BASE_URL = 'https://api.themoviedb.org/3/';
  static const ENDPOINT_MOVIES = 'movie';
  static const ENDPOINT_IMAGES = 'images';

  TmdbServerConfig? _serverConfig;

  Future<TmdbServerConfig> get serverConfig =>
      _serverConfig != null ? Future.value(_serverConfig) : getServerConfig();

  final String tmdbKey;
  final http.Client client;

  Tmdb(this.tmdbKey, {http.Client? httpClient})
      : client = httpClient ?? http.Client();

  Future<http.Response> get(String path) {
    return client.get(Uri.parse('$BASE_URL$path?api_key=$tmdbKey'));
  }

  Future<TmdbServerConfig> getServerConfig() async {
    var response = await get('configuration');
    final Map<String, dynamic> parsed =
        jsonDecode(response.body).cast<String, dynamic>();
    _serverConfig = TmdbServerConfig.fromJson(parsed);
    return _serverConfig!;
  }

  Future<TmdbImageResponse> getImages(int tmdbId, TmdbTypes type) async {
    var response = await get('$ENDPOINT_MOVIES/$tmdbId/$ENDPOINT_IMAGES');
    final Map<String, dynamic> parsed =
        jsonDecode(response.body).cast<String, dynamic>();
    return TmdbImageResponse.fromJson(parsed);
  }

  Future<String> getImageUrl(
    TmdbImage image,
    int targetWidth,
  ) async {
    var config = await this.serverConfig;
    var imageSize = await this.getClosestImageSize(image, targetWidth);
    return '${config.images!.baseUrl}$imageSize${image.filePath}';
  }

  Future<String> getClosestImageSize(TmdbImage image, int targetWidth) async {
    var config = await this.serverConfig;
    List<String>? sizes;
    if (image.type == TmdbImageType.Backdrops) {
      sizes = config.images!.backdropSizes;
    } else if (image.type == TmdbImageType.Poster) {
      sizes = config.images!.posterSizes;
    } else {
      throw 'unsupported image type';
    }

    var availableSizes = sizes!
        .where((s) => s.startsWith("w"))
        .map<int?>((s) => int.tryParse(s.substring(1)))
        .toList();
    availableSizes.sort();
    var targetSize =
        availableSizes.firstWhere((s) => s! > targetWidth, orElse: () => null);
    if (targetSize != null) {
      return 'w$targetSize';
    } else {
      return 'original';
    }
  }
}
