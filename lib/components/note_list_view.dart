// import 'package:flutter/material.dart';
// import '../models/models.dart';
// import 'components.dart';

// class NoteListView extends StatelessWidget {
//   // 1
//   final List<Note> authorNotes;

//   const NoteListView({
//     Key? key,
//     required this.authorNotes,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 0,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Notes: ', style: Theme.of(context).textTheme.headline2),
//           const SizedBox(height: 16),
//           ListView.separated(
//             // 2
//             primary: false,
//             // 3
//             physics: const NeverScrollableScrollPhysics(),
//             // 4
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: authorNotes.length,
//             itemBuilder: (context, index) {
//               // 5
//               final note = authorNotes[index];
//               return NoteTile(note: note);
//             },
//             separatorBuilder: (context, index) {
//               return const SizedBox(height: 16);
//             },
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }
