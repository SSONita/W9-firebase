import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri basedUrl = Uri.https(
    "g4-food-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  // final Uri songsUri = Uri.https('YOUR FIREBASE URL', '/songs.json');
  final Uri songsUri = basedUrl.replace(path: '/songs.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      // return songJson.map((item) => SongDto.fromJson(item)).toList();
      List<Song> result = [];
      for (var interate in songJson.entries) {
        result.add(SongDto.fromJson(interate.key, interate.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
