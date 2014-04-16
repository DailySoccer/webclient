part of webclient_test;

testContestManager(){
  group("[ContestManager]", (){
    group("[valid]", (){
      var matchManager, groupManager, contestManager;
      
      setUp((){
        var mockServer = new MockDailySoccerServer();
        matchManager = new MatchManager( mockServer );
        groupManager = new GroupManager( mockServer, matchManager );
        contestManager = new ContestManager( mockServer, groupManager );
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un contest", (){
        Future result = contestManager.all;
        return result.then( (_) {
            expect(contestManager.startDate("1-001"), "2014/06/12-21:00");
        });
      });
    });
  });
}