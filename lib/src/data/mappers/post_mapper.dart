import 'package:test_application/src/data/api/models/api_post.dart';
import 'package:test_application/src/domain/entities/post.dart';

class PostMapper {
  static Post fromApi(ApiPost apiPost) => Post(
    userId: apiPost.userId,
    id: apiPost.id, 
    title: apiPost.title,
    body: apiPost.body
  );
}