part of webclient_test;

testProfileService() {
  group("[ProfileService]", () {
    group("[valid]", () {
      ProfileService profileService;
      String firstName, lastName, email, nickName, password;

      setUp(() {
        // En los tests no queremos que se carge nada del localstorage (en general se queda ahi de ejecuciones anteriores)
        window.localStorage.clear();

        var rand = new Random(new DateTime.now().millisecondsSinceEpoch);

        firstName = "Test FirstName";
        lastName  = "Test LastName";
        email     = "fromtests" + rand.nextInt(0xFFFFFFFF).toString() + "@test.com";
        nickName  = "fromtests" + rand.nextInt(0xFFFFFFFF).toString();
        password  = "test";

        profileService = new ProfileService(new MockDailySoccerServer());
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
              expect(profileService.isLoggedIn, isTrue, reason: "Must be login in");
              expect(profileService.user, isNotNull, reason: "User must exist");
              expect(profileService.user.firstName, equals(firstName), reason: " The firstName must be equal");
              expect(profileService.user.lastName, equals(lastName), reason: "The lastName must be equal");
              expect(profileService.user.email, equals(email), reason: "The email must be equal");
              expect(profileService.user.nickName, equals(nickName), reason: "The nickName must be equal");
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

      test("No se puede hacer logout sin estar login", () {
        expect(() => profileService.logout(), throws);
      });
    });
  });
}