import '../repositories/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository repository;

  DeleteAddressUseCase(this.repository);

  Future<void> call(String id, String userId) {
    return repository.deleteAddress(id, userId);
  }
}