class Comment {
  final int postId;
  final int? id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  const Comment._empty()
      : postId = 0,
        id = 0,
        name = '',
        email = '',
        body = '';
}

class CommentEmpty extends Comment {
  const CommentEmpty() : super._empty();
}