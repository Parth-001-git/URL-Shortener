Clients (Browser, Mobile, CLI)
        |
  -----------------------
  |  CDN / Edge Cache   |
  -----------------------
        |
  API Gateway / Load Balancer (NGINX / ALB)
        |
  -----------------------------
  |        Shortener API      |  <-- Spring Boot services (stateless)
  |  - Controller / Router    |
  |  - Service layer          |
  |  - Cache client (Redis)   |
  -----------------------------
       |            |
       |            +------------------+
       |                               |
  Relational DB (Postgres)        Analytics DB / Time-series (optional)
  - persistent mappings           - click events, geo/time aggregates
  - unique constraints            - Kafka -> Click Processor -> Click DB
       |
    Backups / WAL
