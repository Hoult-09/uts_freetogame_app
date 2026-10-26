class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String genre;
  final String platform;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.genre,
    required this.platform,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: json['short_description'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
    );
  }
}