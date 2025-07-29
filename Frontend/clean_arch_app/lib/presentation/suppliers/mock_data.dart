import 'supplier_view_model.dart';

enum MockStatus { active, inactive }

class MockSupplier {
  final String id;
  final String name;
  final String contactPerson;
  final String email;
  final MockStatus status;

  MockSupplier({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.email,
    required this.status,
  });
}

List<MockSupplier> mockSuppliers = [
  MockSupplier(
    id: '1',
    name: 'Supplier A',
    contactPerson: 'John Doe',
    email: 'johndoe@example.com',
    status: MockStatus.active,
  ),
  MockSupplier(
    id: '2',
    name: 'Supplier B',
    contactPerson: 'Jane Smith',
    email: 'janesmith@example.com',
    status: MockStatus.inactive,
  ),
  // Add more mock suppliers as needed.
];
