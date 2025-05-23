// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news/src/features/news/views/newsPage.dart';
import 'package:my_news/src/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/constant.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  static const Map<String, String> _dummyAccounts = {
    'mohit@gmail.com': 'password',
    'alice@example.com': 'password123',
    'bob@example.com': 'qwerty',
  };

  Future<void> _login() async {
    setState(() => _error = null);
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final pwd = _passwordController.text;
      if (_dummyAccounts[email] == pwd) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        setState(() => _error = 'Invalid credentials');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('NewsPulse', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              const SizedBox(height: 16),
              const Text('Login to continue', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 32),
              if (_error != null) ...[
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: commonBorder(),
                    focusedBorder: commonBorder(),
                    disabledBorder: commonBorder(),
                    errorBorder: commonBorder(),
                    focusedErrorBorder: commonBorder(),
                    hintText: "Enter email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email is required';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: commonBorder(),
                    focusedBorder: commonBorder(),
                    disabledBorder: commonBorder(),
                    errorBorder: commonBorder(),
                    focusedErrorBorder: commonBorder(),
                    hintText: "Enter password"),                validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- radius here
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size.fromHeight(48)),
                child: const Text('Login' ,style: TextStyle(color: Colors.white ,fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
