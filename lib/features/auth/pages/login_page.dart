import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_app/features/auth/widgets/register_widgets.dart';
import '../../../data/models/auth/auth_model.dart';
import '../managers/auth_view_model.dart';
import '../widgets/medi_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  void _validateInputs() {
    setState(() {
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim());
      _isPasswordValid = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
      ).hasMatch(passwordController.text.trim());
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthVM>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'It’s great to see you again.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 32),

              // Email field
              RegisterField(
                hintText: 'Enter your email',
                controller: emailController,
                isValid: _isEmailValid,
                onChanged: (_) => _validateInputs(),
                suffixIcon: _isEmailValid
                    ? const Icon(Icons.verified, color: Colors.green)
                    : const Icon(Icons.error, color: Colors.red),
              ),
              const SizedBox(height: 16),

              // Password field
              RegisterField(
                hintText: 'Enter your password',
                controller: passwordController,
                isValid: _isPasswordValid,
                obscureText: _isPasswordObscured,
                onChanged: (_) => _validateInputs(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              RichText(
                text: const TextSpan(
                  text: 'Forgot password?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A1A1A),
                  ),
                  children: [
                    TextSpan(
                      text: ' Reset your password',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Login button
              authVM.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: (_isPasswordValid && _isEmailValid)
                      ? const Color(0xFF1A1A1A)
                      : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 180),
                ),
                onPressed: (_isPasswordValid && _isEmailValid)
                    ? () async {
                  try {
                    await authVM.fetchLogin(
                      AuthModel(
                        fullName: null,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                    if (authVM.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login failed: ${authVM.error}"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (authVM.user != null) {
                      print(authVM.user.toString());
                      context.go('/onboarding_main');
                    }
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Login failed: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
                    : null,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Divider(thickness: 1, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text('Or', style: TextStyle(color: Colors.grey[500])),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Divider(thickness: 1, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MediaButton(
                buttonText: 'Continue with Google',
                bgColor: Colors.white,
                buttonIcon: const Icon(Icons.g_mobiledata),
              ),
              const SizedBox(height: 16),
              MediaButton(
                buttonText: 'Continue with Facebook',
                bgColor: Colors.blue,
                buttonIcon: const Icon(Icons.facebook),
              ),
              const SizedBox(height: 36),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF808080),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A1A),
                        ),
                      ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}