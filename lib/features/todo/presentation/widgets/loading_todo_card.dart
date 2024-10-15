import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTodoCard extends StatefulWidget {
  const LoadingTodoCard({super.key});

  @override
  State<LoadingTodoCard> createState() => _LoadingTodoCardState();
}

class _LoadingTodoCardState extends State<LoadingTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.withOpacity(0.6),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
