# System Architecture

The following diagram illustrates the high-level architecture of the URL Shortener service, designed for high availability and low latency.

```mermaid
graph TD
    %% Nodes
    Client[Clients<br/>Browser, Mobile, CLI]
    CDN[CDN / Edge Cache]
    LB[API Gateway / Load Balancer<br/>NGINX / ALB]
    
    subgraph API["Shortener API (Spring Boot)"]
        Controller[Controller / Router]
        Service[Service Layer]
        Cache[Cache Client - Redis]
    end

    DB[(Relational DB - Postgres<br/>Persistent mappings<br/>Unique constraints)]
    Analytics[(Analytics DB<br/>Time-series / Clickhouse)]
    Backup[Backups / WAL]

    %% Flow
    Client --> CDN
    CDN --> LB
    LB --> API
    
    %% Internal API Flow
    Controller --> Service
    Service --> Cache
    
    %% Data Persistence
    Service --> DB
    Service -.->|Async/Kafka| Analytics
    
    %% DB Maintenance
    DB --- Backup

    %% Styling
    style API fill:#f9f9f9,stroke:#333,stroke-width:2px
    style DB fill:#e1f5fe,stroke:#0277bd
    style Analytics fill:#fff3e0,stroke:#ef6c00
