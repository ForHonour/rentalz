import 'package:flutter/material.dart';
import 'package:rentalz/components/property_tile.dart';

import 'package:rentalz/models/models.dart';
import '../sql_helper.dart';
import 'property_item_screen.dart';

class PropertyListScreen extends StatelessWidget {
  final PropertyManager manager;

  const PropertyListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertyItems = manager.propertyItems;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final property = propertyItems[index];
            return Dismissible(
              key: Key(property.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
              onDismissed: (direction) async {
                manager.deleteProperty(propertyItems[index].id);
                // await SQLHelper.deleteItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${property.name} dismissed')),
                );
                await SQLHelper.getItems();
              },
              child: InkWell(
                child: PropertyTile(
                  key: Key(property.id),
                  property: property,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeProperty(property, index, change);
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyItemScreen(
                        originalItem: property,
                        onCreate: (property) {},
                        onUpdate: (property) {
                          manager.updateProperty(property, index);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
          itemCount: propertyItems.length),
    );
  }
}
