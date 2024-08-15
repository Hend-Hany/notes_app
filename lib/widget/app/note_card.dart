import 'dart:math';
import 'package:flutter/material.dart';
import 'package:note_app/core/dimentions.dart';
import 'package:note_app/core/route_utils/utils.dart';
import 'package:note_app/modules/note.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/widget/app/app_colors.dart';
import 'package:note_app/widget/app/app_text.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note, this.onDismiss, this.onTap})
      : super(key: key);

  final Note note;
  final void Function()? onDismiss;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        if (onDismiss != null) {
          onDismiss!();
        }
        ;
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 24.height),
        width: double.infinity,
        alignment: Alignment.center,
        child: Icon(FontAwesomeIcons.trash),
        decoration: BoxDecoration(
            color: AppColors.red, borderRadius: BorderRadius.circular(12)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.height),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 12.width, vertical: 12.height),
            width: double.infinity,
            alignment: Alignment.center,
            child: AppText(
              title: note.title,
              color: AppColors.black,
              fontSize: 24,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Utils
                    .noteColors[Random().nextInt(Utils.noteColors.length - 1)]),
          ),
        ),
      ),
    );
  }
}
