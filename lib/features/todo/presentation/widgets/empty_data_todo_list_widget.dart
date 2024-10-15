import 'package:flutter/material.dart';

class EmptyDataTodoListWidget extends StatelessWidget {
  const EmptyDataTodoListWidget({
    super.key,
    this.color,
    this.onClickListener,
    this.message = ' ',
  });
  final String message;
  final Color? color;
  final void Function()? onClickListener;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClickListener != null) {
          onClickListener!();
        }
      },
      child: const Center(
        child: SingleChildScrollView(
          child: Opacity(
            opacity: 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('empty')],
            ),
          ),
        ),
      ),
    );
  }
}
