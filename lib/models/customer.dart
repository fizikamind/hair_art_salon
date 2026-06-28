class Customer {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String gender;
  final String address;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.gender,
    required this.address,
    required this.createdAt,
  });
}