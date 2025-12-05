class VacationHome {
  final String? id;
  final String ownerId;
  final String title;
  final String description;
  final double pricePerNight;
  final List<String> photoUrls;
  final String address;
  final double latitude;
  final double longitude;
  final int maxGuests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final Map<String, bool> services;
  final bool isApproved;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const VacationHome({
    this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.pricePerNight,
    this.photoUrls = const [],
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.maxGuests,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.services,
    this.isApproved = false,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  VacationHome copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? description,
    double? pricePerNight,
    List<String>? photoUrls,
    String? address,
    double? latitude,
    double? longitude,
    int? maxGuests,
    int? bedrooms,
    int? beds,
    int? bathrooms,
    Map<String, bool>? services,
    bool? isApproved,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VacationHome(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      photoUrls: photoUrls ?? this.photoUrls,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxGuests: maxGuests ?? this.maxGuests,
      bedrooms: bedrooms ?? this.bedrooms,
      beds: beds ?? this.beds,
      bathrooms: bathrooms ?? this.bathrooms,
      services: services ?? this.services,
      isApproved: isApproved ?? this.isApproved,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}