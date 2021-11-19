import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/components/author_card.dart';
import 'package:flutter/services.dart';

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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                child: const Text('Ring & Vibrate Demo'),
                onPressed: () => showAlert(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
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

  void showAlert(BuildContext context) {
    final bellring = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer(),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 145,
          child: Column(
            children: [
              ElevatedButton(
                child: const Text("Ring"),
                onPressed: () {
                  bellring.fixedPlayer!.stop();
                  bellring.play(
                    'assets/audio/bell_ring.mp3',
                  );
                  SystemSound.play(SystemSoundType.click);
                },
              ),
              ElevatedButton(
                child: const Text('Vibrate'),
                onPressed: () => HapticFeedback.mediumImpact(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('OK'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
