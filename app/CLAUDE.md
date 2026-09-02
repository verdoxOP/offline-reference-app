# Flutter Project Instructions

## Project Overview

This is a compact, fully offline-first Flutter application designed to ship with a large pre-packaged dataset.

The application must work without Wi-Fi, cellular data, internet access, or network signal.

The application will contain approximately 500–600 MB of pre-packaged information at maximum.

The primary goal is to efficiently store, search, retrieve, and display this information while keeping storage usage, memory usage, and startup time reasonable.

## Core Architecture

The data pipeline is:

```text
Pre-packaged data
       ↓
      Isar
       ↓
Compressed fields / blobs using Zstandard (zstd)
       ↓
Retrieve required record
       ↓
Decompress only when required
       ↓
Display information
```

The application should **not** decompress the complete dataset during startup or load the complete dataset into memory.

Large pieces of information should remain compressed in Isar until they are actually needed.

## Core Requirements

* The application must function completely offline.
* Core functionality must never require network connectivity.
* The pre-packaged dataset must remain within the approximately 500–600 MB maximum target.
* Store the pre-packaged information in Isar.
* Compress appropriate large fields/blobs using Zstandard (zstd).
* Keep compressed data compressed while it is stored.
* Decompress data only when it is required by the application.
* Avoid loading large amounts of compressed or decompressed data into memory unnecessarily.
* Keep expensive decompression work away from the Flutter UI thread when appropriate.
* Optimize for both storage size and runtime performance.

## Database — Isar

The project uses **Isar community** as its local database.

Do not replace Isar with SQLite, Drift, Hive, ObjectBox, or another database unless explicitly requested.

The pre-packaged dataset should be stored in Isar.

Use Isar collections, indexes, and queries to efficiently locate the required information.

### Isar data design

Separate frequently queried metadata from large compressed payloads where appropriate.

For example:

```text
Record
├── id
├── title
├── category
├── searchable metadata
└── compressedData
```

Searchable and frequently accessed fields should remain directly queryable by Isar.

Large fields that do not need to be searched directly can be stored as compressed zstd data.

Do not compress fields merely for the sake of compressing them.

Consider whether compression actually provides a meaningful storage benefit for each type of data.

## Compression — Zstandard

The project uses **Zstandard (zstd)** for compression and decompression.

Zstd is used to reduce the storage footprint of large fields/blobs stored in Isar.

### Storage model

Large data should follow this general pattern:

```text
Original data
     ↓
   Zstd
     ↓
compressed bytes
     ↓
    Isar
```

When the application needs the information:

```text
Isar
 ↓
compressed bytes
 ↓
Zstd decompression
 ↓
usable data
 ↓
UI
```

### Rules

* Do not replace zstd with another compression algorithm without explicit approval.
* Do not decompress the entire database.
* Do not decompress large amounts of data before it is required.
* Prefer on-demand decompression.
* Avoid repeatedly decompressing the same data unnecessarily.
* Do not perform expensive decompression synchronously on the UI thread.
* Use an isolate when decompression is sufficiently expensive to affect UI responsiveness.
* Avoid unnecessary copying of large byte arrays.
* Consider chunking data when individual blobs become excessively large.

## Compression Boundaries

Compression should happen at a sensible data boundary.

Prefer:

```text
Record
└── compressed payload
```

rather than:

```text
Entire database
└── one enormous compressed blob
```

The application should be able to query Isar for metadata and identify the required record without decompressing unrelated records.

For example:

```text
Search "Example"
      ↓
Isar index/query
      ↓
Matching record
      ↓
compressedData
      ↓
Zstd decompression
      ↓
Display
```

The search operation should not require decompressing every record.

## Pre-Packaged Data

The application ships with its dataset already prepared.

The build/data-generation process should:

1. Generate or obtain the source dataset.
2. Transform it into the application's required structure.
3. Compress appropriate large fields using zstd.
4. Insert the resulting records into Isar.
5. Package the resulting Isar database with the application.

The runtime application must not require the internet to obtain this data.

Do not download or reconstruct the dataset on first launch unless explicitly requested.

## Storage Size

The approximate maximum target is:

**500–600 MB**

When changing the dataset or storage format, consider:

* Raw dataset size.
* Compressed payload size.
* Isar database overhead.
* Duplicate data.
* Index size.
* Application/package overhead.
* Temporary files created during packaging or installation.

Do not assume that the zstd-compressed payload size is equal to the final Isar database size.

