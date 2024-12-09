// import 'package:flutter/material.dart';
// import 'package:buy_and_sell/models/featured_product_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../providers/cart_provider.dart';
//
// class ProductCard extends StatefulWidget {
//   final FeaturedProduct product;
//   final VoidCallback onAddToCart;
//   final String id;
//   final String name;
//   final String image;
//   final double price;
//
//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.onAddToCart,
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//   });
//
//   @override
//   State<ProductCard> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<ProductCard> {
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                 child: widget.product.images.isNotEmpty
//                     ? Image.network(
//                   widget.product.images.first,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.error, size: 50, color: Colors.grey),
//                 )
//                     : const Icon(Icons.broken_image, size: 50, color: Colors.grey),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.product.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '\$${widget.product.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           context.read<CartProvider>().addToCart(
//                             CartItem(
//                               id: widget.product.id,
//                               name: widget.product.name,
//                               image: widget.product.images.first,
//                               price: widget.product.price,
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).primaryColor,
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           textStyle: const TextStyle(fontSize: 12),
//                         ),
//                         child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
