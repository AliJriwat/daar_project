import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.isDefault,
    required super.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      name: json['address_name'] ?? '',
      description: json['description'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isDefault: json['is_default'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address_name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AddressModel.fromEntity(Address address) {
    return AddressModel(
      id: address.id,
      userId: address.userId,
      name: address.name,
      description: address.description,
      latitude: address.latitude,
      longitude: address.longitude,
      isDefault: address.isDefault,
      createdAt: address.createdAt,
    );
  }
}