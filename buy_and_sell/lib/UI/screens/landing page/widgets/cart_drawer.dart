import 'package:buy_and_sell/UI/screens/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/cart_provider.dart';

class CartDrawer extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartDrawer({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    double calculateTotal() {
      return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown.shade300, Colors.brown.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                "Your Cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
              child: Text(
                "No items in the cart.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Image.network(
                      item.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity: ${item.quantity}"),
                        Text(
                          "Price: \$${item.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cartProvider.decreaseQuantity(item.id);
                          },
                        ),
                        Text(
                          "${item.quantity}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartProvider.increaseQuantity(item.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            cartProvider.removeItem(item.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer with Total Price and Checkout Button
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Total: \$${calculateTotal().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Pass the necessary values to the CheckoutScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModernCheckoutScreen(
                            items: cartItems.map((item) {
                              return {
                                'productId': item.id,
                                'name': item.name,
                                'quantity': item.quantity,
                                'price': item.price,
                                'subtotal': item.totalPrice,
                              };
                            }).toList(),
                            totalPrice: calculateTotal(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
