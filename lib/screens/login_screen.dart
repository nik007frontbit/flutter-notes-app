import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 48, color: Colors.blueAccent),
                  const SizedBox(height: 16),
                  Text('Welcome Back', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text('Login to your account', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar('Validation Error', 'Email and password are required',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white);
                          return;
                        }

                        authController.login(email, password);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Get.toNamed('/signup'),
                    child: const Text("Don't have an account? Sign Up"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
