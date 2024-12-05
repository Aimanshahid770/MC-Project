

import 'package:flutter/material.dart';
import 'package:readify/screens/auth_service.dart';
import 'login_page.dart'; // Import the LoginPage

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = AuthService();

//controllers
final _name = TextEditingController();
final _email =TextEditingController();
final _password=  TextEditingController();





  final _formKey = GlobalKey<FormState>();
  bool agreeToTerms = false;
  bool accountCreated = false; // Track if account creation is successful
  bool _passwordVisible = false; // Password visibility toggle for password
  bool _confirmPasswordVisible = false; // Password visibility toggle for confirm password

  @override

void dispose(){
super.dispose();
_name.dispose();
_email.dispose();
_password.dispose();
} 
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text
                const Center(
                  child: Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                // Logo or Image
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/signupimg.png', // Replace with the correct image path
                    height: 210,
                    width: 210,
                  ),
                ),
                const SizedBox(height: 20),

                if (!accountCreated) ...[
                  // Full Name Field
                   TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Address Field
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field with Visibility Toggle
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: 'Password',
                      hintText: 'Create a password',
                      prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'(?=.*?[#?!@\$%^&*-])').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field with Visibility Toggle
                  TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: !_confirmPasswordVisible,
                    validator: (value) {
                      // Logic to match with the password field should be added
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      // Replace with your password field's value for matching
                      if (value != _password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Checkbox(
                            value: agreeToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                agreeToTerms = value ?? false;
                              });
                            },
                          );
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the Terms & Conditions',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (!agreeToTerms)
                    const Text(
                      'You must agree to the Terms & Conditions',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),

                  // Sign-Up Button
                  Center(
                    child: ElevatedButton(
                       onPressed: () {
  if (_formKey.currentState!.validate() && agreeToTerms) {
    _signup();
  } else {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the Terms & Conditions')),
      );
    }
  }
},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signup() async {
  try {
    final user = await _auth.createUserWithEmailAndPassword(
      _email.text,
      _password.text,
    );
    if (user != null) {
      print("User added successfully");
      setState(() {
        accountCreated = true;
      });

      // Navigate to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  } catch (e) {
    print("Error: $e");
    // Show error to the user (optional)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to create account: $e')),
    );
  }
}

   
}
