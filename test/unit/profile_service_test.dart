part of webclient_test;

testProfileService() {
  group("[ProfileService]", (){
    group("[valid]", () {
      ProfileService profileService;
      String firstName, lastName, email, nickName, password;

      setUp(() {
        // En los tests no queremos que carge el profile del localStorage, puesto que en general se queda ahi de ejecuciones anteriores
        profileService = new ProfileService(new MockDailySoccerServer(), tryProfileLoad: false);

        var rand = new Random(new DateTime.now().millisecondsSinceEpoch);

        firstName = "Test One Two";
        lastName  = "Three Four";
        email     = "fromtests" + rand.nextInt(0xFFFFFFFF).toString() + "@test.com";
        nickName  = "fromtests" + rand.nextInt(0xFFFFFFFF).toString();
        password  = "test";
      });

      test("true si hace signup correctamente un usuario", () {

        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((jsonObject) {
              expect(profileService.isLoggedIn, isFalse, reason: "Shouldn't be logged in");
              expect(profileService.user, isNull, reason: "User shouldn't exist");
              expect(jsonObject.result, equals("ok"), reason: "Server should return ok");
            });
      });

      test("true si hace correctamente un login", () {

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

      test("true si hace correctamente un logout del usuario actual", () {

        return profileService.signup(firstName, lastName, email, nickName, password)
            .then((_) => profileService.login(email, password))
            .then((_) => profileService.logout())
            .then((_) {
              expect(profileService.isLoggedIn, isFalse, reason: "No logout");
              expect(profileService.user, isNull, reason: "User should be null");
            });
      });

      test("true si no se puede registrar el usuario 2 veces", () {
        /*
        Future result = profileService.register( user )
          .then( (_) => profileService.register( user ) );
        return result.then( (_) {
          fail( "usuario registrado 2 veces" );
        })
        .catchError( (error) {
          expect( error, profileService.ERR_YA_REGISTRADO );
        });
        */
      });

      test("true si no se puede hacer login sin estar registrado", () {
        /*
        Future result = profileService.login( user );
        return result.then( (_) {
          fail( "login de un usuario no registrado" );
        })
        .catchError( (error) {
          expect( error, profileService.ERR_NO_REGISTRADO );
        });
        */
      });

      test("true si no se puede hacer login con un password incorrecto", () {
        /*
        Future result = profileService.register( user )
          .then ( (_) { user.password = "invalido"; return profileService.login( user ); } );
        return result.then( (_) {
          fail( "login con un password incorrecto" );
        })
        .catchError( (error) {
          expect( error, profileService.ERR_NO_REGISTRADO );
        });
        */
      });

      test("true si no se puede hacer logout sin estar login", () {
        /*
        Future result = profileService.logout();
        return result.then( (_) {
          fail( "logout sin estar login" );
        })
        .catchError( (error) {
          expect( error, profileService.ERR_NO_LOGIN );
        });
        */
      });

    });
  });
}