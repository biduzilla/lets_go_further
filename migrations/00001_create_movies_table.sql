-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS movies (
    id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    year INTEGER NOT NULL,
    runtime INTEGER NOT NULL,  -- Armazena em minutos
    genres TEXT[] NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Constraints
ALTER TABLE movies ADD CONSTRAINT movies_runtime_check CHECK (runtime >= 0);
ALTER TABLE movies ADD CONSTRAINT movies_year_check CHECK (year BETWEEN 1888 AND date_part('year', now()));
ALTER TABLE movies ADD CONSTRAINT genres_length_check CHECK (array_length(genres, 1) BETWEEN 1 AND 5);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS movies CASCADE;
-- +goose StatementEnd