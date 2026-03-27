import 'package:flutter/material.dart';
import 'package:homework/song-with-firebase/data/dtos/song_with_artist_dto.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<SongWithArtistDto>> asyncValue = mv.songsWithArtistValue;

    Widget content;
    switch (asyncValue.state) {
      
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red),));

      case AsyncValueState.success:
        List<SongWithArtistDto> songWithArtists = asyncValue.data!;
        content = ListView.builder(
          itemCount: songWithArtists.length,
          itemBuilder: (context, index) => SongTile(
            songWithArtistDto: songWithArtists[index],
            isPlaying: mv.isSongPlaying(songWithArtists[index].song),
            onTap: () {
              mv.start(songWithArtists[index].song);
            },
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
