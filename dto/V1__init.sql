-- Flyway migration script for PostgreSQL
-- Creates the main table for storing short links

CREATE TABLE short_links (
    -- 'bigserial' is a PostgreSQL auto-incrementing 8-byte integer
    id              BIGSERIAL PRIMARY KEY,
    
    -- The unique short code (e.g., "aBcDe12")
    code            VARCHAR(255) NOT NULL,
    
    -- The original, long URL (using 'TEXT' for unlimited length)
    url             TEXT NOT NULL,
    
    -- Timestamp for when the link was created
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL,
    
    -- Optional timestamp for when the link should expire
    expires_at      TIMESTAMP WITH TIME ZONE,
    
    -- Counter for how many times the link has been accessed
    hit_count       BIGINT NOT NULL DEFAULT 0,
    
    -- Soft delete flag
    deleted         BOOLEAN NOT NULL DEFAULT FALSE,
    
    -- Timestamp for the last access, can be used for analytics
    last_accessed   TIMESTAMP WITH TIME ZONE,
    
    -- Optional hash of the normalized URL for quick deduplication
    canonical_hash  VARCHAR(255),
    
    -- Add a unique constraint on the 'code' column for fast lookups
    CONSTRAINT uq_code UNIQUE (code)
);

-- Create indexes as hinted in the ticket
CREATE INDEX idx_code ON short_links (code);
CREATE INDEX idx_canonical_hash ON short_links (canonical_hash);