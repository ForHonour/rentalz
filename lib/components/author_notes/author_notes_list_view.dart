import 'package:flutter/material.dart';

import 'package:rentalz/components/components.dart';
import 'package:rentalz/models/models.dart';

class AuthorNoteListView extends StatelessWidget {
  final List<Note> authorNotes;

  const AuthorNoteListView({
    Key? key,
    required this.authorNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          ListView.separated(
              primary: false,
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: authorNotes.length,
              itemBuilder: (context, index) {
                final note = authorNotes[index];
                return AuthorNoteTile(note: note);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
