import 'package:flutter/material.dart';

import 'package:rentalz/components/components.dart';
import 'package:rentalz/models/models.dart';

class AuthorNoteTile extends StatelessWidget {
  final Note note;

  const AuthorNoteTile({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const AuthorCard(
          authorName: 'Khang',
          title: 'App Developer',
          imageProvider: AssetImage('assets/profile_pics/khang_dark.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.comment),
              Text(
                '${note.timestamp} mins ago',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
