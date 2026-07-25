import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() =>
      _AddActivityScreenState();
}

class _AddActivityScreenState
    extends State<AddActivityScreen> {

  final typeController =
      TextEditingController();

  final durationController =
      TextEditingController();

  final caloriesController =
      TextEditingController();

  final stepsController =
      TextEditingController();

  final FirestoreService firestoreService =
      FirestoreService();

  Future<void> saveActivity() async {
    try {
      await firestoreService.addActivity(
        exerciseType: typeController.text.trim(),
        duration: int.parse(
            durationController.text),
        calories: int.parse(
            caloriesController.text),
        steps:
            int.parse(stepsController.text),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
              "Activity Saved"),
        ),
      );

      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
              e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Add Activity"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller:
                  typeController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Exercise Type",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
                  durationController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Duration (min)",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
                  caloriesController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Calories",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
                  stepsController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Steps",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed:
                  saveActivity,
              child: const Text(
                  "Save"),
            ),
          ],
        ),
      ),
    );
  }
}