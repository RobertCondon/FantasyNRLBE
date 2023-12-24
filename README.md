# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Database DBML
``````
// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table players {
  id integer [primary key]
  current_team_id integer
  current_position string
  player_name string
  current_price integer
  injuried boolean
  suspended boolean
  created_at timestamp 
}


Table player_rounds {
  id integer [primary key]
  player_id integer
  team_id integer
  match_roster_id integer
  position string
  stats string
  created_at timestamp 
}

Table teams {
  id integer [primary key]
  name string
  short_name string
  ladder_position integer
  created_at timestamp
}

Table matches {
  id integer [primary key]
  date date
  round integer
  team_home_score integer
  team_away_score integer
  roster_home_id integer
  roster_away_id integer
  winner_id integer
  created_at timestamp
}

Table match_rosters {
  id integer [primary key]
  team_id integer
  created_at timestamp
}


Ref: players.current_team_id > teams.id

Ref: match_rosters.team_id > teams.id

Ref: matches.roster_home_id > match_rosters.id
Ref: matches.roster_away_id > match_rosters.id
Ref: matches.winner_id > match_rosters.id

Ref: player_rounds.team_id > teams.id
Ref: player_rounds.match_roster_id > match_rosters.id
Ref: player_rounds.player_id > players.id

``````
