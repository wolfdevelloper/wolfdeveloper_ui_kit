import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int age;
  final DateTime scheduledTime;
  final List<String> services;
  final String phoneNumber;
  final String address;
  final List<String> facilities;
  final void Function()? onTap;

  const ScheduleCard(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.scheduledTime,
      required this.services,
      required this.phoneNumber,
      required this.address,
      required this.facilities,
      required this.onTap});



  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final timeDifference = scheduledTime.difference(currentTime);
    final formattedScheduledTime =
        '${scheduledTime.hour.toString().padLeft(2, '0')}:${scheduledTime.minute.toString().padLeft(2, '0')}';

    Color buttonColor;
    if (timeDifference > const Duration(minutes: 30)) {
      buttonColor = Colors.green;
    } else if (timeDifference > const Duration(minutes: 10)) {
      buttonColor = Colors.yellow;
    } else {
      buttonColor = Colors.red;
    }

    return SizedBox(
      width: 354,
      height: 340,
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // Para o nome não quebrar o layout
                    child: Text(
                      style: Theme.of(context).textTheme.titleMedium,
                      '$firstName ${lastName.length > 15 ? '${lastName.substring(0, 15)}...' : lastName}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(formattedScheduledTime),
                  IconButton(
                    onPressed: () => onTap!(),
                    icon: Icon(
                      Icons.circle,
                      color: buttonColor,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      // Espaçamento à direita
                      child: Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        label: Text(
                          service,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(phoneNumber),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 8),
                  Flexible(
                    // Permite quebras de linha no endereço
                    child: Text(
                      address,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              IntrinsicWidth(
                // Determina a largura com base no conteúdo
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: facilities
                        .map((facility) => SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Chip(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  label: Text(
                                    facility,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
