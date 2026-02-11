import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Plant.dart';
import '../providers/PlantProvider.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantCardWidget extends StatelessWidget {
  final Plant plant;

  const PlantCardWidget({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(plant.lastWateredDate).inDays;
    final daysUntil = plant.frequencyDays - difference;
    final isOverdue = daysUntil <= 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(
                File(plant.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[300], child: const Icon(Icons.local_florist, size: 50)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.name, style: Theme.of(context).textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(plant.species, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                if (isOverdue)
                  Row(children: [
                    const Icon(Icons.warning, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(l10n.overdue(difference - plant.frequencyDays), style: const TextStyle(color: Colors.red, fontSize: 12)))
                  ])
                else
                  Text(l10n.nextWatering(daysUntil), style: const TextStyle(color: Colors.green, fontSize: 12)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<PlantProvider>(context, listen: false).waterPlant(plant);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOverdue ? Colors.red : Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(l10n.waterNow, style: const TextStyle(fontSize: 12)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
