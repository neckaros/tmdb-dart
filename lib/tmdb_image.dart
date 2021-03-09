enum TmdbImageType { Poster, Logo, Backdrops }

class TmdbImage {
  final double? aspectRatio;
  final String? filePath;
  final int? height;
  final int? width;
  final String? iso6391;
  final double? voteAverage;
  final int? voteCount;
  final TmdbImageType? type;

  TmdbImage(
      {this.type,
      this.aspectRatio,
      this.filePath,
      this.height,
      this.width,
      this.iso6391,
      this.voteAverage,
      this.voteCount});

  factory TmdbImage.fromJson(
    Map<String, dynamic> json,
    TmdbImageType type,
  ) {
    return TmdbImage(
      type: type,
      aspectRatio: json['aspect_ratio'] as double?,
      filePath: json['file_path'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      iso6391: json['iso_639_1'] as String?,
      voteAverage: json['vote_average'] as double?,
      voteCount: json['vote_count'] as int?,
    );
  }
}

class TmdbImageResponse {
  final int? id;
  final List<TmdbImage>? backdrops;
  final List<TmdbImage>? posters;

  TmdbImageResponse({this.id, this.backdrops, this.posters});

  factory TmdbImageResponse.fromJson(Map<String, dynamic> json) {
    var backdrops = (json['backdrops'] as List<dynamic>).cast<Map>();
    var posters = (json['posters'] as List<dynamic>).cast<Map>();
    return TmdbImageResponse(
      id: json['aspect_ratio'] as int?,
      backdrops: backdrops
          .map((m) => TmdbImage.fromJson(
              m.cast<String, dynamic>(), TmdbImageType.Backdrops))
          .toList(),
      posters: posters
          .map((m) => TmdbImage.fromJson(
              m.cast<String, dynamic>(), TmdbImageType.Poster))
          .toList(),
    );
  }
}
