import '../../core/enums/stock_status.dart';

class StockModel {
  final String id;
  final String name;
  final String sku;
  final int quantity;
  final String? description;
  final StockStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  StockModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  StockModel copyWith({
    String? id,
    String? name,
    String? sku,
    int? quantity,
    String? description,
    StockStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StockModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      quantity: json['quantity'] as int,
      description: json['description'] as String?,
      status: StockStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'quantity': quantity,
      'description': description,
      'status': status.code,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static StockModel sampleData() {
    return StockModel(
      id: 'sampleId',
      name: 'Sample Product',
      sku: 'SAMPLE123',
      quantity: 100,
      description: 'This is a sample stock item.',
      status: StockStatus.available,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
