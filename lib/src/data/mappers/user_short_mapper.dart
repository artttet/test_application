import 'package:test_application/src/data/api/models/api_user_short.dart';
import 'package:test_application/src/domain/entities/user_short.dart';

class UserShortMapper {
  static UserShort fromApi(ApiUserShort apiUserShort) {
    return UserShort(
      id: apiUserShort.id,
      username: apiUserShort.username,
      name: apiUserShort.name
    );
  }

  static ApiUserShort fromEntity(UserShort userShort) {
    return ApiUserShort(
      id: userShort.id,
      username: userShort.username,
      name: userShort.name 
    );
  }
}