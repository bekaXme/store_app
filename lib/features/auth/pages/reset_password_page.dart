import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_app/features/auth/widgets/register_widgets.dart';

import '../managers/reset_password_view_model.dart';
import '../widgets/get_otp_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controller = TextEditingController();
  bool? isValid;

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void _validateInputs() {
    isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SvgPicture.asset('assets/icons/back_arrow.svg')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot password',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter your email for the verification process. We will send 4 digits code to your email.',
              style: TextStyle(
                color: Color(0xFF808080),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            RegisterField(
              hintText: 'Email',
              isValid: isValid,
              controller: controller,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                context.read<ResetPasswordVM>().fetchResetPassword(
                  controller.text.trim(),
                );
                context.go('/get_otp', extra: controller.text.trim());
              },
              child: GetOtpButton(),
            )
          ],
        ),
      ),
    );
  }
}

