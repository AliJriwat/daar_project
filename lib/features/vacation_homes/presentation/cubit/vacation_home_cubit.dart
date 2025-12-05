import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../vacation_homes/domain/entities/vacation_home.dart';
import '../../../vacation_homes/domain/repositories/vacation_home_repository.dart';

part 'vacation_home_state.dart';

class VacationHomeCubit extends Cubit<VacationHomeState> {
  final VacationHomeRepository repository;
  final SupabaseClient supabase;

  VacationHomeCubit({
    required this.repository,
    required this.supabase,
  }) : super(VacationHomeInitial());

  Future<void> addHome({
    required String title,
    required String description,
    required double pricePerNight,
    required List<String> photoUrls,
    required String address,
    required double latitude,
    required double longitude,
    required int maxGuests,
    required int bedrooms,
    required int beds,
    required int bathrooms,
    required Map<String, bool> services,
  }) async {
    emit(VacationHomeLoading());
    try {
      final home = VacationHome(
        id: null,
        ownerId: supabase.auth.currentUser!.id,
        title: title,
        description: description,
        pricePerNight: pricePerNight,
        photoUrls: photoUrls,
        address: address,
        latitude: latitude,
        longitude: longitude,
        maxGuests: maxGuests,
        bedrooms: bedrooms,
        beds: beds,
        bathrooms: bathrooms,
        services: services,
        isApproved: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: null,
      );

      await repository.addHome(home);
      emit(VacationHomeAdded('success'));
    } catch (e) {
      emit(VacationHomeError(e.toString()));
    }
  }
}