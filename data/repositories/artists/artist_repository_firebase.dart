import '../../../model/artists/artist.dart';
import 'package:http/http.dart' as http;
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';
import 'dart:convert';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri basedUri = Uri.https(
    "g4-food-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  final Uri artistUri = basedUri.replace(path: '/artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = jsonDecode(response.body);
      List<Artist> result = [];

      for (var iterate in artistJson.entries) {
        result.add(ArtistDto.fromJson(iterate.key, iterate.value));
      }
      return result;
    }else{
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String artistId) async{}
}
