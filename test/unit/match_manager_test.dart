part of webclient_test;

testMatchManager(){
  group("[MatchManager]", (){
    group("[valid]", (){
      var matchManager;
      
      setUp((){
        final json = """
        [
          { "id":"1-BRACRO", "teamIdA":"BRA", "teamIdB":"CRO", "date":"2014/06/12-21:00" },
          { "id":"2-MEXCMR", "teamIdA":"MEX", "teamIdB":"CMR", "date":"2014/06/13-17:00" },
          { "id":"3-ESPNED", "teamIdA":"ESP", "teamIdB":"NED", "date":"2014/06/13-20:00" },
          { "id":"4-CHIAUS", "teamIdA":"CHI", "teamIdB":"AUS", "date":"2014/06/13-23:00" }
        ]
          """;
        matchManager = new MatchManager.initFromJson(json);
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un match", (){
        expect(matchManager.startDate("1-BRACRO") == "2014/06/12-21:00", isTrue, reason: "startDate(1-BRACRO) inválido");
        expect(matchManager.startDate("2-MEXCMR") == "2014/06/13-17:00", isTrue, reason: "startDate(2-MEXCMR) inválido");
        expect(matchManager.startDate("3-ESPNED") == "2014/06/13-20:00", isTrue, reason: "startDate(3-ESPNED) inválido");
        expect(matchManager.startDate("4-CHIAUS") == "2014/06/13-23:00", isTrue, reason: "startDate(4-CHIAUS) inválido");
      });
    });
  });
}