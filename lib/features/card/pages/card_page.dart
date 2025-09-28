import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../cart/managers/cart_bloc.dart';
import '../../cart/managers/cart_state.dart';
import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  String selectedPayment = 'Card';

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(LoadCardsEvent());
  }

  void _showAddCardDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Card'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: expiryController,
              decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Security Code'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final cardNumber = cardNumberController.text.trim();
              final expiryDate = expiryController.text.trim();
              final securityCode = codeController.text.trim();

              if (cardNumber.isEmpty || expiryDate.isEmpty || securityCode.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              final card = CardModel(
                id: 0,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                securityCode: securityCode,
              );
              context.read<PaymentBloc>().add(AddCardEvent(card));
              Navigator.pop(context);
              cardNumberController.clear();
              expiryController.clear();
              codeController.clear();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            const Text("Delivery Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Home",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Text("925 S Chugach St #APT 10, Alaska 99645",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text("Change")),
              ],
            ),
            const Divider(height: 32),

            const Text("Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Row(
              children: [
                _paymentButton('Card'),
                const SizedBox(width: 10),
                _paymentButton('Cash'),
                const SizedBox(width: 10),
                _paymentButton('Apple Pay'),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  if (selectedPayment == 'Card') {
                    if (state is PaymentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PaymentError) {
                      return Center(child: Text(state.errorMessage as String));
                    } else if (state is PaymentLoaded) {
                      final cards = state.cards;
                      return cards.isNotEmpty
                          ? ListView(
                        children: [
                          ListTile(
                            leading:
                            const Icon(Icons.credit_card, color: Colors.blue),
                            title: Text(
                              'VISA **** **** ${cards.first.cardNumber.substring(cards.first.cardNumber.length - 4)}',
                              style:
                              const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text("Expires: ${cards.first.expiryDate}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.grey),
                              onPressed: (){
                                context.go('/paymentMethods');
                              },
                            ),
                          ),
                        ],
                      )
                          : Center(
                        child: TextButton.icon(
                          onPressed: _showAddCardDialog,
                          icon: const Icon(Icons.add),
                          label: const Text("Add Card"),
                        ),
                      );
                    }
                  } else if (selectedPayment == 'Cash') {
                    return const Center(
                        child: Text(
                          "Pay with cash upon delivery",
                          style: TextStyle(fontSize: 16),
                        ));
                  } else if (selectedPayment == 'Apple Pay') {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.phone_iphone, size: 50, color: Colors.green),
                            SizedBox(height: 10),
                            Text("Pay quickly with Apple Pay", style: TextStyle(fontSize: 16)),
                          ],
                        ));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            const Divider(height: 32),

            // Order Summary
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                if (cartState.cart == null) {
                  return const Text("Cart is empty");
                }
                final cart = cartState.cart!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Order Summary",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    _summaryRow("Sub-total", "\$${cart.subTotal}"),
                    _summaryRow("VAT", "\$${cart.vat}"),
                    _summaryRow("Shipping fee", "\$${cart.shippingFee}"),
                    const Divider(),
                    _summaryRow("Total", "\$${cart.total}", bold: true),
                  ],
                );
              },
            ),


            // Promo code
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.discount_outlined),
                      hintText: "Enter promo code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, child: const Text("Add")),
              ],
            ),
            const Spacer(),

            // Place Order button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Text(
                  "Place Order",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentButton(String method) {
    final bool isSelected = selectedPayment == method;
    return TextButton(
      onPressed: () => setState(() => selectedPayment = method),
      child: Text(
        method,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.grey[300],
      ),
    );
  }

  Widget _summaryRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    codeController.dispose();
    super.dispose();
  }
}
