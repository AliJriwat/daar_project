import 'package:daar_project/features/auth/data/repositories/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}