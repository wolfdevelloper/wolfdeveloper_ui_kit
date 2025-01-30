import 'package:flutter/material.dart';

class ListOfServices extends StatelessWidget {
  const ListOfServices({super.key, required this.stringList});

  final List<String> stringList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 240,
      child: Card(
        // ... (rest of the card configuration)
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: stringList.length,
            itemBuilder: (context, index) => Text(stringList[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 30),
          ),
        ),
      ),
    );
  }
}
