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

                if (state is PaymentLoading)
                  const Center(child: CircularProgressIndicator()),

                if (state is PaymentError)
                  Center(child: Text(state.errorMessage as String)),

                if (state is PaymentLoaded)
                  state.cards.isEmpty
                      ? const Center(
                    child: Text(
                      "No cards available. Add a new card.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                      : Expanded(
                    child: ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        final card = state.cards[index];
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
                                Radio<int>(
                                  value: card.id,
                                  groupValue: state.selectedCardId,
                                  onChanged: (val) {
                                    context
                                        .read<PaymentBloc>()
                                        .add(SelectCardEvent(val!));
                                  },
                                  activeColor: Colors.blue,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<PaymentBloc>()
                                        .add(DeleteCardEvent(card.id));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 20),

                // Add New Card button
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

                // Apply button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is PaymentLoaded &&
                        state.cards.isNotEmpty &&
                        state.selectedCardId != null
                        ? () {
                      final selectedCard = state.cards.firstWhere(
                            (card) => card.id == state.selectedCardId,
                      );
                      context.pop(selectedCard); // Return selected card
                    }
                        : null, // Disable button if no card is selected or no cards
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