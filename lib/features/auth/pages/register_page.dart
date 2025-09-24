import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/auth/auth_model.dart';
import '../managers/authlogin_view_model.dart';
import '../widgets/medi_button_widget.dart';
import '../widgets/register_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final storage = FlutterSecureStorage();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool? isFullnameValid;
  bool? isEmailValid;
  bool? isPasswordValid;

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      isFullnameValid = fullnameController.text.trim().isNotEmpty;
      isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+')
          .hasMatch(emailController.text.trim());
      isPasswordValid = passwordController.text.trim().length >= 6 &&
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
              .hasMatch(passwordController.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthVM>(); // Access AuthVM

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Let’s create your account.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF808080),
                  ),
                ),
                const SizedBox(height: 32),
        
                // Full Name
                const Text('Full Name'),
                const SizedBox(height: 8),
                RegisterField(
                  onChanged: (value) => _validateInputs(),
                  controller: fullnameController,
                  hintText: "Enter your full name",
                  suffixIcon: isFullnameValid == null
                      ? null
                      : Icon(isFullnameValid! ? Icons.verified : Icons.error),
                  isValid: isFullnameValid,
                ),
                const SizedBox(height: 16),
        
                // Email
                const Text('Email'),
                const SizedBox(height: 8),
                RegisterField(
                  onChanged: (value) => _validateInputs(),
                  controller: emailController,
                  hintText: "Enter your email",
                  suffixIcon: isEmailValid == null
                      ? null
                      : Icon(isEmailValid! ? Icons.verified : Icons.error),
                  isValid: isEmailValid,
                ),
                const SizedBox(height: 16),
        
                // Password
                const Text('Password'),
                const SizedBox(height: 8),
                RegisterField(
                  onChanged: (value) => _validateInputs(),
                  controller: passwordController,
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                    icon: Icon(
                      _isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  isValid: isPasswordValid,
                  obscureText: _isPasswordObscured,
                ),
                const SizedBox(height: 32),
                RichText(
                  text: TextSpan(
                    text: 'By signing up you agree to our',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080),
                    ),
                    children: [
                      TextSpan(
                        text: ' Terms, Privacy Policy',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Cookie Policy',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                authVM.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: (isFullnameValid == true &&
                        isEmailValid == true &&
                        isPasswordValid == true)
                        ? const Color(0xFF1A1A1A)
                        : Colors.grey, // grey when disabled
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: (isFullnameValid == true &&
                      isEmailValid == true &&
                      isPasswordValid == true)
                      ? () async {
                    try {
                      await authVM.fetchRegister(
                        AuthModel(
                          fullName: fullnameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
        
                      if (!mounted) return;
        
                      if (authVM.error != null) {
                        print(authVM.error);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authVM.error!),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registered successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.go("/home");
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registration failed: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                      : null,
        
                  child: const Text(
                    'Create an Account',
                    style: TextStyle(color: Colors.white),
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
                  buttonIcon: const Icon(Icons.g_mobiledata), // Update to Google icon
                ),
                const SizedBox(height: 16),
                MediaButton(
                  buttonText: 'Continue with Facebook',
                  bgColor: Colors.blue,
                  buttonIcon: const Icon(Icons.facebook),
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF808080),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/login'), // Navigate to login
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}