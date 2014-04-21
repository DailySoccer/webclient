part of webclient_test;

testMatchGroupService(){
  group("[MatchGroupService]", (){
    group("[valid]", (){
      var matchService, matchGroupService;
      
      setUp((){
        var mockServer = new MockDailySoccerServer();
        matchService = new MatchService(mockServer);
        matchGroupService = new MatchGroupService(mockServer, matchService);
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un match group", (){
        Future result = matchGroupService.getAllMatchGroups();
        return result.then( (_) {
            expect(matchGroupService.getMatchGroupStartDate("1-001"), "2014/06/12-21:00");
        });
      });
    });
  });
}