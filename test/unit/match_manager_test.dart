part of webclient_test;

testMatchManager(){
  group("[MatchManager]", (){
    group("[valid]", (){
      var matchManager;
      
      setUp((){
        matchManager = new MatchManager( new MockDailySoccerServer() );
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un match", (){
        Future result = matchManager.all;
        return result.then( (_) {
            expect(matchManager.startDate("1-BRACRO"), "2014/06/12-21:00");
            expect(matchManager.startDate("2-MEXCMR"), "2014/06/13-17:00");
            expect(matchManager.startDate("3-ESPNED"), "2014/06/13-20:00");
            expect(matchManager.startDate("4-CHIAUS"), "2014/06/13-23:00");
          });
      });
    });
  });
}