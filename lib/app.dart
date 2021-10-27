import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalz/models/managers/property_manager.dart';
import 'package:rentalz/theme/rentalz_theme.dart';

import 'home.dart';
import 'models/managers/tab_manager.dart';

class RentalZ extends StatelessWidget {
  const RentalZ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = RentalZTheme.light();
    // final theme = RentalZTheme.dark();
    return MaterialApp(
      theme: theme,
      title: 'Rental Z',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => PropertyManager())
        ],
        child: const Home(),
      ),
    );
  }
}
