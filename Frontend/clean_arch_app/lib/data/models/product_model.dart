import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required String code,
    String? description,
    required double price,
    required int quantity,
    required int reorderLevel,
    required int reorderQuantity,
    required String category,
    String? supplierId,
    String? supplierName,
    String? locationId,
    String? locationName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
         id: id,
         name: name,
         code: code,
         description: description,
         price: price,
         quantity: quantity,
         reorderLevel: reorderLevel,
         reorderQuantity: reorderQuantity,
         category: category,
         supplierId: supplierId,
         supplierName: supplierName,
         locationId: locationId,
         locationName: locationName,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'price': price,
      'quantity': quantity,
      'reorderLevel': reorderLevel,
      'reorderQuantity': reorderQuantity,
      'category': category,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'locationId': locationId,
      'locationName': locationName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      reorderLevel: json['reorderLevel'] as int,
      reorderQuantity: json['reorderQuantity'] as int,
      category: json['category'] as String,
      supplierId: json['supplierId'] as String?,
      supplierName: json['supplierName'] as String?,
      locationId: json['locationId'] as String?,
      locationName: json['locationName'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
