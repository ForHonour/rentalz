import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rentalz/models/models.dart';

class EmptyPropertyScreen extends StatelessWidget {
  const EmptyPropertyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/rentalz_pics/no-prop.png'),
              ),
            ),

            const Text(
              'Looking for a place to post rental properties?\n'
              'Tap the + button to add them here!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            // MaterialButton(
            //   textColor: Colors.white,
            //   child: const Text('Browse Recipes'),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30.0),
            //   ),
            //   color: Colors.green,
            //   onPressed: () {
            //     Provider.of<TabManager>(context, listen: false).goToRecipes();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
