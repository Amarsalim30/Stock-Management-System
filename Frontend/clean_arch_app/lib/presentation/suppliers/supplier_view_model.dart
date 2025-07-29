import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mock_data.dart';

enum SortOption { name, recent, location }

enum Status { active, inactive }

class Supplier {
  final String id;
  final String name;
  final String contactPerson;
  final String email;
  final Status status;

  Supplier({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.email,
    required this.status,
  });
}

class SupplierViewModel extends StateNotifier<List<Supplier>> {
  SupplierViewModel() : super(mockSuppliers);

  void addSupplier(Supplier supplier) {
    state = [...state, supplier];
  }

  void editSupplier(String id, Supplier updatedSupplier) {
    state = [
      for (final supplier in state)
        if (supplier.id == id) updatedSupplier else supplier,
    ];
  }

  void deleteSupplier(String id) {
    state = state.where((supplier) => supplier.id != id).toList();
  }

  void searchSuppliers(String query) {
    state = mockSuppliers.where((supplier) {
      return supplier.name.toLowerCase().contains(query.toLowerCase()) ||
          supplier.contactPerson.toLowerCase().contains(query.toLowerCase()) ||
          supplier.email.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void filterByStatus(Status status) {
    state = mockSuppliers
        .where((supplier) => supplier.status == status)
        .toList();
  }

  void sortBy(SortOption option) {
    state = List.from(state);
    // Implement sorting logic based on SortOption
    // Consider using `state..sort()` for in-place sorting if needed
  }
}

final supplierViewModelProvider =
    StateNotifierProvider<SupplierViewModel, List<Supplier>>((ref) {
      return SupplierViewModel();
    });
