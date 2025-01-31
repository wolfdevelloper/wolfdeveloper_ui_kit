import 'package:flutter/material.dart';

class TimeComponent extends StatelessWidget {
  const TimeComponent({super.key, required this.times});

  final List<String> times;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Espaçamento horizontal entre os itens
      runSpacing: 8.0, // Espaçamento vertical entre as linhas
      children: times.map((time) {
        return Chip(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          side: BorderSide(color: Theme.of(context).colorScheme.secondary),
          label: Text(time,style: Theme.of(context).textTheme.displayMedium,),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          // Adicione padding se desejar:
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        );
      }).toList(),
    );
  }
}
