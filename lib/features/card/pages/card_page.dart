import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../../data/models/address/adres_model.dart';
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
  final TextEditingController promoController = TextEditingController();

  late AddressModel selectedAddress;
  String selectedPayment = 'Card';
  CardModel? selectedCard; // Track the selected card

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(LoadCardsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra != null && extra is AddressModel) {
      selectedAddress = extra;
    } else {
      selectedAddress = AddressModel(
        title: "Home",
        fullAddress: "No address selected",
        isDefault: false,
        lat: 0,
        lng: 0,
      );
    }
  }

  void _showAddCardDialog() {
    context.go('/addCard'); // Navigate to add card page
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
            const Text(
              "Delivery Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedAddress.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        selectedAddress.fullAddress,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await context.push<AddressModel>('/address');
                    if (result != null && result is AddressModel) {
                      setState(() {
                        selectedAddress = result;
                      });
                    }
                  },
                  child: const Text("Change"),
                ),
              ],
            ),
            const Divider(height: 32),

            // Payment Method
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
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

            // Cards / Payment info
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
                      // Set default selected card if none is selected
                      if (selectedCard == null && cards.isNotEmpty) {
                        final defaultCardId = state.selectedCardId ?? cards[0].id;
                        selectedCard = cards.firstWhere(
                              (card) => card.id == defaultCardId,
                          orElse: () => cards[0],
                        );
                      }
                      return cards.isNotEmpty && selectedCard != null
                          ? ListView(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'VISA **** **** ${selectedCard!.cardNumber.substring(selectedCard!.cardNumber.length - 4)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "Expires: ${selectedCard!.expiryDate}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                final result = await context
                                    .push<CardModel>('/paymentMethods');
                                if (result != null && result is CardModel) {
                                  setState(() {
                                    selectedCard = result;
                                  });
                                }
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
                      ),
                    );
                  } else if (selectedPayment == 'Apple Pay') {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.phone_iphone,
                            size: 50,
                            color: Colors.green,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Pay quickly with Apple Pay",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
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
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

            const SizedBox(height: 10),
            // Promo Code
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.discount_outlined),
                      hintText: "Enter promo code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    context.go('/paymentMethods');
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: selectedPayment == 'Card' && selectedCard == null
                    ? null 
                    : () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 48,
                        ),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Congratulations!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text('Your order has been placed.'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.go('/address');
                            },
                            child: const Text('Tract your order'),
                          ),
                        ],
                      );
                    },
                  );                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
      onPressed: () {
        setState(() {
          selectedPayment = method;
          if (method != 'Card') {
            selectedCard = null; // Clear selected card for non-card methods
          }
        });
      },
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
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    codeController.dispose();
    promoController.dispose();
    super.dispose();
  }
}