import 'package:homework/song-with-firebase/model/artists/artist.dart';
import 'package:homework/song-with-firebase/model/songs/song.dart';

class SongWithArtistDto {
  final Song song;
  final Artist artist;

  SongWithArtistDto({required this.song, required this.artist});
}
