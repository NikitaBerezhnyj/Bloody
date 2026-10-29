import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final List<Widget> children;

  const DetailCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children:
              children
                  .expand((w) => [w, const Divider(height: 1, indent: 56)])
                  .toList()
                ..removeLast(),
        ),
      ),
    );
  }
}
