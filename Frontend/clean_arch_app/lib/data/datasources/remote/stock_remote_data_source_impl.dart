import 'package:dio/dio.dart';
import '../../models/stock_model.dart';
import '../../../core/enums/stock_status.dart';
import '../../../domain/repositories/stock_remote_data_source.dart';

class StockRemoteDataSourceImpl implements StockRemoteDataSource {
  final Dio dio;
  static const String _baseEndpoint = '/stocks';

  StockRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<StockModel>> getStocks() async {
    try {
      final response = await dio.get(_baseEndpoint);
      final List<dynamic> data = response.data;
      return data.map((json) => StockModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch stocks: $e');
    }
  }

  @override
  Future<StockModel> getStockById(String id) async {
    try {
      final response = await dio.get('$_baseEndpoint/$id');
      return StockModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch stock: $e');
    }
  }

  @override
  Future<void> createStock(StockModel stock) async {
    try {
      await dio.post(_baseEndpoint, data: stock.toJson());
    } catch (e) {
      throw Exception('Failed to create stock: $e');
    }
  }

  @override
  Future<void> updateStock(StockModel stock) async {
    try {
      await dio.put('$_baseEndpoint/${stock.id}', data: stock.toJson());
    } catch (e) {
      throw Exception('Failed to update stock: $e');
    }
  }

  @override
  Future<void> deleteStock(String id) async {
    try {
      await dio.delete('$_baseEndpoint/$id');
    } catch (e) {
      throw Exception('Failed to delete stock: $e');
    }
  }

  @override
  Future<void> deleteStocks(List<String> ids) async {
    try {
      await dio.post('$_baseEndpoint/bulk-delete', data: {'ids': ids});
    } catch (e) {
      throw Exception('Failed to delete stocks: $e');
    }
  }

  @override
  Future<void> updateStockStatus(List<String> ids, StockStatus status) async {
    try {
      await dio.post(
        '$_baseEndpoint/bulk-update-status',
        data: {'ids': ids, 'status': status.code},
      );
    } catch (e) {
      throw Exception('Failed to update stock status: $e');
    }
  }

  @override
  Future<void> adjustStock(
    String stockId,
    int adjustment,
    String reason,
  ) async {
    try {
      await dio.post(
        '$_baseEndpoint/$stockId/adjust',
        data: {'adjustment': adjustment, 'reason': reason},
      );
    } catch (e) {
      throw Exception('Failed to adjust stock: $e');
    }
  }
}
