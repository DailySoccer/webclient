part of webclient_test;

testContestService(){
  group("[ContestService]", () {
    group("[valid]", () {

      ContestService contestService;

      setUp((){
        var mockServer = new MockDailySoccerServer();
        contestService = new ContestService(mockServer);
      });

      test("Se refrescan los concursos", () {
        return contestService.refreshActiveContests()
            .then((x) {
              expect(contestService.activeContests.length, equals(2));
              expect(contestService.activeMatchEvents.length, equals(4));
            });
      });

    });
  });
}