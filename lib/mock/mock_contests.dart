part of mock_daily_soccer_http;

class MockContests {
  var all;

  MockContests() {
    all = new JsonObject.fromJsonString(JSON);
  }

  static String JSON = """
  { "content":
      [
        { 
          "_id": "001001001001001001001001", 
          "name": "", 
          "currentEntries": 1,
          "maxEntries": 66,
          "salaryCap": 60000, 
          "entryFee": 10,
          "prizeType": "STANDARD", 
          "matchEventIds": ["1-BRACRO", "2-MEXCMR"]
        },
        { 
          "_id": "002002002002002002002002", 
          "name": "", 
          "currentEntries": 7,
          "maxEntries": 10,
          "salaryCap": 1200000, 
          "entryFee": 20,
          "prizeType": "STANDARD", 
          "matchEventIds": ["3-ESPNED", "4-CHIAUS"]
        }
      ]
    }
  """;
}