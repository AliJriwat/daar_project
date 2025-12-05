import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../models/address_model.dart';

class AddressRepositoryImpl implements AddressRepository {
  final SupabaseClient supabase;

  AddressRepositoryImpl(this.supabase);

  @override
  Future<List<Address>> getAddresses(String userId) async {
    final response = await supabase
        .from('addresses')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => AddressModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> addAddress(Address address) async {
    final addressModel = AddressModel.fromEntity(address);
    final json = addressModel.toJson();
    json.remove('id'); // Rimuovi l'ID per l'auto-generazione

    // Se il nuovo indirizzo è default, resetta tutti gli altri
    if (address.isDefault) {
      await supabase
          .from('addresses')
          .update({'is_default': false})
          .eq('user_id', address.userId);
    }

    // Inserisci il nuovo indirizzo
    await supabase.from('addresses').insert(json);
  }

  @override
  Future<void> updateAddress(Address address) async {
    final addressModel = AddressModel.fromEntity(address);
    await supabase
        .from('addresses')
        .update(addressModel.toJson())
        .eq('id', address.id);
  }

  @override
  Future<void> deleteAddress(String id, String userId) async {
    // Prima controlla se l'indirizzo da eliminare è quello default
    final addresses = await getAddresses(userId);
    final addressToDelete = addresses.firstWhere((addr) => addr.id == id);

    // Elimina l'indirizzo
    await supabase.from('addresses').delete().eq('id', id);

    // Se era default, setta l'ultimo indirizzo creato come default
    if (addressToDelete.isDefault && addresses.length > 1) {
      final remainingAddresses = addresses.where((addr) => addr.id != id).toList();
      if (remainingAddresses.isNotEmpty) {
        // Prendi l'ultimo indirizzo creato (ordinato per created_at)
        remainingAddresses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        final lastAddress = remainingAddresses.first;

        await supabase
            .from('addresses')
            .update({'is_default': true})
            .eq('id', lastAddress.id);
      }
    }
  }

  @override
  Future<void> setDefaultAddress(String id, String userId) async {
    // Reset all addresses to non-default
    await supabase
        .from('addresses')
        .update({'is_default': false})
        .eq('user_id', userId);

    // Set the selected address as default
    await supabase
        .from('addresses')
        .update({'is_default': true})
        .eq('id', id);
  }
}