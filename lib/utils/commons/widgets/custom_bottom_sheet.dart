import 'package:flutter/material.dart';

showCustomBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 400,
        width: 400,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('close'),
        ),
      );
    },
  );
}
