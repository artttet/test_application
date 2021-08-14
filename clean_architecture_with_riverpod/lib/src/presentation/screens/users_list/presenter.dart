import 'package:test_application/src/domain/entities/user_short.dart';
import 'package:test_application/src/domain/repositories/user_short_repository.dart';
import 'package:test_application/src/domain/usecases/user_short/get_list_usecase.dart';

class UsersListPresenter {
  final UserShortRepository _userShortRepository; // ignore: unused_field
  final GetUserShorListUseCase _getUserShortListUseCase;
  UsersListPresenter(this._userShortRepository)
      : _getUserShortListUseCase = GetUserShorListUseCase(_userShortRepository);

  Future<List<UserShort>?> getUserShortList() async {
    return await _getUserShortListUseCase.execute();
  }
}