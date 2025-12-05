import '../../../vacation_homes/domain/entities/vacation_home.dart';

class VacationHomeModel extends VacationHome {
  const VacationHomeModel({
    required super.id,
    required super.ownerId,
    required super.title,
    required super.description,
    required super.pricePerNight,
    required super.photoUrls,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.maxGuests,
    required super.bedrooms,
    required super.beds,
    required super.bathrooms,
    required super.services,
    required super.isApproved,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory VacationHomeModel.fromJson(Map<String, dynamic> json) {
    return VacationHomeModel(
      id: json['id'].toString(),
      ownerId: json['owner_id'].toString(),
      title: json['title'],
      description: json['description'],
      pricePerNight: (json['price_per_night'] as num).toDouble(),
      photoUrls: List<String>.from(json['photo_urls'] ?? []),
      address: json['address'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      maxGuests: json['max_guests'] ?? 1,
      bedrooms: json['bedrooms'] ?? 1,
      beds: json['beds'] ?? 1,
      bathrooms: json['bathrooms'] ?? 1,
      services: _parseServices(json), // Nuovo metodo per servizi
      isApproved: json['is_approved'] ?? false,
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  static Map<String, bool> _parseServices(Map<String, dynamic> json) {
    return {
      'pool': json['pool'] ?? false,
      'wifi': json['wifi'] ?? false,
      'parking': json['parking'] ?? false,
      'air_conditioning': json['air_conditioning'] ?? false,
      'pet_friendly': json['pet_friendly'] ?? false,
      'barbecue': json['barbecue'] ?? false,
      'sea_access': json['sea_access'] ?? false,
      'outdoor_shower': json['outdoor_shower'] ?? false,
      'spa': json['spa'] ?? false,
      'tv': json['tv'] ?? false,
      'sports_equipment': json['sports_equipment'] ?? false,
      'outdoor_kitchen': json['outdoor_kitchen'] ?? false,
    };
  }
}