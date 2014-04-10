part of webclient_test;

testMatchDay(){
  group("[MatchDay]", (){
    group("[valid]", (){
      test("true si se inicializa correctamente desde un json", (){
        final json = """
        [
          {
          "id":"1-BRACRO",
          "teamIdA":"BRA",
          "teamIdB":"CRO",
          "date":"2014/06/12-21:00"
          }
        ]        
        """;
        final el = new JsonObject.fromJsonString( json );
        final item = new MatchDay.initFromJSONObject(el[0]);
        expect(item.id == "1-BRACRO", isTrue, reason: "id inválido");
        expect(item.teamIdA == "BRA", isTrue, reason: "teamIdA inválido");
        expect(item.teamIdB == "CRO", isTrue, reason: "teamIdB inválido");
        expect(item.date == "2014/06/12-21:00", isTrue, reason: "date inválido");
      });
    });
  });
}
