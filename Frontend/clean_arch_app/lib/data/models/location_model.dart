import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required String id,
    required String name,
    required String type,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    bool isActive = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
         id: id,
         name: name,
         type: type,
         address: address,
         city: city,
         state: state,
         country: country,
         postalCode: postalCode,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
