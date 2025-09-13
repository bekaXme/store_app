import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_app/features/auth/widgets/get_otp_widget.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../managers/reset_password_view_model.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  bool get isPasswordValid =>
      passwordController.text.trim().length >= 6; // Example rule

  bool get isPasswordsMatch =>
      passwordController.text.trim() == confirmPasswordController.text.trim();

  void _handleChangePassword() async {
    if (!isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }
    if (!isPasswordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    await context.read<ResetPasswordVM>().fetchChangePassword(
      passwordController.text.trim(),
      confirmPasswordController.text.trim(),
      passwordController.text.trim(),
    );

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 64,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              Text(
                'Password changed!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'You can now use your new password to login to your account.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Login'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/icons/back_arrow.svg',
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Set the new password for your account so you can login and access all the features.',
              style: TextStyle(
                color: Color(0xFF808080),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // Password field
            const Text('Password'),
            const SizedBox(height: 8),
            TextField(
              obscureText: isPasswordObscured,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password field
            const Text('Confirm Password'),
            const SizedBox(height: 8),
            TextField(
              obscureText: isConfirmPasswordObscured,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Re-enter your password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordObscured = !isConfirmPasswordObscured;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: _handleChangePassword,
              child: GetOtpButton(title: 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