Measure the final database size using realistic data.

## Memory Usage

The application should be designed so that a 500–600 MB dataset does not require 500–600 MB of RAM.

Avoid:

```text
500 MB dataset
       ↓
decompress everything
       ↓
500+ MB RAM
```

Prefer:

```text
Isar
 ↓
query relevant record
 ↓
small compressed blob
 ↓
decompress
 ↓
display
 ↓
release memory
```

Use pagination, targeted queries, and lazy loading where appropriate.

## Flutter & Dart

* Follow standard Flutter and Dart conventions.
* Use null safety correctly.
* Use `const` widgets and constructors where appropriate.
* Prefer small, reusable widgets.
* Keep UI code separate from database and compression logic.
* Avoid unnecessary widget rebuilds.
* Dispose controllers, streams, and other resources correctly.
* Keep expensive operations out of widget build methods.

## Architecture

Keep responsibilities separated.

### Presentation

Responsible for:

* Screens
* Widgets
* User interaction
* Displaying information
* UI state

The presentation layer should not directly implement Isar queries or zstd compression/decompression.

### Data Layer

Responsible for:

* Isar collections
* Isar queries
* Indexes
* Retrieving records
* Storing records
* Providing compressed data to the appropriate service

### Compression Layer

Responsible for:

* Zstd compression
* Zstd decompression
* Conversion between compressed bytes and usable data
* Managing decompression work

The UI should not directly call low-level zstd functionality.

## Performance

Performance is important because the application contains a large pre-packaged dataset.

Avoid:

* Loading the entire dataset into memory.
* Decompressing the entire database.
* Decompressing unrelated records.
* Performing expensive decompression on the UI thread.
* Unnecessary copying of large byte arrays.
* Performing expensive work during widget builds.
* Repeatedly querying or decompressing the same data unnecessarily.

When appropriate, use:

* Isar indexes.
* Targeted queries.
* Pagination.
* Lazy loading.
* Isolates for CPU-heavy decompression.
* Caching of recently decompressed data when it provides a measurable benefit.

Do not introduce caching blindly. Consider memory usage.

## Dependencies

Avoid dependency bloat.

Before adding a package:

1. Check whether Flutter/Dart already provides the functionality.
2. Check whether the project already has a suitable implementation.
3. Consider application size.
4. Consider platform compatibility.
5. Consider native dependencies.
6. Consider runtime performance.
7. Consider whether the dependency is compatible with Isar and the existing zstd implementation.

Do not introduce another database or compression system without a clear reason.

## Offline Requirement

Assume the application may be running in airplane mode.

Core functionality must continue working.

Never introduce an API request, cloud database, CDN, remote asset, or other network dependency for core functionality without explicit approval.

## Making Changes

Before modifying code:

1. Inspect the existing implementation.
2. Understand the relevant data flow.
3. Search for existing implementations before creating new ones.
4. Consider the effect on storage size.
5. Consider the effect on memory usage.
6. Consider the effect on decompression performance.
7. Make the smallest reasonable change.

Do not rewrite unrelated code.

## Testing

When appropriate, run:

```bash
flutter analyze
flutter test
```

When changing Isar or zstd functionality, test with realistic data sizes.

Test:

* Isar queries.
* Indexes.
* Data integrity.
* Compression.
* Decompression.
* Large records.
* Memory usage.
* UI responsiveness.
* Offline functionality.
* Complete pre-packaged dataset.

When possible, verify that compressed data can be successfully round-tripped:

```text
original
   ↓
compress
   ↓
store
   ↓
retrieve
   ↓
decompress
   ↓
original
```

## Communication

Be direct and concise.

For significant changes:

1. Briefly explain the approach.
2. Implement the change.
3. Run relevant tests/checks.
4. Summarize what changed.
5. Mention remaining issues or risks.

Do not ask for confirmation for every small implementation decision.

Make reasonable decisions and proceed.

## Critical Constraints

Always respect these constraints:

* Flutter / Dart
* Isar for local database storage
* Zstandard (zstd) for compression/decompression
* Approximately 500–600 MB maximum dataset target
* Fully offline operation
* No runtime dependency on Wi-Fi, cellular data, or internet
* Pre-packaged dataset
* Compressed large fields/blobs stored inside Isar
* On-demand decompression
* Avoid full-dataset decompression
* Minimize runtime memory usage
* Keep expensive processing away from the UI thread
