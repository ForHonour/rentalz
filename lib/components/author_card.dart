import 'package:flutter/material.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 100,
          child: CircleAvatar(
            radius: 100 - 5,
            backgroundImage: widget.imageProvider,
          ),
        ),
        const SizedBox(height: 4.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.authorName,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ],
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(border: Border.all(width: 2.0)),
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Flutter Developer',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Name: Khang Nghiem',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          'Hobby: Flutter Enthusiast',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
