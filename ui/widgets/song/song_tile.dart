import 'package:flutter/material.dart';
import 'package:homework/song-with-firebase/data/dtos/song_with_artist_dto.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songWithArtistDto,
    required this.isPlaying, 
    required this.onTap,
  });

  final SongWithArtistDto songWithArtistDto;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(songWithArtistDto.song.imageUrl.toString()),
          ),
          onTap: onTap,
          title: Text(songWithArtistDto.song.title),
          subtitle: Text(
            '${songWithArtistDto.song.duration.inMinutes} mins  '
            '${songWithArtistDto.artist.name} - ${songWithArtistDto.artist.genre}',
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
