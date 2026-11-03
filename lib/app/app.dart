import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/nova_theme.dart';

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nova',
      debugShowCheckedModeBanner: false,
      theme: NovaTheme.darkTheme,
      routerConfig: NovaRouter.router,
    );
  }
}