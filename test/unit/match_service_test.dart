part of webclient_test;

testMatchService(){
  group("[MatchService]", (){
    group("[valid]", (){
      var matchService;
      
      setUp((){
        matchService = new MatchService(new MockDailySoccerServer());
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un match", (){
        Future result = matchService.getAllMatchEvents();
        return result.then( (_) {
            expect(matchService.getMatchStartDate("1-BRACRO"), "2014/06/12-21:00");
            expect(matchService.getMatchStartDate("2-MEXCMR"), "2014/06/13-17:00");
            expect(matchService.getMatchStartDate("3-ESPNED"), "2014/06/13-20:00");
            expect(matchService.getMatchStartDate("4-CHIAUS"), "2014/06/13-23:00");
          });
      });
    });
  });
}