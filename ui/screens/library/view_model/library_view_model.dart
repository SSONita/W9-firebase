import 'package:flutter/material.dart';
import 'package:homework/song-with-firebase/data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import '../../../../data/dtos/song_with_artist_dto.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtistDto>> songsWithArtistValue =
      AsyncValue.loading();
  //AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  // void _init() async {
  //   fetchSong();
  // }
  void _init() async {
    fetchSongWithArtist();
  }

  // void fetchSong() async {
  //   // 1- Loading state
  //   songsValue = AsyncValue.loading();
  //   notifyListeners();

  //   try {
  //     // 2- Fetch is successfull
  //     List<Song> songs = await songRepository.fetchSongs();
  //     songsValue = AsyncValue.success(songs);
  //   } catch (e) {
  //     // 3- Fetch is unsucessfull
  //     songsValue = AsyncValue.error(e);
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchSongWithArtist() async {
    songsWithArtistValue = AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await songRepository.fetchSongs();
      final List<SongWithArtistDto> result = [];

      for (var s in songs) {
        final artists = await artistRepository.fetchArtistById(s.artistId);
        if (artists != null) {
          result.add(
            SongWithArtistDto(
              song: s,
              artist: artists
            ),
          );
        }
      }
      songsWithArtistValue = AsyncValue.success(result);
    } catch (e) {
      songsWithArtistValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
