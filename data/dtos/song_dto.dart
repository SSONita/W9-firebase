import '../../model/songs/song.dart';

class SongDto {
  static const String titleKey = 'title';
  static const String artistKey = 'artistId';
  static const String durationKey = 'duration';
  static const String imageURL = 'imageUrl'; // in ms

  static Song fromJson(String id, Map<String, dynamic> json) {
    assert(json[titleKey] is String);
    assert(json[artistKey] is String);
    assert(json[durationKey] is int);
    assert(json[imageURL] is String);

    return Song(
      id: id,
      title: json[titleKey],
      artistId: json[artistKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageUrl: Uri.parse(json[imageURL]),
    );
  }


  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      durationKey: song.duration.inMilliseconds,
      artistKey: song.artistId,
      imageURL: song.imageUrl
    };
  }
}
