import 'package:flutter/material.dart';

class SearchableMultiSelect extends StatelessWidget {
  const SearchableMultiSelect({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  });

  final String title;
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;

  Future<void> _openPicker(BuildContext context) async {
    final selected = Set<String>.from(selectedValues);
    String searchQuery = '';

    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filteredOptions = options.where((option) {
              return option.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );
            }).toList();

            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Zoeken...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = filteredOptions[index];
                          final isSelected = selected.contains(option);

                          return CheckboxListTile(
                            value: isSelected,
                            title: Text(option),
                            onChanged: (value) {
                              setModalState(() {
                                if (value == true) {
                                  selected.add(option);
                                } else {
                                  selected.remove(option);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                              selected.toList(),
                            );
                          },
                          child: const Text('Selectie opslaan'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openPicker(context),
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.arrow_drop_down),
          border: const OutlineInputBorder(),
        ),
        child: selectedValues.isEmpty
            ? const Text(
          'Niet geselecteerd',
          style: TextStyle(
            color: Colors.grey,
          ),
        )
            : Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final value in selectedValues)
              Chip(
                label: Text(value),
              ),
          ],
        ),
      ),
    );
  }
}