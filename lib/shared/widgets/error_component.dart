import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String message;
  final Function()? onRetry;

  const ErrorComponent({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('重试'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
