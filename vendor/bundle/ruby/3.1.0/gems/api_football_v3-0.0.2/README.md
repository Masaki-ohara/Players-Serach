# The Football API Ruby Gem

A Ruby interface to [API Football v3](https://www.api-football.com)

This gem won't work with v1 or v2 of the API

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'api_football_v3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_football_v3

## Configurations
Configure `api_football_v3` with your API-Key and the URL (depends on whether you are subscribed via RapidApi or ApiSports)

```ruby
@client = ApiFootballV3::Client.new do |config|
  config.api_key = "YOUR_API_KEY"
  config.base_url = "https://api-football-beta.p.rapidapi.com/" #  or https://v3.football.api-sports.io/
end
```

## Usage
Endpoints can be accessed using built in functions that take options as a parameter.
In all cases options is a hash and they return a JSON object.

Examples:
```ruby
@client.countries(search: "Chile")
```
Response:
```
{
    "get": "countries",
    "parameters": {
        "search": "Chile"
    },
    "errors": [],
    "results": 1,
    "paging": {
        "current": 1,
        "total": 1
    },
    "response": [
        {
            "name": "Chile",
            "code": "CL",
            "flag": "https://media.api-sports.io/flags/cl.svg"
        }
    ]
}
```

```ruby
@client.leagues(country: "Chile", season: 2020)
```
Response:
```
{
    "get": "leagues",
    "parameters": {
        "country": "Chile",
        "season": "2020"
    },
    "errors": [],
    "results": 2,
    "paging": {
        "current": 1,
        "total": 1
    },
    "response": [
        {
            "league": {
                "id": 265,
                "name": "Primera Division",
                "type": "League",
                "logo": "https://media.api-sports.io/football/leagues/265.png"
            },
            "country": {
                "name": "Chile",
                "code": "CL",
                "flag": "https://media.api-sports.io/flags/cl.svg"
            },
            "seasons": [
                {
                    "year": 2020,
                    "start": "2020-01-24",
                    "end": "2020-10-11",
                    "current": true,
                    "coverage": {
                        "fixtures": {
                            "events": true,
                            "lineups": true,
                            "statistics_fixtures": true,
                            "statistics_players": true
                        },
                        "standings": true,
                        "players": true,
                        "top_scorers": true,
                        "predictions": true,
                        "odds": true
                    }
                }
            ]
        },
        {
            "league": {
                "id": 266,
                "name": "Primera B",
                "type": "League",
                "logo": "https://media.api-sports.io/football/leagues/266.png"
            },
            "country": {
                "name": "Chile",
                "code": "CL",
                "flag": "https://media.api-sports.io/flags/cl.svg"
            },
            "seasons": [
                {
                    "year": 2020,
                    "start": "2020-02-22",
                    "end": "2020-10-05",
                    "current": true,
                    "coverage": {
                        "fixtures": {
                            "events": true,
                            "lineups": true,
                            "statistics_fixtures": false,
                            "statistics_players": false
                        },
                        "standings": true,
                        "players": true,
                        "top_scorers": true,
                        "predictions": true,
                        "odds": true
                    }
                }
            ]
        }
    ]
}
```

Here you can see how you can call all available endpoints.
For information on options on each endpoint please review the [official documentation](https://www.api-football.com/documentation-beta).


```ruby
@client.coaches                     # /coachs

@client.countries                   # /countries

@client.fixtures                    # /fixtures
@client.live                        # /fixtures?live=all
@client.rounds                      # /fixtures/rounds
@client.head_to_head                # /fixtures/headtohead
@client.fixture_statistics          # /fixtures/statistics
@client.fixture_events              # /fixtures/events
@client.fixture_lineups             # /fixtures/lineups
@client.fixture_player_statistics   # /fixtures/players

@client.leagues                     # /leagues
@client.leagues_seasons             # /leagues/seasons

@client.odds                        # /odds
@client.mapping                     # /odds/mapping
@client.bookmakers                  # /odds/bookmakers
@client.bets                        # /odds/bets

@client.players                     # /players
@client.top_scorers                 # /players/topscorers
@client.players_seasons             # /players/seasons

@client.predictions                 # /predictions

@client.sidelined                   # /sidelined

@client.standings                   # /standings

@client.teams                       # /teams
@client.team_statistics             # /teams/statistics

@client.timezones                   # /timezone

@client.transfers                   # /transfers

@client.trophies                    # /trophies

@client.venues                      # /venues
```

All endpoints can also be accessed using `get(endpoint, options)`.

Example:
```ruby
@client.get('/teams', { id: 2323 })
```
Response:
```
{
    "get":"teams",
    "parameters":{
        "id":"2323"
    },
    "errors":[],
    "results":1,
    "paging":{
        "current":1,
        "total":1
    },
    "response":[
        {
            "team":{
                "id":2323,
                "name":"Universidad de Chile",
                "country":"Chile",
                "founded":1927,
                "national":false,
                "logo":"https://media.api-sports.io/football/teams/2323.png"
            },
            "venue":{
                "id":316,
                "name":"Estadio Nacional Julio Mart\u00EDnez Pr\u00E1danos",
                "address":"Avenida Grecia 2001, \u00D1u\u00F1oa",
                "city":"Santiago de Chile",
                "capacity":48665,
                "surface":"grass",
                "image":"https://media.api-sports.io/football/venues/316.png"
            }
        }
    ]
}
```