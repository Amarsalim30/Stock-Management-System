import 'package:flutter/foundation.dart';
import 'dart:async';

class DashboardViewModel extends ChangeNotifier {
  // Stats data
  String _totalProducts = '0';
  String _lowStockItems = '0';
  String _todaySales = '\$0';
  String _pendingOrders = '0';

  // Getters for stats
  String get totalProducts => _totalProducts;

  String get lowStockItems => _lowStockItems;

  String get todaySales => _todaySales;

  String get pendingOrders => _pendingOrders;

  // Loading state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Error state
  String? _error;

  String? get error => _error;

  // Timer for real-time refresh
  Timer? _refreshTimer;

  DashboardViewModel() {
    _initializeDashboard();
  }

  void _initializeDashboard() {
    loadDashboardData();
    // Set up real-time refresh every 30 seconds
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      loadDashboardData();
    });
  }

  Future<void> loadDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call to fetch dashboard data
      await Future.delayed(Duration(seconds: 1));

      // Update stats (in real app, this would come from API)
      _totalProducts = '150';
      _lowStockItems = '12';
      _todaySales = '\$2,450';
      _pendingOrders = '8';

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load dashboard data';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Navigation methods
  void navigateToProducts() {
    // Navigate to products screen
    // Navigator.pushNamed(context, '/products');
  }

  void navigateToOrders() {
    // Navigate to orders screen
    // Navigator.pushNamed(context, '/orders');
  }

  void navigateToInventory() {
    // Navigate to inventory screen
    // Navigator.pushNamed(context, '/inventory');
  }

  void navigateToReports() {
    // Navigate to reports screen
    // Navigator.pushNamed(context, '/reports');
  }

  // Quick action methods
  void addNewProduct() {
    // Navigate to add product screen
    // Navigator.pushNamed(context, '/products/add');
  }

  void createNewOrder() {
    // Navigate to create order screen
    // Navigator.pushNamed(context, '/orders/create');
  }

  void viewLowStock() {
    // Navigate to low stock items
    // Navigator.pushNamed(context, '/inventory/low-stock');
  }

  void generateReport() {
    // Navigate to report generation
    // Navigator.pushNamed(context, '/reports/generate');
  }

  // Refresh data manually
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
