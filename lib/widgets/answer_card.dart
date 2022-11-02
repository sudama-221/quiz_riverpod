import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app/conponents/boxshadow.dart';
import 'package:quiz_app/widgets/circular_icon.dart';

class AnswerCard extends ConsumerWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrected;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;
  const AnswerCard({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrected,
    required this.isDisplayingAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow,
            border: Border.all(
                color: isDisplayingAnswer
                    ? isCorrected
                        ? Colors.green
                        : isSelected
                            ? Colors.red
                            : Colors.white
                    : Colors.white),
            borderRadius: BorderRadius.circular(100.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: isDisplayingAnswer && isCorrected
                        ? FontWeight.bold
                        : FontWeight.w400),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrected
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.grey,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
