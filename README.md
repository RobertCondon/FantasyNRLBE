```
 _   _ ______ _      ______          _                     ___  ______ _____ 
| \ | || ___ \ |     |  ___|        | |                   / _ \ | ___ \_   _|
|  \| || |_/ / |     | |_ __ _ _ __ | |_ __ _ ___ _   _  / /_\ \| |_/ / | |  
| . ` ||    /| |     |  _/ _` | '_ \| __/ _` / __| | | | |  _  ||  __/  | |  
| |\  || |\ \| |____ | || (_| | | | | || (_| \__ \ |_| | | | | || |    _| |_
\_| \_/\_| \_\_____/ \_| \__,_|_| |_|\__\__,_|___/\__, | \_| |_/\_|    \___/
                                                   __/ |                     
                                                   |___/
```

## 🏉 About The Project

**Fantasy NRL Rails API** is an innovative API 🚀 designed to make NRL fantasy stats easily accessible in a query-able format. Aimed at NRL enthusiasts and Rails API developers, this project offers a unique approach to accessing and analyzing NRL statistics.

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2.2 (Use `rbenv` or `rvm` for version management)
- PostgreSQL (Ensure it's installed and running)
- Bundler (Install via `gem install bundler`)

### 🛠 Installation

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/RobertCondon/FantasyNRLBE
   cd FantasyNRLBE
   ```

2. **Install Dependencies**:
   ```sh
   bundle install
   ```

3. **Database Setup**:
    - Start PostgreSQL service.
    - Configure `database.yml`.
    - Initialize the database:
      ```sh
      rails db:create
      rails db:migrate
      ```

4. **Running the Application**:
   ```sh
   rails server
   ```

5. **Running Tests**:
   ```sh
   bundle exec rspec
   ```

## 👥 Contributing

Feel free to make a pull request or open an issue. Our core team will promptly review contributions. Remember: Be kind, be helpful.

## 🛠 Troubleshooting

- **Bundle Install Fails**: Ensure you have the correct Ruby version set.
- **Database Errors**: Verify PostgreSQL is running and `database.yml` is correctly set up.
- **Server Won't Start**: Check for any port conflicts or environment-specific issues.

## 🚧 Future Plans

- API Endpoints Documentation
- Example Usage and Tutorials

## 🙏 Acknowledgments

- Creator: Rob Condon
- Data Source: NRL.com

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
