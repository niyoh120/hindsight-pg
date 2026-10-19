# PostgreSQL 17 + pgroonga + pgvector
#
# Hindsight 需要 pgvector 做向量检索、pgroonga 做 CJK BM25。
# 上游 groonga/pgroonga 镜像只带 pgroonga，pgvector 需要额外安装。
#
# PGROONGA_TAG 由 CI 自动解析为上游最新的 *-debian-17 标签，
# 因此本仓库无需手动改版本即可跟随上游。
ARG PGROONGA_TAG=4.1.0-debian-17
FROM groonga/pgroonga:${PGROONGA_TAG}

# 不锁 pgvector 版本：PGDG 更新后构建仍可继续，且随上游 PG17 小版本对齐
RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-17-pgvector \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.title="hindsight-pg" \
      org.opencontainers.image.description="PostgreSQL 17 with pgroonga + pgvector for Hindsight" \
      org.opencontainers.image.source="https://github.com/niyoh120/hindsight-pg" \
      org.opencontainers.image.licenses="MIT"
