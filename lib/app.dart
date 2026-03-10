import 'package:blue_chat/theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/chat/view_model/chat_view_model.dart';
import 'features/device_listing/view/device_listing_screen.dart';
import 'features/device_listing/view_model/device_listing_view_model.dart';
import 'theme/app_theme.dart';

class BlueChatApp extends StatelessWidget {
  const BlueChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceListingViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(
          create: (_) => ThemeModeController()..loadThemeMode(),
        ),
      ],
      child: Consumer<ThemeModeController>(
        builder:
            (BuildContext context, ThemeModeController value, Widget? child) {
              return MaterialApp(
                title: 'Blue Chat',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: value.themeMode,
                home: const DeviceListingScreen(),
              );
            },
      ),
    );
  }
}
