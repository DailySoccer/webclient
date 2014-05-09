part of mock_daily_soccer_http;

class MockGroups {
  var  groups;

  MockGroups() {
    groups = new JsonObject.fromJsonString(JSON);
  }

  static String JSON = """
  [
    {
      "id":"1-001",
      "matchsIds": ["1-BRACRO", "2-MEXCMR", "3-ESPNED", "4-CHIAUS"]
    }
  ]
  """;
}