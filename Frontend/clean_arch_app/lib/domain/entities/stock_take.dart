import 'package:equatable/equatable.dart';

enum StockTakeStatus { active, paused, completed, cancelled }

enum CountMethod { manual, barcode, photo }

class StockTake extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final StockTakeStatus status;
  final String createdBy;
  final List<String> assignedTo;
  final String? locationId;
  final List<String>? categoryFilters;
  final int totalItems;
  final int countedItems;
  final int discrepancies;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StockTake({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.createdBy,
    required this.assignedTo,
    this.locationId,
    this.categoryFilters,
    required this.totalItems,
    required this.countedItems,
    required this.discrepancies,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  double get progressPercentage =>
      totalItems > 0 ? (countedItems / totalItems) * 100 : 0;

  bool get isCompleted => status == StockTakeStatus.completed;

  bool get isActive => status == StockTakeStatus.active;

  bool get isPaused => status == StockTakeStatus.paused;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    startDate,
    endDate,
    status,
    createdBy,
    assignedTo,
    locationId,
    categoryFilters,
    totalItems,
    countedItems,
    discrepancies,
    metadata,
    createdAt,
    updatedAt,
  ];
}

class StockTakeItem extends Equatable {
  final String id;
  final String stockTakeId;
  final String productId;
  final String productName;
  final String productCode;
  final int systemQuantity;
  final int? countedQuantity;
  final CountMethod? countMethod;
  final String? countedBy;
  final DateTime? countedAt;
  final String? notes;
  final List<String>? photoUrls;
  final Map<String, dynamic>? metadata;

  const StockTakeItem({
    required this.id,
    required this.stockTakeId,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.systemQuantity,
    this.countedQuantity,
    this.countMethod,
    this.countedBy,
    this.countedAt,
    this.notes,
    this.photoUrls,
    this.metadata,
  });

  int get discrepancy => (countedQuantity ?? 0) - systemQuantity;

  bool get hasDiscrepancy => discrepancy != 0;

  bool get isCounted => countedQuantity != null;

  @override
  List<Object?> get props => [
    id,
    stockTakeId,
    productId,
    productName,
    productCode,
    systemQuantity,
    countedQuantity,
    countMethod,
    countedBy,
    countedAt,
    notes,
    photoUrls,
    metadata,
  ];
}
