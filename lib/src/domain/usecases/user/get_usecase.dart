import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/domain/repositories/user_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetUserUseCase extends UseCase<Future<User?>, GetUserUseCaseParams> {
  final UserRepository _userRepository;
  GetUserUseCase(this._userRepository);

  @override
  Future<User?> execute({GetUserUseCaseParams? params}) async {
    if (params != null) {
      return await _userRepository.getUser(id: params.id);
    } else return null;
  }
}

class GetUserUseCaseParams extends UseCaseParams{
  final int id;
  GetUserUseCaseParams({required this.id});
}