import '../../domain/repositories/stock_repository.dart';
import '../../domain/repositories/stock_remote_data_source.dart';
import '../models/stock_model.dart';
import '../../../core/enums/stock_status.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource remote;

  StockRepositoryImpl({required this.remote});

  @override
  Future<List<StockModel>> getStocks() async {
    return await remote.getStocks();
  }

  @override
  Future<StockModel> getStockById(String id) async {
    return await remote.getStockById(id);
  }

  @override
  Future<void> createStock(StockModel stock) async {
    await remote.createStock(stock);
  }

  @override
  Future<void> updateStock(StockModel stock) async {
    await remote.updateStock(stock);
  }

  @override
  Future<void> deleteStock(String id) async {
    await remote.deleteStock(id);
  }

  @override
  Future<void> deleteStocks(List<String> ids) async {
    await remote.deleteStocks(ids);
  }

  @override
  Future<void> updateStockStatus(List<String> ids, StockStatus status) async {
    await remote.updateStockStatus(ids, status);
  }

  @override
  Future<void> adjustStock(
    String stockId,
    int adjustment,
    String reason,
  ) async {
    await remote.adjustStock(stockId, adjustment, reason);
  }
}
