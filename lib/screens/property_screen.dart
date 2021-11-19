import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'empty_property_screen.dart';
import 'property_item_screen.dart';
import 'package:rentalz/models/models.dart';
import 'property_list_screen.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<PropertyManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return PropertyItemScreen(
                  onCreate: (property) {
                    manager.addProperty(property);
                    Navigator.pop(context);
                  },
                  onUpdate: (property) {});
            }),
          );
        },
      ),
      body: buildPropertyScreen(),
    );
  }

  Widget buildPropertyScreen() {
    return Consumer<PropertyManager>(
      builder: (BuildContext context, manager, Widget? child) {
        manager.refreshProperties();

        if (manager.propertyItems.isNotEmpty && !manager.isLoading) {
          return PropertyListScreen(manager: manager);
        } else {
          return const EmptyPropertyScreen();
        }
      },
    );
  }
}
