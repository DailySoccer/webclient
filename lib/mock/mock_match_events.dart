part of mock_daily_soccer_http;

class MockMatchEvents {
  var matches;

  MockMatchEvents() {
    matches = new JsonObject.fromJsonString(JSON);
  }

  static String JSON = """
      [
        {
          "_id":"1-BRACRO",
          "soccerTeamA":{
            "id": "BRA",
            "name": "Brazil",
            "soccerPlayers": [
              { "name": "Jugador1-Brazil", "fieldPos":"GOALKEEPER", "salary": 10000 }
            ]
          },
          "soccerTeamB":{
            "id": "CRO",
            "name": "Croatia",
            "soccerPlayers": [
              { "name": "Jugador1-Croatia", "fieldPos":"DEFENSE", "salary": 10000 }
            ]
          },
          "startDate":"2014/06/12-21:00"
        },
        {
          "_id":"2-MEXCMR",
          "soccerTeamA":{
            "id": "MEX",
            "name": "Mexico",
            "soccerPlayers": [
              { "name": "Jugador1-Mexico", "fieldPos":"GOALKEEPER", "salary": 10000 }
            ]
          },
          "soccerTeamB":{
            "id": "CMR",
            "name": "Cameroon",
            "soccerPlayers": [
              { "name": "Jugador1-Cameroon", "fieldPos":"FORWARD", "salary": 10000 }
            ]
          },
          "startDate":"2014/06/13-17:00"
        },
        {
          "_id":"3-ESPNED",
          "soccerTeamA":{
            "id": "ESP",
            "name": "Spain",
            "soccerPlayers": [
              { "name": "Jugador1-Spain", "fieldPos":"GOALKEEPER", "salary": 10000 }
            ]
          },
          "soccerTeamB":{
            "id": "NED",
            "name": "Netherlands",
            "soccerPlayers": [
              { "name": "Jugador1-Netherlands", "fieldPos":"MIDDLE", "salary": 10000 }
            ]
          },
          "startDate":"2014/06/13-20:00"
        },
        {
          "_id":"4-CHIAUS",
          "soccerTeamA":{
            "id": "CHI",
            "name": "Chile",
            "soccerPlayers": [
              { "name": "Jugador1-Chile", "fieldPos":"GOALKEEPER", "salary": 10000 }
            ]
          },
          "soccerTeamB":{
            "id": "AUS",
            "name": "Australia",
            "soccerPlayers": [
              { "name": "Jugador1-Australia", "fieldPos":"FORWARD", "salary": 10000 }
            ]
          },
          "startDate":"2014/06/13-23:00"
        }
      ]
  """;
}