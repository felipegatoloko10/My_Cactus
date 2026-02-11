import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/PlantProvider.dart';
import '../widgets/PlantCardWidget.dart';
import 'AddPlantScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: Consumer<PlantProvider>(
        builder: (context, provider, child) {
          if (provider.plants.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.grass, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(l10n.emptyGarden, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: provider.plants.length,
              itemBuilder: (context, index) {
                return PlantCardWidget(plant: provider.plants[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final provider = Provider.of<PlantProvider>(context, listen: false);
          if (provider.plants.length >= 3) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l10n.premiumUpgrade),
                content: Text(l10n.premiumMessage),
                actions: [
                  TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.ok)),
                ],
              ),
            );
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddPlantScreen()));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
