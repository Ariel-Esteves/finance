import 'package:flutter/material.dart';

class Snacks {
  static SnackBar success() {
    return SnackBar(
      content: const Center(
        child: Icon(Icons.check_circle, color: Colors.green, size: 64),
      ),
      backgroundColor: Colors.transparent,
      elevation: 1,
      behavior: SnackBarBehavior.floating,
    );
  }

  static SnackBar fail() {
    return SnackBar(
      content: const Center(
        child: Icon(Icons.error, color: Colors.red, size: 32),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );
  }

  static SnackBar info() {
    return SnackBar(
      content: const Center(
        child: Icon(Icons.info, color: Colors.blue, size: 32),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );
  }
}
