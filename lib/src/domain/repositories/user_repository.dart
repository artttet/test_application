import 'package:test_application/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser({required int id});
}