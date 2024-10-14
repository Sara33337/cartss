class CartModel {
  final int cartId;
  final List<CartProducts> products;

  CartModel({required this.cartId, required this.products});

  factory CartModel.fromJson(jsonData) {
    var productsFromJson = jsonData['products'] as List;

    List<CartProducts> productList = productsFromJson.map((product) {
      return CartProducts.fromJson(product as Map<String, dynamic>);
    }).toList();

    return CartModel(cartId: jsonData['id'], products: productList);
  }
}

final List<CartProducts> addedProducts = [];

class CartProducts {
  final int productId;
  final String productTitle;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;
  String status;

  CartProducts(
      {required this.productId,
      required this.productTitle,
      required this.price,
      required this.quantity,
      required this.total,
      required this.discountedTotal,
      required this.discountPercentage,
      required this.thumbnail,
      required this.status});

  factory CartProducts.fromJson(jsonData) {
    return CartProducts(
      productId: jsonData['id'],
      productTitle: jsonData['title'],
      price: (jsonData['price'] as num).toDouble(),
      quantity: jsonData['quantity'],
      total: (jsonData['total'] as num).toDouble(),
      discountPercentage: (jsonData['discountPercentage'] as num).toDouble(),
      discountedTotal: (jsonData['discountedTotal'] as num).toDouble(),
      thumbnail: jsonData['thumbnail'],
      status: "Add"
    );
  }
}
