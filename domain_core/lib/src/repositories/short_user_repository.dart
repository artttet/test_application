import 'package:domain_core/src/entities/short_user.dart';

abstract class ShortUserRepository {
  Future<List<ShortUser>?> fetchShortUsersList();
}