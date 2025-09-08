# ERD Documentation

### Entity-Relationship Diagram (ERD)

```mermaid
erDiagram
  %% SLOT MANAGEMENT
  slots ||--o{ rooms : "has many"
  rooms ||--o{ chests : "has many"
```
