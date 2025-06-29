import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar and navigate.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging In...')),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40), // Space for close button
                      // Header
                      const Text(
                        'Log In',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: 'Don\'t have an account yet? ',
                          style: TextStyle(color: Colors.grey[400]),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.greenAccent[400],
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email Field
                      const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Password Field
                      const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[600]),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent[400],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Log In', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      const SizedBox(height: 32),

                      // Divider
                      _buildDivider(),
                      const SizedBox(height: 32),

                      // Social Logins
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialButton(Icons.telegram, 'Telegram'),
                          _buildSocialButton(Icons.bubble_chart, 'Phantom', color: Colors.purpleAccent), // Placeholder icon
                          _buildSocialButton(Icons.fullscreen, 'APP Scan'),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      // Connect with Extension
                      const Center(child: Text('Connect with extension wallet →', style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(height: 24),

                      // Footer
                       Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: Colors.grey[600]),
                            children: [
                              const TextSpan(text: '  |  '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30),
              onPressed: () {
                // Close action
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[800])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('OR', style: TextStyle(color: Colors.grey[600])),
        ),
        Expanded(child: Divider(color: Colors.grey[800])),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, {Color color = Colors.blue}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[850],
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
} 