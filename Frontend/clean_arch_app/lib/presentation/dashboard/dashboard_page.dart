import 'package:flutter/material.dart';
import 'widgets/stat_card.dart';
import 'widgets/quick_action_card.dart';
import 'dashboard_view_model.dart';

class DashboardPage extends StatelessWidget {
  final DashboardViewModel viewModel;

  DashboardPage({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [_buildStatsSection(), _buildQuickActionsSection()],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          StatCard(title: 'Stat 1', value: viewModel.totalProducts),
          StatCard(title: 'Stat 2', value: viewModel.lowStockItems),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuickActionCard(
          title: 'Action 1',
          onTap: viewModel.addNewProduct,
          icon: Icons.production_quantity_limits_rounded,
        ),
        QuickActionCard(
          title: 'Action 2',
          onTap: viewModel.createNewOrder,
          icon: Icons.add_shopping_cart,
        ),
      ],
    );
  }
}
