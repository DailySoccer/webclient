part of mock_daily_soccer_http;

class MockContests {
  var all;

  MockContests() {
    all = new JsonObject.fromJsonString(JSON);
  }

  static int _startDate = 1413288000000;
  
  static String JSON = """
  { 
    "match_events": [
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
          "startDate": $_startDate
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
          "startDate": $_startDate
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
          "startDate": $_startDate
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
          "startDate": $_startDate
        }
     ],
    "template_contests": [
      {
        "_id":  "001001001001001001001001",
        "name": "001001001001001001001001 contest",
        "postName": "",
        "maxEntries": 66,
        "salaryCap": 60000,
        "entryFee": 10,
        "prizeType": "STANDARD",
        "templateMatchEventIds": ["1-BRACRO", "2-MEXCMR"]
      },
      { 
        "_id":  "002002002002002002002002",
        "name": "002002002002002002002002 contest",
        "postName": "",
        "maxEntries": 10,
        "salaryCap": 1200000,
        "entryFee": 20,
        "prizeType": "STANDARD",
        "templateMatchEventIds": ["3-ESPNED", "4-CHIAUS"]
      }
    ],
    "contests": [
      { 
        "_id": "001001001001001001001001", 
        "name": "001001001001001001001001 contest", 
        "currentUserIds": ["1"],
        "maxUsers": 66,
        "templateContestId": "001001001001001001001001"
      },
      { 
        "_id": "002002002002002002002002", 
        "name": "002002002002002002002002 contest", 
        "currentUserIds": ["7"],
        "maxUsers": 10,
        "templateContestId": "002002002002002002002002"
      }
    ]
  }
  """;
}