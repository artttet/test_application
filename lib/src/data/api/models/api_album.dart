class ApiAlbum {
  static const dataKey = 'ApiAlbum';
  static const dataPreviewKey = 'ApiPreviewAlbum';

  final int userId;
  final int id;
  final String title;

  ApiAlbum({
    required this.userId,
    required this.id,
    required this.title
  });

  ApiAlbum.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
    'userId': this.userId,
    'id': this.id,
    'title': this.title,
  };
}