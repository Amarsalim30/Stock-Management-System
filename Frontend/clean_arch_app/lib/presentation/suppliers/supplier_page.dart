import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'supplier_view_model.dart';

class SupplierPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final supplierViewModel = watch(supplierViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearch(context, supplierViewModel),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context, supplierViewModel),
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _showSortOptions(context, supplierViewModel),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: supplierViewModel.suppliers.length,
        itemBuilder: (context, index) {
          final supplier = supplierViewModel.suppliers[index];
          return ListTile(
            title: Text(supplier.name),
            subtitle: Text(supplier.contactPerson),
            trailing: _buildActions(context, supplierViewModel, supplier),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addSupplier(context, supplierViewModel),
      ),
    );
  }

  void _showSearch(BuildContext context, SupplierViewModel viewModel) {
    // Implement search functionality
  }

  void _showFilterOptions(BuildContext context, SupplierViewModel viewModel) {
    // Implement filter options
  }

  void _showSortOptions(BuildContext context, SupplierViewModel viewModel) {
    // Implement sort options
  }

  Widget _buildActions(
    BuildContext context,
    SupplierViewModel viewModel,
    Supplier supplier,
  ) {
    // Implement actions for edit/delete with permission checks
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _editSupplier(context, viewModel, supplier),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteSupplier(context, viewModel, supplier),
        ),
      ],
    );
  }

  void _addSupplier(BuildContext context, SupplierViewModel viewModel) {
    // Implement add supplier
  }

  void _editSupplier(
    BuildContext context,
    SupplierViewModel viewModel,
    Supplier supplier,
  ) {
    // Implement edit supplier
  }

  void _deleteSupplier(
    BuildContext context,
    SupplierViewModel viewModel,
    Supplier supplier,
  ) {
    // Implement delete supplier
  }
}
