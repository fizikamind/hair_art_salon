import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/service.dart';
import '../../providers/service_provider.dart';

class EditServiceScreen extends StatefulWidget {
  final ServiceModel service;

  const EditServiceScreen({
    super.key,
    required this.service,
  });

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _durationController;

  late bool _isActive;

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.service.name);

    _categoryController =
        TextEditingController(text: widget.service.category);

    _descriptionController =
        TextEditingController(text: widget.service.description);

    _priceController =
        TextEditingController(text: widget.service.price.toString());

    _durationController =
        TextEditingController(text: widget.service.duration.toString());

    _isActive = widget.service.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _updateService() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedService = ServiceModel(
      id: widget.service.id,
      name: _nameController.text.trim(),
      category: _categoryController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text),
      duration: int.parse(_durationController.text),
      isActive: _isActive,
      createdAt: widget.service.createdAt,
    );

    await Provider.of<ServiceProvider>(
      context,
      listen: false,
    ).updateService(updatedService);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Service Updated Successfully"),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Service Name",
                ),
                validator: (value) =>
                value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: "Category",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                validator: (value) =>
                value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Duration (Minutes)",
                ),
                validator: (value) =>
                value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),

              const SizedBox(height: 20),

              SwitchListTile(
                title: const Text("Active Service"),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _updateService,
                  icon: const Icon(Icons.save),
                  label: const Text("UPDATE SERVICE"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}