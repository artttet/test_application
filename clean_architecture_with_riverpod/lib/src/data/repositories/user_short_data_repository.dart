import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/user_short.dart';
import 'package:test_application/src/domain/repositories/user_short_repository.dart';

class UserShortDataRepository extends UserShortRepository {
  final ApiUtil _apiUtil;
  UserShortDataRepository(this._apiUtil);

  @override
  Future<List<UserShort>?> getUserShortList() async {
    return await _apiUtil.getUserShortList();
  }
}