class Artist {
  final String artistId;
  final String name;
  final String genre;
  final Uri imageUrl;

  Artist({
    required this.artistId,
    required this.name,
    required this.genre,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Artist(name: $name, genre: $genre), imageUrl: $imageUrl';
  }
}
