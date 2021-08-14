import 'package:test_application/src/domain/entities/user_short.dart';

abstract class UserShortRepository {
  Future<List<UserShort>?> getUserShortList();
}