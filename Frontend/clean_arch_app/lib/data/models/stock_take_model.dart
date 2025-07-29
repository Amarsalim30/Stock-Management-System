import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/stock_take.dart';

part 'stock_take_model.g.dart';

@JsonSerializable()
class StockTakeModel extends StockTake {
  const StockTakeModel({
    required String id,
    required String name,
    String? description,
    required DateTime startDate,
    DateTime? endDate,
    required StockTakeStatus status,
    required String createdBy,
    required List<String> assignedTo,
    String? locationId,
    List<String>? categoryFilters,
    required int totalItems,
    required int countedItems,
    required int discrepancies,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
         id: id,
         name: name,
         description: description,
         startDate: startDate,
         endDate: endDate,
         status: status,
         createdBy: createdBy,
         assignedTo: assignedTo,
         locationId: locationId,
         categoryFilters: categoryFilters,
         totalItems: totalItems,
         countedItems: countedItems,
         discrepancies: discrepancies,
         metadata: metadata,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory StockTakeModel.fromJson(Map<String, dynamic> json) =>
      _$StockTakeModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockTakeModelToJson(this);

  factory StockTakeModel.fromEntity(StockTake stockTake) {
    return StockTakeModel(
      id: stockTake.id,
      name: stockTake.name,
      description: stockTake.description,
      startDate: stockTake.startDate,
      endDate: stockTake.endDate,
      status: stockTake.status,
      createdBy: stockTake.createdBy,
      assignedTo: stockTake.assignedTo,
      locationId: stockTake.locationId,
      categoryFilters: stockTake.categoryFilters,
      totalItems: stockTake.totalItems,
      countedItems: stockTake.countedItems,
      discrepancies: stockTake.discrepancies,
      metadata: stockTake.metadata,
      createdAt: stockTake.createdAt,
      updatedAt: stockTake.updatedAt,
    );
  }
}

@JsonSerializable()
class StockTakeItemModel extends StockTakeItem {
  const StockTakeItemModel({
    required String id,
    required String stockTakeId,
    required String productId,
    required String productName,
    required String productCode,
    required int systemQuantity,
    int? countedQuantity,
    CountMethod? countMethod,
    String? countedBy,
    DateTime? countedAt,
    String? notes,
    List<String>? photoUrls,
    Map<String, dynamic>? metadata,
  }) : super(
         id: id,
         stockTakeId: stockTakeId,
         productId: productId,
         productName: productName,
         productCode: productCode,
         systemQuantity: systemQuantity,
         countedQuantity: countedQuantity,
         countMethod: countMethod,
         countedBy: countedBy,
         countedAt: countedAt,
         notes: notes,
         photoUrls: photoUrls,
         metadata: metadata,
       );

  factory StockTakeItemModel.fromJson(Map<String, dynamic> json) =>
      _$StockTakeItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockTakeItemModelToJson(this);

  factory StockTakeItemModel.fromEntity(StockTakeItem item) {
    return StockTakeItemModel(
      id: item.id,
      stockTakeId: item.stockTakeId,
      productId: item.productId,
      productName: item.productName,
      productCode: item.productCode,
      systemQuantity: item.systemQuantity,
      countedQuantity: item.countedQuantity,
      countMethod: item.countMethod,
      countedBy: item.countedBy,
      countedAt: item.countedAt,
      notes: item.notes,
      photoUrls: item.photoUrls,
      metadata: item.metadata,
    );
  }
}
