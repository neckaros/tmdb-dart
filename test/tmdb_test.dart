import 'package:flutter_test/flutter_test.dart';

import 'package:tmdb/tmdb.dart';
import 'package:tmdb/tmdb_types.dart';

void main() {
  test('adds one to input values', () async {
    final tmdb = Tmdb('4a01db3a73eed5cf17e9c7c27fd9d008');
    var photos = await tmdb.getImages(419704, TmdbTypes.Movie);
    var url = await tmdb.getImageUrl(photos.posters[0], 1280);
    expect(photos, 3);
  });
}
