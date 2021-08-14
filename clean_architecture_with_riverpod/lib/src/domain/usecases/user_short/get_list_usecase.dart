import 'package:test_application/src/domain/entities/user_short.dart';
import 'package:test_application/src/domain/repositories/user_short_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetUserShorListUseCase extends UseCase<Future<List<UserShort>?>, UseCaseParams> {
  final UserShortRepository _userShortRepository;
  GetUserShorListUseCase(this._userShortRepository);

  @override
  Future<List<UserShort>?> execute({UseCaseParams? params}) async {
    return await _userShortRepository.getUserShortList();
  }
}