part of webclient_test;

testContestService(){
  group("[ContestService]", (){
    group("[valid]", (){
      var matchService, matchGroupService, contestService;
      
      setUp((){
        var mockServer = new MockDailySoccerServer();
        matchService = new MatchService(mockServer);
        matchGroupService = new MatchGroupService(mockServer, matchService);
        contestService = new ContestService(mockServer, matchGroupService);
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un contest", (){
        Future result = contestService.getAllContests();
        return result.then( (_) {
            expect(contestService.getContestStartDate("1-001"), "2014/06/12-21:00");
        });
      });
    });
  });
}