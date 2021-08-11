import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/domain/repositories/user_repository.dart';

class UserDataRepository extends UserRepository{
  final ApiUtil _apiUtil;
  UserDataRepository(this._apiUtil);

  @override
  Future<User?> getUser({required int id}) async {
    return await _apiUtil.getUser(id: id);
  }
}