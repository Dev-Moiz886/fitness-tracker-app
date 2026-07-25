import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  Future<void> addActivity({
    required String exerciseType,
    required int duration,
    required int calories,
    required int steps,
  }) async {
    String uid =
        FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('activities')
        .add({
      'exerciseType': exerciseType,
      'duration': duration,
      'calories': calories,
      'steps': steps,
      'date': Timestamp.now(),
    });
  }
  Stream<QuerySnapshot> getActivities() {
    String uid =
        FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('activities')
        .orderBy('date', descending: true)
        .snapshots();
  }
  Future<Map<String, int>> getSummary() async {
  String uid =
      FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot snapshot =
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('activities')
          .get();
  int totalSteps = 0;
  int totalCalories = 0;
  int totalDuration = 0;
  for (var doc in snapshot.docs) {
    final data =
        doc.data() as Map<String, dynamic>;
    totalSteps +=
        (data['steps'] ?? 0) as int;
    totalCalories +=
        (data['calories'] ?? 0) as int;
    totalDuration +=
        (data['duration'] ?? 0) as int;
  }
  return {
    'steps': totalSteps,
    'calories': totalCalories,
    'duration': totalDuration,
    'activities': snapshot.docs.length,
  };
}
}
