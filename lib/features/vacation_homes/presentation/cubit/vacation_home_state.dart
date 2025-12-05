part of 'vacation_home_cubit.dart';

abstract class VacationHomeState {
  const VacationHomeState();
}

class VacationHomeInitial extends VacationHomeState {}

class VacationHomeLoading extends VacationHomeState {}

class VacationHomeAdded extends VacationHomeState {
  final String homeId;

  const VacationHomeAdded(this.homeId);
}

class VacationHomeError extends VacationHomeState {
  final String message;

  const VacationHomeError(this.message);
}
