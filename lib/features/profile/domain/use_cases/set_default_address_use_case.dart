import '../repositories/address_repository.dart';

class SetDefaultAddressUseCase {
  final AddressRepository repository;

  SetDefaultAddressUseCase(this.repository);

  Future<void> call(String id, String userId) {
    return repository.setDefaultAddress(id, userId);
  }
}