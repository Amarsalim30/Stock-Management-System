import '../../data/models/stock_model.dart';
import '../../core/enums/stock_status.dart';

abstract class StockRemoteDataSource {
  Future<List<StockModel>> getStocks();

  Future<StockModel> getStockById(String id);

  Future<void> createStock(StockModel stock);

  Future<void> updateStock(StockModel stock);

  Future<void> deleteStock(String id);

  Future<void> deleteStocks(List<String> ids);

  Future<void> updateStockStatus(List<String> ids, StockStatus status);

  Future<void> adjustStock(String stockId, int adjustment, String reason);
}
