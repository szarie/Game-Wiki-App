import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String validUsername = 'adminzzz';
  final String validPassword = '123';

  //bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //_checkSavedCredentials();
  }

  // Future<void> _checkSavedCredentials() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedUsername = prefs.getString('username');
  //   final savedPassword = prefs.getString('password');

  //   if (savedUsername != null && savedPassword != null) {
  //     setState(() {
  //       _usernameController.text = savedUsername;
  //       _passwordController.text = savedPassword;
  //       _rememberMe = true;
  //     });

  //     // Optional: Auto-login if credentials are saved
  //     // _handleLogin();
  //   }
  // }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 1));

      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      if (username == validUsername && password == validPassword) {
        // Save credentials if "Remember Me" is checked
        // if (_rememberMe) {
        //   final prefs = await SharedPreferences.getInstance();
        //   await prefs.setString('username', username);
        //   await prefs.setString('password', password);
        // }

        // Navigate to home screen using named route
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // Show error dialog
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.grey[850],
            title: Text('Access Denied', style: TextStyle(color: Colors.white)),
            content: Text('Invalid username or password.',
                style: TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                child: Text('Try Again',
                    style: TextStyle(color: Colors.yellowAccent)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSignUpDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        content: Text('Feature coming soon!',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            child: Text('OK', style: TextStyle(color: Colors.yellowAccent)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Card(
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.security, size: 80, color: Colors.yellowAccent),
                    const SizedBox(height: 20),
                    Text('Agent Login',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.yellowAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Field cannot be empty.'
                                    : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.yellowAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Field cannot be empty.'
                                    : null,
                          ),
                          const SizedBox(height: 10),

                          // Remember Me checkbox
                          // Row(
                          //   children: [
                          //     Checkbox(
                          //       value: _rememberMe,
                          //       onChanged: (bool? value) {
                          //         setState(() {
                          //           _rememberMe = value ?? false;
                          //         });
                          //       },
                          //       activeColor: Colors.yellowAccent,
                          //       checkColor: Colors.black,
                          //     ),
                          //     Text('Remember Me',
                          //         style: TextStyle(color: Colors.white70)),
                          //   ],
                          // ),

                          const SizedBox(height: 20),

                          // Login button
                          _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.yellowAccent)
                              : ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    backgroundColor: Colors.yellowAccent,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _handleLogin,
                                  icon: Icon(Icons.login),
                                  label: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                          const SizedBox(height: 15),

                          // Sign up button
                          TextButton(
                            onPressed: _showSignUpDialog,
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 16)),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              // Navigate directly to home for testing
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            child: Text('Skip Login (Testing)',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
