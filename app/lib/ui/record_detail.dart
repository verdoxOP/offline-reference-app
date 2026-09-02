import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/db.dart';
import '../i18n/localization.dart';
import '../services/decompress_service.dart';
import 'category_icons.dart';

class RecordDetailScreen extends StatefulWidget {
  const RecordDetailScreen({super.key, required this.record, required this.language});

  final Record record;
  final AppLanguage language;

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  final _decompressService = DecompressService();
  Future<String?>? _descriptionFuture;

  @override
  void initState() {
    super.initState();
    final payload = widget.record.compressedPayload;
    _descriptionFuture = payload == null
        ? null
        : _decompressService.decompress(payload).then(utf8.decode);
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    final imagePath = record.imageUrls?.isNotEmpty == true ? record.imageUrls!.first : null;
    return Scaffold(
      appBar: AppBar(title: Text(record.title ?? 'No title')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            Image.asset(imagePath, height: 200, width: double.infinity, fit: BoxFit.cover)
          else
            Container(
              height: 120,
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(iconForCategory(record.category), size: 48),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (record.category != null)
                    Text(record.category!, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 16),
                  if (_descriptionFuture == null)
                    Text(Strings.of(widget.language, 'noDetails'))
                  else
                    Expanded(
                      child: FutureBuilder<String?>(
                        future: _descriptionFuture,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return SingleChildScrollView(child: Text(snapshot.data ?? ''));
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
