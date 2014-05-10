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

      test("Se obtiene la lista de partidos de un contest", () {
        return contestService.refreshActiveContests()
            .then((x) {
              var contest = contestService.getContestById("001001001001001001001001");
              expect(contestService.getContestById("001001001001001001001001").name, equals("001001001001001001001001 contest"));

              List<MatchEvent> matchEvents = contestService.getMatchEventsForContest(contest);
              expect(matchEvents.length, equals(2));
            });
      });

      test("Se obtiene la fecha de comienzo de un contest", () {
        return contestService.refreshActiveContests()
            .then((x) {
              var contest = contestService.getContestById("001001001001001001001001");
              var startDate = contestService.getContestStartDate(contest);

              expect(startDate, equals(new DateTime.utc(2014, 10, 14, 12, 0, 0, 0)));
            });
      });

    });
  });
}