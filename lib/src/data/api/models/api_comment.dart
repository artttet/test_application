class ApiComment {
  static const dataKey = 'ApiComment';
  
  final int postId;
  final int? id;
  final String name;
  final String email;
  final String body;

  ApiComment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body
  });

  ApiComment.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        id = json['id'],
        name = json['name'],
        email = json['email'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
    'postId': this.postId,
    'id': this.id,
    'name': this.name,
    'email': this.email,
    'body': this.body,
  };
}