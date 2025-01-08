import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

extension ContextExtensions on BuildContext {
  // Show snackbar
  void showSnackBar(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 2),
    bool isError = false,
  }) {
    var snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isError ? title ?? 'Error' : 'Success',
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      backgroundColor: isError ? AppColors.alert : AppColors.success,
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
