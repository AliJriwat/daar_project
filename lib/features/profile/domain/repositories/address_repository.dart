import '../entities/address.dart';

abstract class AddressRepository {
  Future<List<Address>> getAddresses(String userId);
  Future<void> addAddress(Address address);
  Future<void> updateAddress(Address address);
  Future<void> deleteAddress(String id, String userId);
  Future<void> setDefaultAddress(String id, String userId);
}