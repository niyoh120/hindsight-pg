# hindsight-pg

PostgreSQL 17 image with **pgroonga** (CJK full-text search) and **pgvector** (vector similarity) for [Hindsight](https://github.com/vectorize-io/hindsight).

Upstream `groonga/pgroonga` ships pgroonga only; Hindsight also needs `vector`, so this image adds `postgresql-17-pgvector` on top.

## Tags

| Tag | Meaning |
|---|---|
| `17` | latest build (moving) |
| `17-<pgroonga-tag>` | immutable, e.g. `17-4.1.0-debian-17` |
| `latest` | same as `17` |

## Following upstream

A weekly workflow resolves the newest `*-debian-17` tag from Docker Hub and rebuilds only when that version has no image yet (tag `17-<version>` is the marker). Manual runs accept `force: true`.

```bash
docker pull ghcr.io/niyoh120/hindsight-pg:17
```

## Usage

```yaml
services:
  db:
    image: ghcr.io/niyoh120/hindsight-pg:17
    environment:
      POSTGRES_USER: hindsight
      POSTGRES_PASSWORD: change-me
      POSTGRES_DB: hindsight
    volumes:
      - pg_data:/var/lib/postgresql/data
      - ./initdb:/docker-entrypoint-initdb.d:ro
```

`initdb/01-extensions.sql`:

```sql
CREATE EXTENSION IF NOT EXISTS vector CASCADE;
CREATE EXTENSION IF NOT EXISTS pgroonga CASCADE;
```
