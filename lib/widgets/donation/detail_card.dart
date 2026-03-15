import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final List<Widget> children;

  const DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: children
              .expand((w) => [w, const Divider(height: 1, indent: 56)])
              .toList()
            ..removeLast(),
        ),
      ),
    );
  }
}