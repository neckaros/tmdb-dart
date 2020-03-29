class TmdbServerConfig {
  final List<String> changesKeys;
  final TmdbImagesConfig images;

  TmdbServerConfig({this.changesKeys, this.images});

  factory TmdbServerConfig.fromJson(Map<String, dynamic> json) {
    return TmdbServerConfig(
      changesKeys: (json['change_keys'] as List<dynamic>).cast<String>(),
      images: TmdbImagesConfig.fromJson(json['images'] as Map<String, dynamic>),
    );
  }
}

class TmdbImagesConfig {
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  TmdbImagesConfig(
      {this.baseUrl,
      this.secureBaseUrl,
      this.backdropSizes,
      this.logoSizes,
      this.posterSizes,
      this.profileSizes,
      this.stillSizes});

  factory TmdbImagesConfig.fromJson(Map<String, dynamic> json) {
    return TmdbImagesConfig(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: (json['backdrop_sizes'] as List<dynamic>).cast<String>(),
      logoSizes: (json['logo_sizes'] as List<dynamic>).cast<String>(),
      posterSizes: (json['logo_sizes'] as List<dynamic>).cast<String>(),
      profileSizes: (json['profile_sizes'] as List<dynamic>).cast<String>(),
      stillSizes: (json['still_sizes'] as List<dynamic>).cast<String>(),
    );
  }
}
