/**
STORE
**/

var epicStoreIsInit = false;

var epicStore = {
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
      store.when(productList[i]['storeId']).loaded(function(p) {
        /*
        console.log("Loaded: " + p['id']);
        console.log("Product.alias: " + p['alias']);
        console.log("Product.title: " + p['title']);
        console.log("Product.price: " + p['price']);
        */
        updateProductInfo(p['alias'], p['title'], p['price']);
      });
      store.when(productList[i]['storeId']).initiated(function(p) {
        console.log("Initiated: " + p['id']);
      });
      store.when(productList[i]['storeId']).cancelled(function(p) {
        console.log("Cancelled: " + p['id']);
      });
      store.when(productList[i]['storeId']).approved(function (order) {
        console.log("You got an " + order + "!");

        /*
        console.log("Product.id: " + order['id']);
        console.log("Product.alias: " + order['alias']);
        console.log("Product.type: " + order['type']);
        console.log("Product.state: " + order['state']);
        console.log("Product.title: " + order['title']);
        console.log("Product.description: " + order['description']);
        console.log("Product.price: " + order['price']);
        console.log("Product.currency: " + order['currency']);
        console.log("Product.loaded: " + order['loaded']);
        console.log("Product.valid: " + order['valid']);
        console.log("Product.canPurchase: " + order['canPurchase']);
        console.log("Product.owned: " + order['owned']);
        console.log("Product.downloading: " + order['downloading']);
        console.log("Product.downloaded: " + order['downloaded']);
        console.log("Product.transaction: " + order['transaction']);
        console.log("Product.transaction.type: " + order['transaction']['type']);
        console.log("Product.transaction.id: " + order['transaction']['id']);
        */

        paymentServiceCheckout(order, order['alias'], order['transaction']['type'], order['transaction']['id']);
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