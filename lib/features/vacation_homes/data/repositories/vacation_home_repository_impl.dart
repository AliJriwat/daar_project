import 'package:daar_project/features/vacation_homes/domain/entities/vacation_home.dart';
import 'package:daar_project/features/vacation_homes/domain/repositories/vacation_home_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VacationHomeRepositoryImpl implements VacationHomeRepository {
  final SupabaseClient supabase;

  VacationHomeRepositoryImpl(this.supabase);

  @override
  Future<void> addHome(VacationHome home) async {
    // Prima inserisci la vacation home
    final homeResponse = await supabase.from('vacation_homes').insert({
      'owner_id': home.ownerId,
      'title': home.title,
      'description': home.description,
      'price_per_night': home.pricePerNight,
      'photo_urls': home.photoUrls,
      'address': home.address,
      'latitude': home.latitude,
      'longitude': home.longitude,
      'max_guests': home.maxGuests,
      'bedrooms': home.bedrooms,
      'beds': home.beds,
      'bathrooms': home.bathrooms,
      'is_approved': home.isApproved,
      'is_active': home.isActive,
      'created_at': home.createdAt.toIso8601String(),
    }).select('id').single();

    final homeId = homeResponse['id'].toString();

    // Poi inserisci i servizi
    await supabase.from('vacation_home_services').insert({
      'vacation_home_id': homeId,
      'pool': home.services['pool'] ?? false,
      'wifi': home.services['wifi'] ?? false,
      'parking': home.services['parking'] ?? false,
      'air_conditioning': home.services['air_conditioning'] ?? false,
      'pet_friendly': home.services['pet_friendly'] ?? false,
      'barbecue': home.services['barbecue'] ?? false,
      'sea_access': home.services['sea_access'] ?? false,
      'outdoor_shower': home.services['outdoor_shower'] ?? false,
      'spa': home.services['spa'] ?? false,
      'tv': home.services['tv'] ?? false,
      'sports_equipment': home.services['sports_equipment'] ?? false,
      'outdoor_kitchen': home.services['outdoor_kitchen'] ?? false,
    });
  }
}