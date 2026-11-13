// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ExamCardType { selection, result }

class ExamCard extends StatelessWidget {
  final ExamCardType type;

  final String image;

  // choose exam level
  final String level;
  final int questionCount;
  final int duration;
  final double? fromMark;
  final double? toMark;

  // exam result
  final int? correctAnswers;
  final int? timeTaken;

  final VoidCallback? onTap;

  const ExamCard({
    super.key,
    required this.type,
    required this.level,
    required this.questionCount,
    required this.duration,
    required this.image,
    this.fromMark,
    this.toMark,
    this.correctAnswers,
    this.timeTaken,
    this.onTap,
  });

  bool get isResult => type == ExamCardType.result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                width: 76,
                height: 76,
                fit: BoxFit.contain,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            level,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '$duration Minutes',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '$questionCount Questions',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (isResult)
                      Text(
                        '$correctAnswers corrected answers in $timeTaken min.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Text(
                        'From: ${fromMark?.toStringAsFixed(2)}   '
                        'To: ${toMark?.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
