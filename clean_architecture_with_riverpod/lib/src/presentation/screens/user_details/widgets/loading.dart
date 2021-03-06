import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        color: Colors.purple,
      ),
    );
  }
}