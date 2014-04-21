part of webclient_test;

testProfileService() {
  group("[UserManager]", (){
    group("[valid]", (){
      var profileService;
      String firstName, lastName, email, nickName, password;      
      
      setUp( () {
        /*
        setUpInjector();
        
        module((module) {
              module
                ..type( AbstractHttp, implementedBy: MockDailySoccerServer );
            });
            
        inject((UserManager u) { userManager = u; });
        */
        
        profileService = new ProfileService(new MockDailySoccerServer());
        
        firstName = "Test One Two";
        lastName  = "Three Four";
        email     = "test@test.com";
        nickName  = "nick";
        password  = "test";        
      });
      
      test("true si registra correctamente un usuario", (){
        /*
        Future result = profileService.signup( firstName, lastName, email, nickName, password );
        return result.then( (_) {
          expect( profileService.user.isRegistered, isTrue, reason: "No registrado" );
          expect( profileService.currentUser.registerInfo, equals(user.registerInfo), reason: "currentUser no actualizado" );
          expect( profileService.get(user.email).isRegistered, isTrue, reason: "No registrado" );
          expect( profileService.exists(user.email), isTrue, reason: "user no existe");
        });
        */
      });
      
      test("true si hace correctamente un login de usuario", (){
        /*
        Future result = profileService.register( user )
          .then( (_) => profileService.login( user ) );
        return result.then( (_) {
          expect( profileService.currentUser.isLogin, isTrue, reason: "No login" );
          expect( profileService.currentUser.loginInfo, equals(user.loginInfo), reason: "currentUser distinto" );
          expect( profileService.currentUser.registerInfo, equals(user.registerInfo), reason: "currentUser no actualizado" );
          expect( profileService.get(user.email).isLogin, isTrue, reason: "No login" );
          expect( profileService.exists(user.email), isTrue, reason: "user no existe");
        });
        */
      });

      test("true si hace correctamente un logout del usuario actual", (){
        /*
        Future result = profileService.register( user )
          .then( (_) => profileService.login( user ) )
          .then( (_) => profileService.logout() );
        return result.then( (_) {
          expect( profileService.currentUser.isLogin, isFalse, reason: "No logout" );
          expect( profileService.get(user.email).isLogin, isFalse, reason: "No login" );
          expect( profileService.exists(user.email), isTrue, reason: "user no existe");
        });
        */
      });

      test("true si no se puede registrar el usuario 2 veces", (){
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
      
      test("true si no se puede hacer login sin estar registrado", (){
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

      test("true si no se puede hacer login con un password incorrecto", (){
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
      
      test("true si no se puede hacer logout sin estar login", (){
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