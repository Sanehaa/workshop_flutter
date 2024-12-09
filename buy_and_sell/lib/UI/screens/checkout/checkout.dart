// lib/screens/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/checkout_provider.dart';

class ModernCheckoutScreen extends StatefulWidget {
  const ModernCheckoutScreen({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  final List<Map<String, dynamic>> items;
  final double totalPrice;

  @override
  ModernCheckoutScreenState createState() => ModernCheckoutScreenState();
}

class ModernCheckoutScreenState extends State<ModernCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(),

                const SizedBox(height: 20),

                // User Details Section
                _buildSectionTitle('User Details'),
                const SizedBox(height: 16),
                _buildRoundedTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Name is required.'
                      : null,
                ),
                _buildRoundedTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email.';
                    }
                    return null;
                  },
                ),
                _buildRoundedTextField(
                  controller: _addressController,
                  label: 'Address',
                  icon: Icons.location_on,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Address is required.'
                      : null,
                ),
                _buildRoundedTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required.';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Enter a valid phone number.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Order Summary Section
                _buildSectionTitle('Order Summary'),
                const SizedBox(height: 16),
                _buildOrderSummaryCard(),

                const SizedBox(height: 30),

                // Confirm Button
                _buildGradientButton(
                  text: orderProvider.isLoading
                      ? 'Placing Order...'
                      : 'Confirm Order',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final Map<String, dynamic> orderData = {
                        'user': {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text,
                          'phone': _phoneController.text,
                        },
                        'items': widget.items,
                        'totalPrice': widget.totalPrice,
                      };

                      await orderProvider.createOrder(orderData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(orderProvider.errorMessage ??
                              'Order created successfully!'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Price',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${widget.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['name'], style: TextStyle(fontSize: 16)),
                  Text('\$${item['price']} x ${item['quantity']}'),
                ],
              ),
            )),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${widget.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
