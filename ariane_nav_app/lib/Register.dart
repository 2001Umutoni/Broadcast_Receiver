import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService; // Accept AuthService instance

  SignUpScreen({required this.authService}); // Modify the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign Up Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Color(0xFFDEB887),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await authService.signUpWithEmailAndPassword(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (result != null) {
                    // Navigate to home screen or show success message
                  } else {
                    // Show error message
                  }
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final result = await authService.signInWithGoogle();
                  if (result != null) {
                    // Navigate to home screen or show success message
                  } else {
                    // Show error message
                  }
                },
                child: Text('Sign Up with Google'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final result = await authService.signInWithFacebook();
                  if (result != null) {
                    // Navigate to home screen or show success message
                  } else {
                    // Show error message
                  }
                },
                child: Text('Sign Up with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
