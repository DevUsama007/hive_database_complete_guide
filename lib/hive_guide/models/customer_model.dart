import 'package:hive/hive.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 2)
class CustomerModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  @HiveField(2)
  List<String> orders;
  CustomerModel({
    required this.name,
    required this.address,
    this.orders = const [],
  });
}
