# Backend (Spring Boot)

Run the backend against the local Postgres started by the repo-level `docker-compose.yml`:

```bash
cd backend
./mvnw spring-boot:run
```

API endpoints:
- GET /api/records
- GET /api/records/{id}
- POST /api/records
- PUT /api/records/{id}
- DELETE /api/records/{id}
