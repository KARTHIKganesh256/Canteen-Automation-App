import 'cart_item.dart';

/// Order Model
class Order {
  final String id;
  final List<CartItem> items;
  final DateTime date;
  final String timeOfDay; // 'breakfast', 'lunch', 'dinner'

  Order({
    required this.id,
    required this.items,
    required this.date,
    required this.timeOfDay,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((e) => e.toJson()).toList(),
        'date': date.toIso8601String(),
        'timeOfDay': timeOfDay,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        items: (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
        date: DateTime.parse(json['date']),
        timeOfDay: json['timeOfDay'],
      );
}
