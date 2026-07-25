import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../services/firestore_service.dart';
import '../utils/page_transition.dart';

import 'add_activity_screen.dart';
import 'history_screen.dart';
import 'progress_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  final FirestoreService firestoreService =
      FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Fitness Tracker"),
        actions: [

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {

              await FirebaseAuth.instance
                  .signOut();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                PageTransition.createRoute(
                  const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<Map<String, int>>(
        future:
            firestoreService.getSummary(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          final steps =
              data['steps'] ?? 0;

          final progress =
              (steps / 10000)
                  .clamp(0.0, 1.0);

          return RefreshIndicator(

            onRefresh: () async {
              setState(() {});
            },

            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(),

              padding:
                  const EdgeInsets.all(16),

              child: Column(
                children: [

                  Hero(
                    tag: "fitnessLogo",

                    child: Container(
                      width: double.infinity,

                      padding:
                          const EdgeInsets.all(
                              20),

                      decoration:
                          BoxDecoration(
                        gradient:
                            const LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.teal,
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),

                      child: const Column(
                        children: [

                          Icon(
                            Icons
                                .fitness_center,
                            color:
                                Colors.white,
                            size: 60,
                          ),

                          SizedBox(
                              height: 10),

                          Text(
                            "Fitness Tracker",
                            style:
                                TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 26,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          SizedBox(
                              height: 5),

                          Text(
                            "Stay Active • Stay Healthy",
                            style:
                                TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  CircularPercentIndicator(
                    radius: 90,
                    lineWidth: 12,
                    percent: progress,
                    animation: true,
                    animationDuration: 1500,
                    center: Text(
                      "$steps\nSteps",
                      textAlign:
                          TextAlign.center,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    progressColor:
                        Colors.green,
                    backgroundColor:
                        Colors.grey.shade300,
                  ),

                  const SizedBox(
                      height: 25),

                  Row(
                    children: [

                      Expanded(
                        child: _buildCard(
                          Colors.green.shade100,
                          Icons
                              .directions_walk,
                          "${data['steps']}",
                          "Steps",
                        ),
                      ),

                      const SizedBox(
                          width: 10),

                      Expanded(
                        child: _buildCard(
                          Colors.orange.shade100,
                          Icons
                              .local_fire_department,
                          "${data['calories']}",
                          "Calories",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 10),

                  Row(
                    children: [

                      Expanded(
                        child: _buildCard(
                          Colors.blue.shade100,
                          Icons.timer,
                          "${data['duration']}",
                          "Minutes",
                        ),
                      ),

                      const SizedBox(
                          width: 10),

                      Expanded(
                        child: _buildCard(
                          Colors.purple.shade100,
                          Icons
                              .fitness_center,
                          "${data['activities']}",
                          "Activities",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 25),

                  ElevatedButton.icon(
                    icon:
                        const Icon(Icons.add),

                    label: const Text(
                        "Add Activity"),

                    onPressed: () {

                      Navigator.push(
                        context,
                        PageTransition
                            .createRoute(
                          const AddActivityScreen(),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                  ),

                  const SizedBox(
                      height: 10),

                  ElevatedButton.icon(
                    icon: const Icon(
                        Icons.history),

                    label: const Text(
                        "View History"),

                    onPressed: () {

                      Navigator.push(
                        context,
                        PageTransition
                            .createRoute(
                          HistoryScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                      height: 10),

                  ElevatedButton.icon(
                    icon: const Icon(
                        Icons.bar_chart),

                    label: const Text(
                        "View Progress"),

                    onPressed: () {

                      Navigator.push(
                        context,
                        PageTransition
                            .createRoute(
                          const ProgressScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
    Color color,
    IconData icon,
    String value,
    String label,
  ) {
    return Card(
      color: color,

      child: Padding(
        padding:
            const EdgeInsets.all(15),

        child: Column(
          children: [

            Icon(
              icon,
              size: 40,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(label),
          ],
        ),
      ),
    );
  }
}