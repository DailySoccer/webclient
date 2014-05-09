part of webclient_test;

testContestService(){
  group("[ContestService]", (){
    group("[valid]", (){
      ContestService contestService;

      setUp((){
        var mockServer = new MockDailySoccerServer();
        contestService = new ContestService(mockServer);
      });

      test("Se refrescan los concursos", () {
        return contestService.refreshActiveContests()
            .then((ContestsPack contestsPack) {
              expect(contestsPack.contests.length, equals(2));
            });
      });

    });
  });
}