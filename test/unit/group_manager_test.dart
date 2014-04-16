part of webclient_test;

testGroupManager(){
  group("[GroupManager]", (){
    group("[valid]", (){
      var matchManager, groupManager;
      
      setUp((){
        var mockServer = new MockDailySoccerServer();
        matchManager = new MatchManager( mockServer );
        groupManager = new GroupManager( mockServer, matchManager );
      });
      
      test("true si proporciona correctamente las fechas de comienzo de un match group", (){
        Future result = groupManager.all;
        return result.then( (_) {
            expect(groupManager.startDate("1-001"), "2014/06/12-21:00");
        });
      });
    });
  });
}