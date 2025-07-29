import '../../data/models/stock_model.dart';
import '../../core/enums/stock_status.dart';

abstract class StockRepository {
  // Basic CRUD operations
  Future<List<StockModel>> getStocks();

  Future<StockModel> getStockById(String id);

  Future<void> createStock(StockModel stock);

  Future<void> updateStock(StockModel stock);

  Future<void> deleteStock(String id);

  // Bulk operations
  Future<void> deleteStocks(List<String> ids);

  Future<void> updateStockStatus(List<String> ids, StockStatus status);

  // Stock specific operations
  Future<void> adjustStock(String stockId, int adjustment, String reason);
}
