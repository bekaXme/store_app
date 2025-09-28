import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/payment/payment_model.dart';
import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) setState(() => isLoading = true);
        if (state is PaymentLoaded) {
          setState(() => isLoading = false);
          context.go('/paymentMethod'); // Go back after success
        }
        if (state is PaymentError) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage as String)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Add New Card"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Card Number
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    _CardNumberFormatter(),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Card Number",
                    hintText: "#### #### #### ####",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                  val == null || val.length < 19 ? "Enter valid card" : null,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    // Expiry Date
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          _ExpiryDateFormatter(),
                        ],
                        decoration: const InputDecoration(
                          labelText: "Expiry Date",
                          hintText: "MM/YY",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                        val == null || val.length < 5 ? "Invalid expiry" : null,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // CVV
                    Expanded(
                      child: TextFormField(
                        controller: _cvcController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: const InputDecoration(
                          labelText: "CVC",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                        val == null || val.length != 3 ? "Invalid CVC" : null,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        final card = CardModel(
                          id: 0,
                          cardNumber:
                          _cardNumberController.text.replaceAll(" ", ""),
                          expiryDate: _formatExpiryToDate(
                              _expiryController.text),
                          securityCode: _cvcController.text,
                        );
                        context
                            .read<PaymentBloc>()
                            .add(AddCardEvent(card));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.black,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Add Card",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Convert MM/YY -> YYYY-MM-DD
  String _formatExpiryToDate(String expiry) {
    final parts = expiry.split('/');
    final month = parts[0].padLeft(2, '0');
    final year = "20${parts[1]}";
    return "$year-$month-01"; // example: 2025-09-01
  }
}

/// Formatter: #### #### #### ####
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digits.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

/// Formatter: MM/YY
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 2) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
