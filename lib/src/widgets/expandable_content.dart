import 'package:flutter/material.dart';

class ExpandableContent extends StatefulWidget {
  const ExpandableContent(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.content});

  final String leftText;
  final String rightText;
  final Widget content;

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        // Adicionei um Card para melhor visualização
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.leftText),
                  Text(widget.rightText),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    size: 16,
                  ),
                ],
              ),
              if (_isExpanded) widget.content, // Exibe o conteúdo se expandido
            ],
          ),
        ),
      ),
    );
  }
}
