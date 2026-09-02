import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/db.dart';
import '../services/decompress_service.dart';

class RecordDetailScreen extends StatefulWidget {
  const RecordDetailScreen({super.key, required this.record});

  final Record record;

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
    return Scaffold(
      appBar: AppBar(title: Text(record.title ?? 'No title')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (record.category != null) Text(record.category!, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 16),
            if (_descriptionFuture == null)
              const Text('No details available.')
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
    );
  }
}
