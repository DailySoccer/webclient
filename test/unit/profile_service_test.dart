part of webclient_test;

testProfileService() {
  group("[ProfileService]", () {
    group("[valid]", () {
      ProfileService profileService;
      String firstName, lastName, email, nickName, password;

      setUp(() {
        // En los tests no queremos que carge el profile del localStorage, puesto que en general se queda ahi de ejecuciones anteriores
        profileService = new ProfileService(new MockDailySoccerServer(), tryProfileLoad: false);

        var rand = new Random(new DateTime.now().millisecondsSinceEpoch);

        firstName = "Test FirstName";
        lastName  = "Test LastName";
        email     = "fromtests" + rand.nextInt(0xFFFFFFFF).toString() + "@test.com";
        nickName  = "fromtests" + rand.nextInt(0xFFFFFFFF).toString();
        password  = "test";
      });

      test("Se hace signup correctamente de un usuario", () {

        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((jsonObject) {
              expect(profileService.isLoggedIn, isFalse, reason: "Shouldn't be logged in");
              expect(profileService.user, isNull, reason: "User shouldn't exist");
              expect(jsonObject.result, equals("ok"), reason: "Server should return ok");
            });
      });

      test("Se hace correctamente login de un usuario existente", () {

        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((_) => profileService.login(email, password))
            .then((_) {
              expect(profileService.isLoggedIn, isTrue, reason: "No login");
              expect(profileService.user, isNotNull, reason: "User should exist");
              expect(profileService.user.firstName, equals(firstName), reason: "Same firstName");
              expect(profileService.user.lastName, equals(lastName), reason: "Same lastName");
              expect(profileService.user.email, equals(email), reason: "Same email");
              expect(profileService.user.nickName, equals(nickName), reason: "Same nickName");
            });
      });

      test("Se hace correctamente logout del usuario actual", () {

        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((_) => profileService.login(email, password))
            .then((_) => profileService.logout())
            .then((_) {
              expect(profileService.isLoggedIn, isFalse, reason: "No logout");
              expect(profileService.user, isNull, reason: "User should be null");
            });
      });

      test("No se puede registrar el usuario 2 veces", () {
        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((_) => profileService.signup(firstName, lastName, email, nickName, password))
            .then((_) {
              fail("usuario registrado 2 veces");
            })
            .catchError((error) {
              expect(error, new JsonObject.fromJsonString(MockDailySoccerServer.JSON_ERR_ALREADY_SIGNEDUP));
            });
      });

      test("No se puede hacer login sin estar registrado", () {
        return profileService.login(email, password)
            .then((_) {
              fail("login de un usuario no registrado");
            })
            .catchError((error) {
              expect(error, new JsonObject.fromJsonString(MockDailySoccerServer.JSON_ERR_INVALID_LOGIN));
            });
      });

      test("No se puede hacer login con un password incorrecto", () {
        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((_) => profileService.login(email, "invalido"))
            .then((_) {
              fail("login con un password incorrecto");
            })
            .catchError((error) {
              expect(error, new JsonObject.fromJsonString(MockDailySoccerServer.JSON_ERR_INVALID_LOGIN));
            });
      });

      skip_test("true si no se puede hacer logout sin estar login", () {
        expect(profileService.logout(), throws);
      });

    });
  });
}