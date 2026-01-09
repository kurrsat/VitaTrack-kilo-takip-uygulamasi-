import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({this.label, super.key});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (label != null) ...[
            const SizedBox(height: 12),
            Text(label!, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
