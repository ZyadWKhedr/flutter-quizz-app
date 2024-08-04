import 'package:flutter/material.dart';
import 'package:quiz_app_working/constants.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    super.key,
    required this.option,
    required this.isClicked,
    required this.color,
    required this.onTap,
  });

  final String option;
  final bool? isClicked;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: isClicked == null ? neutral : color,
          child: ListTile(
            title: Text(
              option,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
