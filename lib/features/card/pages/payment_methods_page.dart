import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text("Payment Method"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saved Cards",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                state.maybeWhen(
                  loading: (cards, selectedId) =>
                      const Center(child: CircularProgressIndicator()),
                  error: (errorMessage, cards, selectedId) =>
                      Center(child: Text(errorMessage)),
                  loaded: (cards, selectedId) => cards.isEmpty
                      ? const Center(
                          child: Text(
                            "No cards available. Add a new card.",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              final card = cards[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.credit_card,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    "**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text("Expires: ${card.expiryDate}"),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (card.id != null)
                                        Radio<int>(
                                          value: card.id!,
                                          groupValue: selectedId,
                                          onChanged: (val) {
                                            if (val != null) {
                                              context.read<PaymentBloc>().add(
                                                SelectCardEvent(val),
                                              );
                                            }
                                          },
                                          activeColor: Colors.blue,
                                        ),
                                      if (card.id != null)
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'Delete Card',
                                                ),
                                                content: const Text(
                                                  'Are you sure you want to delete this card?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<PaymentBloc>()
                                                          .add(
                                                            DeleteCardEvent(
                                                              card.id!,
                                                            ),
                                                          );
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      if (card.id == null)
                                        const Text(
                                          'Invalid card',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  orElse: () => const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => context.go('/addCard'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "+ Add New Card",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.maybeWhen(
                      loaded: (cards, selectedId) =>
                          cards.isNotEmpty && selectedId != null
                          ? () {
                              final selectedCard = cards.firstWhere(
                                (card) => card.id == selectedId,
                                orElse: () => cards.first,
                              );
                              if (selectedCard.id != null) {
                                context.pop(selectedCard);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Selected card is invalid'),
                                  ),
                                );
                              }
                            }
                          : null,
                      orElse: () => null,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Apply",
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
      },
    );
  }
}
