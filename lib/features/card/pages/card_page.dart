import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/address/adres_model.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../cart/managers/cart_bloc.dart';
import '../../cart/managers/cart_event.dart';
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
  final TextEditingController promoController = TextEditingController();
  late AddressModel selectedAddress;
  String selectedPayment = 'Card';
  int? selectedCardId;

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
        nickname: "Home",
        fullAddress: "No address selected",
        isDefault: false,
        lat: 0,
        lng: 0,
      );
    }
  }

  void _showAddCardDialog() {
    context.go('/addCard');
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
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state.status == CartStatus.orderSuccess) {
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
                          fontSize: 18,
                        ),
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
                        context.go('/home');
                      },
                      child: const Text('Track your order'),
                    ),
                  ],
                );
              },
            );
          } else if (state.status == CartStatus.orderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to place order'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          selectedAddress.nickname,
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
                      final result = await context.push<AddressModel>(
                        '/address',
                      );
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
              Expanded(
                child: BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: (cards, selectedId) =>
                          const Center(child: CircularProgressIndicator()),
                      error: (errorMessage, cards, selectedId) =>
                          Center(child: Text(errorMessage)),
                      loaded: (cards, selectedId) {
                        if (selectedPayment == 'Card') {
                          if (cards.isEmpty) {
                            return Center(
                              child: TextButton.icon(
                                onPressed: _showAddCardDialog,
                                icon: const Icon(Icons.add),
                                label: const Text("Add Card"),
                              ),
                            );
                          }
                          if (selectedId != null &&
                              selectedCardId != selectedId) {
                            setState(() {
                              selectedCardId = selectedId;
                            });
                          }
                          final selectedCard = selectedId != null
                              ? cards.firstWhere(
                                  (card) => card.id == selectedId,
                                  orElse: () => cards.first,
                                )
                              : cards.first;
                          return ListView(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.credit_card,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  '**** **** **** ${selectedCard.cardNumber.substring(selectedCard.cardNumber.length - 4)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "Expires: ${selectedCard.expiryDate}",
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
                                        selectedCardId = result.id;
                                        context.read<PaymentBloc>().add(
                                          SelectCardEvent(result.id!),
                                        );
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
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
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              const Divider(height: 32),
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Promo code applied")),
                      );
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed:
                          (selectedPayment == 'Card' &&
                                  selectedCardId == null) ||
                              cartState.status == CartStatus.loading
                          ? null
                          : () {
                              final addressId = selectedAddress.id ?? 0;
                              context.read<CartBloc>().add(
                                PlaceOrder(
                                  addressId: addressId,
                                  paymentMethod: selectedPayment,
                                  cardId: selectedPayment == 'Card'
                                      ? selectedCardId
                                      : null,
                                ),
                              );
                            },
                      child: cartState.status == CartStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Place Order",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
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
            selectedCardId = null;
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
    promoController.dispose();
    super.dispose();
  }
}
