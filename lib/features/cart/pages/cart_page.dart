import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';

import '../managers/cart_bloc.dart';
import '../managers/cart_event.dart';
import '../managers/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/cards'),
            icon: const Icon(Icons.card_giftcard_sharp),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == CartStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Failed to load cart'));
          }
          if (state.cart == null || state.cart!.items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.cart!.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = state.cart!.items[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Title + Size + Price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text("Size ${item.size}",
                                    style: TextStyle(
                                        color: Colors.grey.shade600, fontSize: 14)),
                                const SizedBox(height: 8),
                                Text("\$${item.price}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15)),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<CartBloc>().add(DeleteFromCart(item.id));
                                },
                              ),
                              Row(
                                children: [
                                  _qtyButton("-", () {
                                    context.read<CartBloc>().add(UpdateQuantity(
                                        item.id, item.quantity - 1));
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("${item.quantity}",
                                        style: const TextStyle(fontSize: 16)),
                                  ),
                                  _qtyButton("+", () {
                                    context.read<CartBloc>().add(UpdateQuantity(
                                        item.id, item.quantity + 1));
                                  }),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _summaryRow("Sub-total", "\$${state.cart!.subTotal}"),
                    _summaryRow("VAT (%)", "\$${state.cart!.vat}"),
                    _summaryRow("Shipping fee", "\$${state.cart!.shippingFee}"),
                    const Divider(),
                    _summaryRow("Total", "\$${state.cart!.total}",
                        isBold: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          context.go('/cards');
                        },
                        child: const Text(
                          "Go To Checkout →",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );
  }

  Widget _qtyButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _summaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
