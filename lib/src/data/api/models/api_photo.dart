class ApiPhoto {
  static const dataKey = 'ApiPhoto';
  static const firstDataKey = 'ApiFirstPhoto';

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  ApiPhoto({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  ApiPhoto.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];

  Map<String, dynamic> toJson() => {
    'albumId': this.albumId,
    'id': this.id,
    'title': this.title,
    'url': this.url,
    'thumbnailUrl': this.thumbnailUrl,
  };
}