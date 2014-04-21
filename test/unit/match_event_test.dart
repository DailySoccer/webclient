part of webclient_test;

testMatchDay(){
  group("[MatchEvent]", (){
    group("[valid]", (){
      test("true si se inicializa correctamente desde un json", (){
        final json = """
        [
          {
            "id":"1-BRACRO",
            "teamA":{
              "id": "BRA",
              "name": "Brazil",
              "soccers": [
                { "id": "1-BRA", "name": "Jugador1-Brazil" }
              ]
            },
            "teamB":{
              "id": "CRO",
              "name": "Croatia",
              "soccers": [
                { "id": "1-CRO", "name": "Jugador1-Croatia" }
              ]
            },
            "date":"2014/06/12-21:00"
          }
        ]        
        """;
        final el = new JsonObject.fromJsonString( json );
        final item = new MatchEvent.fromJsonObject(el[0]);
        expect(item.id, "1-BRACRO");
        expect(item.teamA.id, "BRA");
        expect(item.teamB.id, "CRO");
        expect(item.date, "2014/06/12-21:00");
      });
    });
  });
}
