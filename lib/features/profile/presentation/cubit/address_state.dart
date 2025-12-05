part of 'address_cubit.dart';

abstract class AddressState {
  const AddressState();
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Address> addresses;

  const AddressLoaded({required this.addresses});
}

class AddressError extends AddressState {
  final String message;

  const AddressError({required this.message});
}