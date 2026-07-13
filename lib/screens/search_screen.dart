import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();

  final List<String> allowedCities = [
    'warsaw',
    'london',
    'maputo',
    'lisbon',
    'new york',
    'tokyo',
    'paris',
    'madrid',
    'berlin',
    'rome',
    'dubai',
    'cape town',
  ];

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  void searchCity() {
    if (formKey.currentState!.validate()) {
      final city = cityController.text.trim();

      Navigator.pop(context, city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(183, 1, 35, 61),
      appBar: AppBar(
        title: const Text('Search City'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Search for a city',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a city name';
                  }

                  final city = value.trim().toLowerCase();

                  if (!allowedCities.contains(city)) {
                    return 'City not available';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: searchCity,
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}