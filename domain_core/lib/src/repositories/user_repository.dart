import 'package:domain_core/src/entities/user.dart';

abstract class UserRepository {
  Future<User?> fetchUser({required int id});
}