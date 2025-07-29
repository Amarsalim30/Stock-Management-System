import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../../data/models/stock_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/stock_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/enums/stock_status.dart';
import '../../domain/entities/permission.dart';

enum SortBy { name, sku, quantity, lastUpdated }

enum SortOrder { ascending, descending }

// Stock State
class StockState {
  final List<StockModel> stocks;
  final List<StockModel> filteredStocks;
  final Set<String> selectedStockIds;
  final bool isLoading;
  final bool isBulkSelectionMode;
  final String searchQuery;
  final StockStatus? filterStatus;
  final SortBy sortBy;
  final SortOrder sortOrder;
  final String? error;
  final UserModel? currentUser;

  StockState({
    this.stocks = const [],
    this.filteredStocks = const [],
    this.selectedStockIds = const {},
    this.isLoading = false,
    this.isBulkSelectionMode = false,
    this.searchQuery = '',
    this.filterStatus,
    this.sortBy = SortBy.name,
    this.sortOrder = SortOrder.ascending,
    this.error,
    this.currentUser,
  });

  StockState copyWith({
    List<StockModel>? stocks,
    List<StockModel>? filteredStocks,
    Set<String>? selectedStockIds,
    bool? isLoading,
    bool? isBulkSelectionMode,
    String? searchQuery,
    StockStatus? filterStatus,
    SortBy? sortBy,
    SortOrder? sortOrder,
    String? error,
    UserModel? currentUser,
  }) {
    return StockState(
      stocks: stocks ?? this.stocks,
      filteredStocks: filteredStocks ?? this.filteredStocks,
      selectedStockIds: selectedStockIds ?? this.selectedStockIds,
      isLoading: isLoading ?? this.isLoading,
      isBulkSelectionMode: isBulkSelectionMode ?? this.isBulkSelectionMode,
      searchQuery: searchQuery ?? this.searchQuery,
      filterStatus: filterStatus ?? this.filterStatus,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      error: error,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class StockViewModel extends StateNotifier<StockState> {
  final StockRepository _stockRepository;
  final AuthRepository _authRepository;

  // Getters
  List<StockModel> get stocks => state.filteredStocks;

  Set<String> get selectedStockIds => state.selectedStockIds;

  bool get isLoading => state.isLoading;

  bool get isBulkSelectionMode => state.isBulkSelectionMode;

  String get searchQuery => state.searchQuery;

  StockStatus? get filterStatus => state.filterStatus;

  SortBy get sortBy => state.sortBy;

  SortOrder get sortOrder => state.sortOrder;

  String? get error => state.error;

  bool get hasSelectedItems => state.selectedStockIds.isNotEmpty;

  int get selectedCount => state.selectedStockIds.length;

  UserModel? get currentUser => state.currentUser;

  StockViewModel({
    required StockRepository stockRepository,
    required AuthRepository authRepository,
  }) : _stockRepository = stockRepository,
       _authRepository = authRepository,
       super(StockState()) {
    _loadCurrentUser();
    loadStocks();
  }

  // Permission checks
  bool hasPermission(PermissionType permission) {
    return state.currentUser?.hasPermission(permission) ?? false;
  }

  bool get canCreateStock => hasPermission(PermissionType.createProduct);

  bool get canEditStock => hasPermission(PermissionType.editProduct);

  bool get canDeleteStock => hasPermission(PermissionType.deleteProduct);

  bool get canAdjustStock => hasPermission(PermissionType.adjustStock);

  bool get canViewStockReports => hasPermission(PermissionType.viewReports);

  // Load current user
  Future<void> _loadCurrentUser() async {
    try {
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (failure) => print('Error loading current user: $failure'),
        (user) =>
            state = state.copyWith(currentUser: UserModel.fromEntity(user)),
      );
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  // Load stocks
  Future<void> loadStocks() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final stocks = await _stockRepository.getStocks();
      state = state.copyWith(stocks: stocks);
      _applyFiltersAndSort();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Search functionality
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFiltersAndSort();
  }

  // Filter functionality
  void setFilterStatus(StockStatus? status) {
    state = state.copyWith(filterStatus: status);
    _applyFiltersAndSort();
  }

  // Sort functionality
  void setSortBy(SortBy sortBy) {
    if (state.sortBy == sortBy) {
      state = state.copyWith(
        sortOrder: state.sortOrder == SortOrder.ascending
            ? SortOrder.descending
            : SortOrder.ascending,
      );
    } else {
      state = state.copyWith(sortBy: sortBy, sortOrder: SortOrder.ascending);
    }
    _applyFiltersAndSort();
  }

  // Apply filters and sort
  void _applyFiltersAndSort() {
    var filteredStocks = List.from(state.stocks);

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filteredStocks = filteredStocks.where((stock) {
        return stock.name.toLowerCase().contains(query) ||
            stock.sku.toLowerCase().contains(query) ||
            (stock.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply status filter
    if (state.filterStatus != null) {
      filteredStocks = filteredStocks.where((stock) {
        return stock.status == state.filterStatus;
      }).toList();
    }

    // Apply sorting
    filteredStocks.sort((a, b) {
      int comparison;
      switch (state.sortBy) {
        case SortBy.name:
          comparison = a.name.compareTo(b.name);
          break;
        case SortBy.sku:
          comparison = a.sku.compareTo(b.sku);
          break;
        case SortBy.quantity:
          comparison = a.quantity.compareTo(b.quantity);
          break;
        case SortBy.lastUpdated:
          comparison = a.updatedAt.compareTo(b.updatedAt);
          break;
      }
      return state.sortOrder == SortOrder.ascending ? comparison : -comparison;
    });

    state = state.copyWith(filteredStocks: filteredStocks);
  }

  // Bulk selection
  void toggleBulkSelectionMode() {
    final newMode = !state.isBulkSelectionMode;
    if (!newMode) {
      state = state.copyWith(
        isBulkSelectionMode: newMode,
        selectedStockIds: {},
      );
    } else {
      state = state.copyWith(isBulkSelectionMode: newMode);
    }
  }

  void toggleStockSelection(String stockId) {
    final newSet = Set<String>.from(state.selectedStockIds);
    if (newSet.contains(stockId)) {
      newSet.remove(stockId);
    } else {
      newSet.add(stockId);
    }
    state = state.copyWith(selectedStockIds: newSet);
  }

  void selectAll() {
    final allIds = state.filteredStocks.map((stock) => stock.id).toSet();
    state = state.copyWith(selectedStockIds: allIds);
  }

  void clearSelection() {
    state = state.copyWith(selectedStockIds: {});
  }

  // CRUD Operations
  Future<void> createStock(StockModel stock) async {
    if (!canCreateStock) {
      state = state.copyWith(
        error: 'You do not have permission to create stock items',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _stockRepository.createStock(stock);
      await loadStocks();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateStock(StockModel stock) async {
    if (!canEditStock) {
      state = state.copyWith(
        error: 'You do not have permission to edit stock items',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _stockRepository.updateStock(stock);
      await loadStocks();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteStock(String stockId) async {
    if (!canDeleteStock) {
      state = state.copyWith(
        error: 'You do not have permission to delete stock items',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _stockRepository.deleteStock(stockId);
      final updatedStocks = state.stocks
          .where((stock) => stock.id != stockId)
          .toList();
      final updatedSelectedIds = Set<String>.from(state.selectedStockIds)
        ..remove(stockId);
      state = state.copyWith(
        stocks: updatedStocks,
        selectedStockIds: updatedSelectedIds,
      );
      _applyFiltersAndSort();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> bulkDelete() async {
    if (!canDeleteStock) {
      state = state.copyWith(
        error: 'You do not have permission to delete stock items',
      );
      return;
    }

    if (state.selectedStockIds.isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.wait(
        state.selectedStockIds.map((id) => _stockRepository.deleteStock(id)),
      );
      final updatedStocks = state.stocks
          .where((stock) => !state.selectedStockIds.contains(stock.id))
          .toList();
      state = state.copyWith(
        stocks: updatedStocks,
        selectedStockIds: {},
        isBulkSelectionMode: false,
      );
      _applyFiltersAndSort();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> adjustStock(
    String stockId,
    int adjustment,
    String reason,
  ) async {
    if (!canAdjustStock) {
      state = state.copyWith(
        error: 'You do not have permission to adjust stock quantities',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _stockRepository.adjustStock(stockId, adjustment, reason);
      await loadStocks();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> bulkUpdateStatus(StockStatus status) async {
    if (!canEditStock) {
      state = state.copyWith(
        error: 'You do not have permission to edit stock items',
      );
      return;
    }

    if (state.selectedStockIds.isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final selectedStocks = state.stocks
          .where((stock) => state.selectedStockIds.contains(stock.id))
          .toList();

      await Future.wait(
        selectedStocks.map(
          (stock) =>
              _stockRepository.updateStock(stock.copyWith(status: status)),
        ),
      );

      await loadStocks();
      state = state.copyWith(selectedStockIds: {}, isBulkSelectionMode: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Get stock by ID
  StockModel? getStockById(String id) {
    return state.stocks.firstWhereOrNull((stock) => stock.id == id);
  }

  // Refresh
  Future<void> refresh() async {
    await loadStocks();
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Provider definition
final stockViewModelProvider =
    StateNotifierProvider.autoDispose<StockViewModel, StockState>((ref) {
      throw UnimplementedError('stockViewModelProvider must be overridden');
    });
