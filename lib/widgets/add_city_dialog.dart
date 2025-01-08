import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/location_services.dart';

import '../models/weather_model.dart';
import '../providers/cities_list_provider.dart';

class AddCityDialog extends StatefulWidget {
  const AddCityDialog({
    super.key,
  });

  @override
  State<AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends State<AddCityDialog> {
  final _cityNameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  bool isPin = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cityNameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final citiesProvider = context.read<CitiesListProvider>();
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.blue.shade300,
          width: 2,
        ),
      ),
      title: const Text('Add City'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _cityNameController,
              validator: (value) {
                if (_latitudeController.text.isNotEmpty ||
                    _longitudeController.text.isNotEmpty) {
                  return null;
                }
                if ((value == null || value.isEmpty) &&
                    (_latitudeController.text.isEmpty ||
                        _longitudeController.text.isEmpty)) {
                  return 'Please enter a city name';
                }
                return null;
              },
              onChanged: (value) {
                _latitudeController.clear();
                _longitudeController.clear();
              },
              decoration: const InputDecoration(
                hintText: 'City Name (e.g. London)',
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                ),
                Text(
                  'OR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(left: 5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _latitudeController,
                    validator: (value) {
                      if (_cityNameController.text.isNotEmpty) {
                        return null;
                      }
                      if ((value == null || value.isEmpty) &&
                          (_cityNameController.text.isEmpty)) {
                        return 'Please enter a latitude';
                      }
                      final latitude = double.tryParse(value!);
                      if (latitude == null || latitude < -90 || latitude > 90) {
                        return 'Please enter a valid latitude';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _cityNameController.clear();
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Latitude',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _longitudeController,
                    validator: (value) {
                      if (_cityNameController.text.isNotEmpty) {
                        return null;
                      }
                      if ((value == null || value.isEmpty) &&
                          (_cityNameController.text.isEmpty)) {
                        return 'Please enter a longitude';
                      }
                      final longitude = double.tryParse(value!);
                      if (longitude == null ||
                          longitude < -180 ||
                          longitude > 180) {
                        return 'Please enter a valid longitude';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _cityNameController.clear();
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Longitude',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                final LocationServices locationServices = LocationServices();
                final position = await locationServices.getCurrentLocation();
                if (position != null) {
                  _latitudeController.text = position.latitude.toString();
                  _longitudeController.text = position.longitude.toString();
                }
                isPin = true;
              },
              child: const Text('Use Current Location'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              final isAdded = await citiesProvider.addCity(
                cityName: _cityNameController.text.isNotEmpty
                    ? _cityNameController.text
                    : null,
                coord: _latitudeController.text.isNotEmpty &&
                        _longitudeController.text.isNotEmpty
                    ? Coord(
                        lat: double.parse(_latitudeController.text),
                        lon: double.parse(_longitudeController.text),
                      )
                    : null,
                isPinned: isPin,
              );
              if (isAdded) {
                Navigator.pop(context);
              }
            }
          },
          child: Selector<CitiesListProvider, bool>(
            selector: (context, provider) => provider.isLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const Text('Adding...');
              }
              return const Text('Add');
            },
          ),
        ),
      ],
    );
  }
}
