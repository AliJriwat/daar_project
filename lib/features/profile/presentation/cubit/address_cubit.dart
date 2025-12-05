// lib/presentation/cubit/address_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/address.dart';
import '../../domain/use_cases/get_addresses_use_case.dart';
import '../../domain/use_cases/add_address_use_case.dart';
import '../../domain/use_cases/update_address_use_case.dart';
import '../../domain/use_cases/delete_address_use_case.dart';
import '../../domain/use_cases/set_default_address_use_case.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetAddressesUseCase getAddressesUseCase;
  final AddAddressUseCase addAddressUseCase;
  final UpdateAddressUseCase updateAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final SetDefaultAddressUseCase setDefaultAddressUseCase;
  final SupabaseClient supabase;

  AddressCubit({
    required this.getAddressesUseCase,
    required this.addAddressUseCase,
    required this.updateAddressUseCase,
    required this.deleteAddressUseCase,
    required this.setDefaultAddressUseCase,
    required this.supabase,
  }) : super(AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressLoading());
    try {
      final userId = supabase.auth.currentUser!.id;
      final addresses = await getAddressesUseCase(userId);
      emit(AddressLoaded(addresses: addresses));
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> addAddress(Address address) async {
    try {
      await addAddressUseCase(address);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> updateAddress(Address address) async {
    try {
      await updateAddressUseCase(address);
      await getAddresses(); // Refresh the list
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await deleteAddressUseCase(id, userId);
      await getAddresses(); // Refresh the list
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> setDefaultAddress(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await setDefaultAddressUseCase(id, userId);
      await getAddresses(); // Refresh the list
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }
}