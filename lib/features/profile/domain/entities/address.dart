class Address {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final DateTime createdAt;

  const Address({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
    required this.createdAt,
  });

  Address copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}