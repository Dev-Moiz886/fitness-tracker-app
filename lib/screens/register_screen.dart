import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/page_transition.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  Future<void> register() async {

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

      await authService.register(
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
                    "Create Account",
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
                            onPressed: register,
                            icon: const Icon(
                              Icons.person_add,
                            ),
                            label: const Text(
                              "Register",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Login",
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