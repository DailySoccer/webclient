part of webclient_test;

testUserManager() {
  group("[UserManager]", (){
    group("[valid]", (){
      var userManager;
      
      setUp( () {
        userManager = new UserManager();
      });
      
      test("true si registra correctamente un usuario", (){
        User user = new User()
          ..fullName  = "Nombre Apellido1 Apellido2"
          ..email     = "email@domain.com"
          ..nickName  = "myNick"
          ..password  = "secreto";
        
        Future result = userManager.register( user );
        return result.then( (_) {
          expect( user.isRegistered, isTrue, reason: "No registrado" );
          expect( userManager.currentUser.isRegistered, isTrue, reason: "No registrado" );
          expect( userManager.currentUser.registerInfo, equals(user.registerInfo), reason: "currentUser no actualizado" );
        });
      });
      
      test("true si hace correctamente un login de usuario", (){
        User user = new User()
          ..fullName  = "Nombre Apellido1 Apellido2"
          ..email     = "email@domain.com"
          ..nickName  = "myNick"
          ..password  = "secreto";
        
        Future result = userManager.login( user );
        return result.then( (_) {
          expect( user.isLogin, isTrue, reason: "No login" );
          expect( userManager.currentUser.isLogin, isTrue, reason: "No login" );
          expect( userManager.currentUser.loginInfo, equals(user.loginInfo), reason: "currentUser distinto" );
        });
      });
      
    });
  });
}