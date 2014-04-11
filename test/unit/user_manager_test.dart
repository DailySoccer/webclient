part of webclient_test;

testUserManager() {
  group("[UserManager]", (){
    group("[valid]", (){
      var userManager;
      var user;
      
      setUp( () {
        userManager = new UserManager();
        
        user = new User()
          ..fullName  = "Nombre Apellido1 Apellido2"
          ..email     = "email@domain.com"
          ..nickName  = "myNick"
          ..password  = "secreto";
      });
      
      test("true si registra correctamente un usuario", (){
        Future result = userManager.register( user );
        return result.then( (_) {
          expect( user.isRegistered, isTrue, reason: "No registrado" );
          expect( userManager.currentUser.isRegistered, isTrue, reason: "No registrado" );
          expect( userManager.currentUser.registerInfo, equals(user.registerInfo), reason: "currentUser no actualizado" );
          expect( userManager.existsUser(user.email), isTrue, reason: "user no existe");
        });
      });
      
      test("true si hace correctamente un login de usuario", (){
        Future result = userManager.register( user )
          .then( (_) => userManager.login( user ) );
        return result.then( (_) {
          expect( user.isLogin, isTrue, reason: "No login" );
          expect( userManager.currentUser.isLogin, isTrue, reason: "No login" );
          expect( userManager.currentUser.loginInfo, equals(user.loginInfo), reason: "currentUser distinto" );
          expect( userManager.existsUser(user.email), isTrue, reason: "user no existe");
        });
      });

      test("true si hace correctamente un logout del usuario actual", (){
        Future result = userManager.register( user )
          .then( (_) => userManager.login( user ) )
          .then( (_) => userManager.logout() );
        return result.then( (_) {
          expect( userManager.currentUser.isLogin, isFalse, reason: "No logout" );
          expect( userManager.existsUser(user.email), isTrue, reason: "user no existe");
        });
      });

      test("true si no se puede registrar el usuario 2 veces", (){
        Future result = userManager.register( user )
          .then( (_) => userManager.register( user ) );
        return result.then( (_) {
          fail( "usuario registrado 2 veces" );
        })
        .catchError( (error) {
          expect( error, userManager.ERR_YA_REGISTRADO );
        });
      });

      test("true si no se puede hacer login sin estar registrado", (){
        Future result = userManager.login( user );
        return result.then( (_) {
          fail( "login de un usuario no registrado" );
        })
        .catchError( (error) {
          expect( error, userManager.ERR_NO_REGISTRADO );
        });
      });

      test("true si no se puede hacer login con un password incorrecto", (){
        Future result = userManager.register( user )
          .then ( (_) { user.password = "invalido"; return userManager.login( user ); } );
        return result.then( (_) {
          fail( "login con un password incorrecto" );
        })
        .catchError( (error) {
          expect( error, userManager.ERR_NO_REGISTRADO );
        });
      });
      
      test("true si no se puede hacer logout sin estar login", (){
        Future result = userManager.logout();
        return result.then( (_) {
          fail( "logout sin estar login" );
        })
        .catchError( (error) {
          expect( error, userManager.ERR_NO_LOGIN );
        });
      });
      
    });
  });
}