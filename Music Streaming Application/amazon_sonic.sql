-- Amazon Sonic — Unified Music & Creator Economy

CREATE SCHEMA IF NOT EXISTS amazon_sonic;
SET search_path TO amazon_sonic, public;

-- 1) Users
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(150) UNIQUE NOT NULL,
  full_name VARCHAR(120),
  country_code CHAR(2),
  role VARCHAR(20),
  status VARCHAR(20),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2) Labels
CREATE TABLE labels (
  label_id SERIAL PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  country_code CHAR(2),
  contact_email VARCHAR(150),
  status VARCHAR(20),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 3) Artists (FK: user_id -> users, label_id -> labels)
CREATE TABLE artists (
  artist_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  stage_name VARCHAR(140) NOT NULL,
  label_id INT REFERENCES labels(label_id),
  country_code CHAR(2),
  is_verified BOOLEAN DEFAULT FALSE,
  join_date DATE
);

-- 4) Albums (FK: primary_artist_id -> artists, label_id -> labels)
CREATE TABLE albums (
  album_id SERIAL PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  primary_artist_id INT NOT NULL REFERENCES artists(artist_id),
  label_id INT REFERENCES labels(label_id),
  upc VARCHAR(20) UNIQUE,
  album_type VARCHAR(20),
  release_date DATE,
  cover_url VARCHAR(300)
);

-- 5) Songs (FK: primary_artist_id -> artists, album_id -> albums)
CREATE TABLE songs (
  song_id SERIAL PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  primary_artist_id INT NOT NULL REFERENCES artists(artist_id),
  album_id INT REFERENCES albums(album_id),
  isrc VARCHAR(20) UNIQUE,
  duration_sec INT,
  release_date DATE,
  explicit BOOLEAN DEFAULT FALSE,
  audio_url VARCHAR(300),
  lyric_lang VARCHAR(10)
);

-- 6) Genres (self-ref parent_genre_id)
CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(80) UNIQUE NOT NULL,
  parent_genre_id INT REFERENCES genres(genre_id)
);

-- 7) SongGenres (bridge: song_id + genre_id)
CREATE TABLE song_genres (
  song_id INT REFERENCES songs(song_id),
  genre_id INT REFERENCES genres(genre_id),
  added_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (song_id, genre_id)
);

-- 8) Moods
CREATE TABLE moods (
  mood_id SERIAL PRIMARY KEY,
  name VARCHAR(60) UNIQUE NOT NULL
);

-- 9) SongMoods (bridge: song_id + mood_id)
CREATE TABLE song_moods (
  song_id INT REFERENCES songs(song_id),
  mood_id INT REFERENCES moods(mood_id),
  added_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (song_id, mood_id)
);

-- 10) Playlists (FK: owner_user_id -> users)
CREATE TABLE playlists (
  playlist_id SERIAL PRIMARY KEY,
  owner_user_id INT NOT NULL REFERENCES users(user_id),
  title VARCHAR(160) NOT NULL,
  is_public BOOLEAN DEFAULT TRUE,
  description VARCHAR(400),
  cover_url VARCHAR(300),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ
);

-- 11) PlaylistItems (FK: playlist_id -> playlists, song_id -> songs, added_by -> users)
CREATE TABLE playlist_items (
  playlist_id INT REFERENCES playlists(playlist_id),
  position INT,
  song_id INT NOT NULL REFERENCES songs(song_id),
  added_by INT REFERENCES users(user_id),
  added_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (playlist_id, position)
);

-- 12) Streams (FK: user_id -> users, song_id -> songs)
CREATE TABLE streams (
  stream_id BIGSERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  song_id INT NOT NULL REFERENCES songs(song_id),
  device VARCHAR(30),
  start_time TIMESTAMPTZ NOT NULL DEFAULT now(),
  end_time TIMESTAMPTZ,
  completed BOOLEAN DEFAULT FALSE,
  source VARCHAR(30),
  bitrate_kbps INT,
  ip INET,
  geo_country CHAR(2)
);

-- 13) SongFeedback (FK: user_id -> users, song_id -> songs)
CREATE TABLE song_feedback (
  feedback_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  song_id INT NOT NULL REFERENCES songs(song_id),
  liked BOOLEAN,
  rating INT,
  marked_skip BOOLEAN,
  feedback_time TIMESTAMPTZ DEFAULT now(),
  UNIQUE (user_id, song_id)
);

-- 14) Plans
CREATE TABLE plans (
  plan_id SERIAL PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  tier_rank INT,
  price_amount NUMERIC(10,2),
  price_currency CHAR(3),
  billing_period VARCHAR(20),
  max_quality VARCHAR(10),
  ad_free BOOLEAN,
  is_active BOOLEAN,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 15) Subscriptions (FK: user_id -> users, plan_id -> plans)
CREATE TABLE subscriptions (
  sub_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  plan_id INT NOT NULL REFERENCES plans(plan_id),
  start_date DATE,
  end_date DATE,
  auto_renew BOOLEAN,
  status VARCHAR(20),
  last_renewal_at TIMESTAMPTZ
);

-- 16) PaymentMethods (FK: user_id -> users)
CREATE TABLE payment_methods (
  pm_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  method_type VARCHAR(20),
  masked_details VARCHAR(80),
  is_default BOOLEAN,
  verified BOOLEAN,
  added_at TIMESTAMPTZ DEFAULT now()
);

-- 17) Invoices (FK: user_id -> users, sub_id -> subscriptions)
CREATE TABLE invoices (
  invoice_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  sub_id INT REFERENCES subscriptions(sub_id),
  amount NUMERIC(12,2) NOT NULL,
  currency CHAR(3),
  period_start DATE,
  period_end DATE,
  issued_at TIMESTAMPTZ DEFAULT now(),
  status VARCHAR(20)
);

-- 18) Payments (FK: invoice_id -> invoices, pm_id -> payment_methods)
CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
  pm_id INT REFERENCES payment_methods(pm_id),
  paid_amount NUMERIC(12,2) NOT NULL,
  currency CHAR(3),
  paid_at TIMESTAMPTZ DEFAULT now(),
  provider_txn_ref VARCHAR(80),
  status VARCHAR(20)
);

-- 19) RoyaltyPolicies
CREATE TABLE royalty_policies (
  policy_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  basis VARCHAR(20),
  per_stream_amount NUMERIC(10,4),
  share_pct NUMERIC(6,3),
  region_scope VARCHAR(80),
  effective_from DATE,
  effective_to DATE,
  status VARCHAR(20)
);

-- 20) RoyaltyEvents (FK: song_id -> songs, artist_id -> artists, stream_id -> streams, policy_id -> royalty_policies)
CREATE TABLE royalty_events (
  roy_event_id BIGSERIAL PRIMARY KEY,
  song_id INT NOT NULL REFERENCES songs(song_id),
  artist_id INT NOT NULL REFERENCES artists(artist_id),
  stream_id BIGINT REFERENCES streams(stream_id),
  policy_id INT NOT NULL REFERENCES royalty_policies(policy_id),
  event_time TIMESTAMPTZ DEFAULT now(),
  earning_amount NUMERIC(12,4) NOT NULL,
  currency CHAR(3),
  source_note VARCHAR(160)
);
