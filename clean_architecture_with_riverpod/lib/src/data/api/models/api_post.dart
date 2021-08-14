class ApiPost {
  static const dataKey = 'ApiPost';
  static const dataPreviewKey = 'ApiPreviewPost';

  final int userId;
  final int id;
  final String title;
  final String body;

  ApiPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  ApiPost.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
    'userId': this.userId,
    'id': this.id,
    'title': this.title,
    'body': this.body,
  };
}