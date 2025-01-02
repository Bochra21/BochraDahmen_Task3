import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/'); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                    
                      await authProvider.signIn(
                        _emailController.text,
                        _passwordController.text,
                      );

                    
                      context.go('/home');
                    } catch (e) {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign-in failed: ${e.toString()}')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 71, 79, 64),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16), 
              TextButton(
                onPressed: () {
                
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 20, 22, 18),
                  ),
                ),
              ),
              const SizedBox(height: 16), 
              TextButton(
                onPressed: () {
                  context.go('/sign-up'); 
                },
                child: const Text(
                  "Do not have an account? Sign Up",
                  style: TextStyle(
                    color: Color.fromARGB(255, 62, 40, 40), 
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
