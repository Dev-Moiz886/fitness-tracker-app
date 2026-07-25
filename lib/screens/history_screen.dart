import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final FirestoreService firestoreService =
      FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity History"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getActivities(),
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No activities added yet",
              ),
            );
          }

          final activities =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {

              final data =
                  activities[index].data()
                      as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(
                    Icons.fitness_center,
                  ),
                  title: Text(
                    data['exerciseType'],
                  ),
                  subtitle: Text(
                    "Duration: ${data['duration']} min\n"
                    "Calories: ${data['calories']}\n"
                    "Steps: ${data['steps']}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}