import 'package:flutter/material.dart';
import 'package:rentalz/components/author_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcome to Propery Rental Z App.',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        const AuthorCard(
          authorName: 'Khang',
          title: 'App Developer',
          imageProvider: AssetImage('assets/profile_pics/khang_dark.png'),
        ),
        const SizedBox(height: 72),
        Text(
          'Details',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Expanded(
          child: DetailsCard(),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Copyright © 2021 Khang Nghiem.\nAll rights reserved.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
