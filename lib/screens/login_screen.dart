import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/page_transition.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  Future<void> login() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );
      return;
    }

    try {
      await authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageTransition.createRoute(
          const DashboardScreen(),
        ),
      );
    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50),
              Color(0xFFF5F7FA),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Hero(
                    tag: "fitnessLogo",
                    child: Container(
                      padding:
                          const EdgeInsets.all(20),
                      decoration:
                          const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 80,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Login Your Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 8,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                              20),
                      child: Column(
                        children: [
                          TextField(
                            controller:
                                emailController,
                            decoration:
                                const InputDecoration(
                              labelText: "Email",
                              prefixIcon:
                                  Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(
                              height: 20),
                          TextField(
                            controller:
                                passwordController,
                            obscureText: true,
                            decoration:
                                const InputDecoration(
                              labelText:
                                  "Password",
                              prefixIcon:
                                  Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(
                              height: 30),
                          ElevatedButton.icon(
                            onPressed: login,
                            icon: const Icon(
                                Icons.login),
                            label: const Text(
                                "Login"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition
                            .createRoute(
                          const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Create Account",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
