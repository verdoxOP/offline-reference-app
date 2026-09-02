# Local Setup

1) Start local Postgres (for backend and pipeline):

```bash
cd /home/matt/projects/offline-reference-app
docker compose up -d
```

2) Backend (Spring Boot)

```bash
cd backend
./mvnw spring-boot:run
# or build: ./mvnw package && java -jar target/backend-0.0.1-SNAPSHOT.jar
```

3) Pipeline (exports the authoring DB to a dataset the app can import)

```bash
cd pipeline
npm install
node index.js
# Writes pipeline/dist/bundle-v0.0.1/records.jsonl
```

4) Import the dataset into Isar (build-time only — this is never run by the shipped app)

```bash
cd app
flutter pub get
dart run tool/import_dataset.dart
# Writes app/assets/data/dataset.isar, bundled into the app as an asset
```

5) App (Flutter)

```bash
cd app
flutter run
```

On first launch the app copies the bundled `dataset.isar` asset into its local storage and opens it — there's no in-app import step and no network involved.

Each subproject has its own README with details.
