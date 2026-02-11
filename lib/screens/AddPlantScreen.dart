import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/Plant.dart';
import '../providers/PlantProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _frequencyController = TextEditingController();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image')));
        return;
      }

      final plant = Plant(
        name: _nameController.text,
        species: _speciesController.text,
        imagePath: _image!.path,
        frequencyDays: int.parse(_frequencyController.text),
        lastWateredDate: DateTime.now(),
      );

      Provider.of<PlantProvider>(context, listen: false).addPlant(plant).then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addPlant)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (ctx) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: Text(l10n.camera),
                            onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.camera); }
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: Text(l10n.gallery),
                            onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.gallery); }
                          ),
                        ],
                      ),
                    ));
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: l10n.plantName, border: const OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _speciesController,
                  decoration: InputDecoration(labelText: l10n.species, border: const OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _frequencyController,
                  decoration: InputDecoration(labelText: l10n.frequencyDays, border: const OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                     if (value == null || value.isEmpty) return 'Required';
                     if (int.tryParse(value) == null) return 'Must be a number';
                     if (int.parse(value) <= 0) return 'Must be > 0';
                     return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _savePlant,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: Text(l10n.save, style: const TextStyle(fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
