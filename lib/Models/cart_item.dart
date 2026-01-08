/// CartItem Model for Smart Cart Auto-Group
class CartItem {
  final String id;
  final String name;
  final int qty;
  final double price;
  final String imageURL;
  final String category;

  CartItem({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.imageURL,
    required this.category,
  });

  CartItem copyWith({int? qty}) {
    return CartItem(
      id: id,
      name: name,
      qty: qty ?? this.qty,
      price: price,
      imageURL: imageURL,
      category: category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
