import '../../domain/entities/supplier.dart';

class SupplierModel extends Supplier {
  const SupplierModel({
    required String id,
    required String name,
    String? contactPerson,
    String? email,
    String? phoneNumber,
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
         contactPerson: contactPerson,
         email: email,
         phoneNumber: phoneNumber,
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
      'contactPerson': contactPerson,
      'email': email,
      'phoneNumber': phoneNumber,
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

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'] as String,
      name: json['name'] as String,
      contactPerson: json['contactPerson'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
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
