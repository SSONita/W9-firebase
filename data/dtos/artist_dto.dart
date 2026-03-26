import '../../model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageURL = 'imageUrl';

  static Artist fromJson(String artistId, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageURL] is String);

    return Artist(
      artistId: artistId,
      name: json[nameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageURL]),
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      genreKey: artist.genre,
      imageURL: artist.imageUrl.toString()
    };
  }
}
