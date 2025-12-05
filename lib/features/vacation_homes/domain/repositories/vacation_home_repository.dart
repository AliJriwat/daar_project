import 'package:daar_project/features/vacation_homes/domain/entities/vacation_home.dart';

abstract class VacationHomeRepository {
  Future<void> addHome(VacationHome home);
}