import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

enum BrandedAlertType { info, success, warning, error }

class BrandedAlertAction {
  const BrandedAlertAction({
    required this.label,
    this.isPrimary = false,
    this.isDestructive = false,
    this.closeOnPressed = true,
    this.result,
    this.onPressed,
  });

  final String label;
  final bool isPrimary;
  final bool isDestructive;
  final bool closeOnPressed;
  final Object? result;
  final FutureOr<void> Function(BuildContext context)? onPressed;
}

Future<T?> showBrandedAlertDialog<T>({
  required BuildContext context,
  required String title,
  String? message,
  Widget? content,
  BrandedAlertType type = BrandedAlertType.info,
  List<BrandedAlertAction> actions = const <BrandedAlertAction>[],
  bool barrierDismissible = true,
  bool showCloseButton = false,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return BrandedAlertDialog(
        title: title,
        message: message,
        content: content,
        type: type,
        actions: actions,
        showCloseButton: showCloseButton,
      );
    },
  );
}

class BrandedAlertDialog extends StatelessWidget {
  const BrandedAlertDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.type = BrandedAlertType.info,
    this.actions = const <BrandedAlertAction>[],
    this.showCloseButton = false,
  });

  final String title;
  final String? message;
  final Widget? content;
  final BrandedAlertType type;
  final List<BrandedAlertAction> actions;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final _AlertVisual visual = _visualForType(type, colors);

    final List<BrandedAlertAction> resolvedActions =
        actions.isEmpty ? const <BrandedAlertAction>[BrandedAlertAction(label: 'OK', isPrimary: true)] : actions;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.35)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _TypeBadge(visual: visual),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  if (showCloseButton)
                    IconButton(
                      tooltip: 'Close',
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
              ),
              if (message != null && message!.trim().isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
              if (content != null) ...<Widget>[
                const SizedBox(height: 14),
                content!,
              ],
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 10,
                runSpacing: 8,
                children: resolvedActions
                    .map(
                      (BrandedAlertAction action) => _AlertButton(
                        action: action,
                        onTap: () async {
                          await action.onPressed?.call(context);
                          if (action.closeOnPressed && context.mounted) {
                            Navigator.of(context).pop(action.result);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AlertVisual _visualForType(BrandedAlertType type, ColorScheme colors) {
    return switch (type) {
      BrandedAlertType.info => _AlertVisual(
        icon: Icons.info_rounded,
        gradient: const <Color>[AppColors.brandPrimary, Color(0xFF74A8FF)],
      ),
      BrandedAlertType.success => _AlertVisual(
        icon: Icons.check_circle_rounded,
        gradient: const <Color>[AppColors.brandSecondary, Color(0xFF50D2A8)],
      ),
      BrandedAlertType.warning => _AlertVisual(
        icon: Icons.warning_rounded,
        gradient: const <Color>[AppColors.brandAccent, Color(0xFFFAC66C)],
      ),
      BrandedAlertType.error => _AlertVisual(
        icon: Icons.error_rounded,
        gradient: <Color>[colors.error, const Color(0xFFF87171)],
      ),
    };
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.visual});

  final _AlertVisual visual;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: visual.gradient,
        ),
      ),
      child: Icon(visual.icon, color: Colors.white, size: 24),
    );
  }
}

class _AlertButton extends StatelessWidget {
  const _AlertButton({required this.action, required this.onTap});

  final BrandedAlertAction action;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    if (action.isPrimary) {
      return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: action.isDestructive ? colors.error : colors.primary,
          foregroundColor: action.isDestructive ? colors.onError : colors.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
        onPressed: onTap,
        child: Text(action.label),
      );
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: action.isDestructive ? colors.error : colors.onSurface,
        side: BorderSide(
          color: action.isDestructive ? colors.error.withValues(alpha: 0.5) : colors.outline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      onPressed: onTap,
      child: Text(action.label),
    );
  }
}

class _AlertVisual {
  const _AlertVisual({required this.icon, required this.gradient});

  final IconData icon;
  final List<Color> gradient;
}
