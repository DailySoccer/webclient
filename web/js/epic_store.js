/**
STORE
**/

var epicStoreIsInit = false;

var epicStore = {

  ready: function(){
	  if (!window.store) {
	    window.serverLoggerServere('Store not available');
	    return;
	  }
	  store.verbosity = store.INFO;
	  // Log all errors
	  store.error(function(error) {
	    window.serverLoggerServere('Store Error => ' + error.code + ': ' + error.message);
	  });
	
	  store.ready(function() {
	    store.validator = getDomain()+"/store/validator";
	    store.refresh();
	    paymentServiceReady();
	    console.log("# STORE READY ");
	  });
  },
  afterInit: function (callback) {
    var tryCall;
    tryCall = function (callback) {
      if (epicStoreIsInit === false) {
        setTimeout(function() { tryCall(callback); }, 100);
      } else {
        facebookConnectPlugin.getLoginStatus(
          function (status) {
            callback();
          }, function (error) {
            window.serverLoggerServere(error);
          }
        );
      }
    };
    tryCall(callback);
  },
  registerConsumable: function(productList) {
    for (var i = 0; i < productList.length; i++) {
      store.register({
          id:    productList[i]['storeId'],
          alias: productList[i]['id'],
          type:  store.CONSUMABLE
      });
      console.log("REGISTER");
      console.log(productList[i]['storeId']);
      console.log(productList[i]['id']);
      console.log(store.CONSUMABLE);
      store.when(productList[i]['storeId']).loaded(function(p) {
        
        console.log("Loaded: " + p['id']);
        console.log("Product.alias: " + p['alias']);
        console.log("Product.title: " + p['title']);
        console.log("Product.price: " + p['price']);
        
        updateProductInfo(p['alias'], p['title'], p['price']);
      });
      store.when(productList[i]['storeId']).initiated(function(p) {
        console.log("Initiated: " + p['id']);
      });
      store.when(productList[i]['storeId']).cancelled(function(p) {
        console.log("Cancelled: " + p['id']);
      });
  	  store.when(productList[i]['storeId']).approved(function (order) {
  	  	console.log(" # DEVICE READY EVENT - SHOP -> store.approved");
      	order.verify();
      });
      store.when(productList[i]['storeId']).verified(function (order) {
      	console.log(" # DEVICE READY EVENT - SHOP -> store.verified");
      	
      	
        getPlatform(function(s) {
          var transactionId = "";
          if (s === "Android") {
            transactionId = order['transaction']['purchaseToken'];
          } else {
            transactionId = order['transaction']['id'];
          }
          paymentServiceCheckout(order, order['alias'], order['transaction']['type'], transactionId);
        });
      	
        //paymentServiceCheckout(order, order['alias'], order['transaction']['type'], order['transaction']['purchaseToken']); // order['transaction']['id']
      });
    }
    store.refresh();
  },
  refresh: function() {
    store.refresh();
  },
  buyConsumable: function(alias) {
    console.log("Request to get " + alias + "!");
    store.order(alias);
  },
  finishOrder: function(order, result) {
    console.log("finishOrder " + order['id'] + ": " + result + "!");
    order.finish();
  }
};