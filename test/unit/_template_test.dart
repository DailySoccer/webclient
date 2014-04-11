part of webclient_test;

testTemplate() {
  group("[Template]", (){
    group("[valid]", (){
      test("true si sabe sumar", (){
        expect(1+1, 2, reason: "1+1 inválido");
      });
    });
  });
}