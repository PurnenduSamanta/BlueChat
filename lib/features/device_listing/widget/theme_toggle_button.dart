import 'package:blue_chat/theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeModeController>();
    final isDark = themeController.isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: isDark
                ? const [Color(0xFF0F172A), Color(0xFF334155)]
                : const [Color(0xFFFFE08A), Color(0xFFFFB347)],
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black : Colors.transparent,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Switch.adaptive(
          value: isDark,
          onChanged: (_) => themeController.setThemeMode(),
          activeTrackColor: const Color(0xFF1E293B),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFFFA62B),
        ),
      ),
    );
  }
}
