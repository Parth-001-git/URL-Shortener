graph TD
    Client[Clients<br/>Browser, Mobile, CLI] --> CDN[CDN / Edge Cache]
    CDN --> LB[API Gateway / Load Balancer<br/>NGINX / ALB]
    
    subgraph ServiceLayer [Shortener API - Spring Boot]
        Controller[Controller / Router]
        Service[Service Layer]
        RedisClient[Redis Cache Client]
    end
    
    LB --> Controller
    Controller --> Service
    Service --> RedisClient
    
    Service --> DB[(Relational DB - Postgres<br/>Persistent mappings<br/>Unique constraints)]
    Service -.-> Analytics[(Analytics DB / Time-series<br/>Kafka -> Click Processor)]
    
    DB --- Backup[Backups / WAL]

    style ServiceLayer fill:#f9f9f9,stroke:#333,stroke-width:2px
    style DB fill:#e1f5fe,stroke:#01579b
    style Analytics fill:#fff3e0,stroke:#ef6c00
