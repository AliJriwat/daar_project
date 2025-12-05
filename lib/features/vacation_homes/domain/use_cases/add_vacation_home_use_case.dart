import 'package:daar_project/features/vacation_homes/domain/entities/vacation_home.dart';
import 'package:daar_project/features/vacation_homes/domain/repositories/vacation_home_repository.dart';

class AddAddressUseCase {
  final VacationHomeRepository repository;

  AddAddressUseCase(this.repository);

  Future<void> call(VacationHome home) {
    return repository.addHome(home);
  }
}