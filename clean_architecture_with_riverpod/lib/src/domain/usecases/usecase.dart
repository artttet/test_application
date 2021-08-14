abstract class UseCase<T, Params extends UseCaseParams> {
  T execute({Params? params});
}

abstract class UseCaseParams{}