import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            Icon(icon,size:40),

            const SizedBox(height:10),

            Text(
              title,
              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize:22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}