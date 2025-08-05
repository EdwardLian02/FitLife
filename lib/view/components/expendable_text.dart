import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({super.key, required this.text, this.maxLines = 2});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: isExpanded ? null : widget.maxLines,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            if (isOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "See Less" : "See More...",
                  style: const TextStyle(
                      color: AppTheme.primaryColor, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }
}
