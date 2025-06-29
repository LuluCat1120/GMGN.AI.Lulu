import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _inviteController = TextEditingController(text: 'HWH2Woma');

  @override
  void dispose() {
    _emailController.dispose();
    _inviteController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signing Up...')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background from image
      body: Stack(
        children: [
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
                      const SizedBox(height: 40),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: Colors.grey[400]),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                color: Colors.greenAccent[400],
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text('Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.grey[600]),
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
                      TextFormField(
                        controller: _inviteController,
                        readOnly: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The invite code cannot be changed after binding. Please ensure the correct invite code is entered.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent[400],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                      const SizedBox(height: 32),
                      _buildDivider(),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialButton(Icons.telegram, 'Telegram'),
                          _buildSocialButton(Icons.bubble_chart, 'Phantom',
                              color: Colors.purpleAccent),
                        ],
                      ),
                      const SizedBox(height: 40),
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
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
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
          child: Text('OR Sign Up', style: TextStyle(color: Colors.grey[600])),
        ),
        Expanded(child: Divider(color: Colors.grey[800])),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label,
      {Color color = Colors.blue}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[850],
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
} 