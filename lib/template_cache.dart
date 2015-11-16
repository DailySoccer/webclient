// GENERATED, DO NOT EDIT!
library template_cache;

import 'package:angular/angular.dart';

primeTemplateCache(TemplateCache tc) {
tc.put("packages/webclient/components/account/add_funds_comp.html", new HttpResponse(200, r"""<div id="addFundsContent">

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText("title")}}</div>

  <div>
    <div class="description">
      <p id="descriptionTip1">{{getLocalizedText("description1")}}</p>
      <p id="descriptionTip2">{{getLocalizedText("description2")}}</p>
    </div>
    <div class="add-founds-box">
      <p>{{getLocalizedText("minfunds")}}{{formatCurrency("10")}}</p>
      <div class="money-selector">
        <div class="money-element">
          <input type="radio" name="money-radio" id="firstOffer" value="10"><label for="firstOffer">{{formatCurrency("10")}}</label>
        </div>
        <div class="money-element">
          <input type="radio" name="money-radio" id="secondOffer" value="25" checked="checked"><label for="secondOffer">{{formatCurrency("25")}}</label>
        </div>
        <div class="money-element">
          <input type="radio" name="money-radio" id="thirdOffer" value="50"><label for="thirdOffer">{{formatCurrency("50")}}</label>
        </div>
        <div class="money-element custom-money-element">
          <input type="radio" name="money-radio" id="customEuros">
          <input type="number" id="customEurosAmount" value="10"><label for="customEuros">{{formatCurrency("")}}</label>
        </div>
      </div>
      <h2 class="paypal-info">Add <span id="selectedAmountInfo">{{formatCurrency(selectedValue.toString())}}</span> {{getLocalizedText("via")}} <img src="images/markPaypalMed.jpg"></h2>
      <p class="paypal-info">{{getLocalizedText("paypalinfo")}}</p>
      <div class="button-wrapper"><button class="add-funds-button" id="addFundsButton">{{getLocalizedText("buttonaddfunds")}}</button></div>
    </div>
  </div>
  <div class="need-help-box">
    <p id="need-help-text">{{getLocalizedText("needhelp")}}</p>
    <p id="need-help-email">support@epiceleven.com</p>
  </div>

  <!-- Comentado hasta que tengamos los textos legales

  <div class="pay-faq-block">
    <h1 class="pay-faq-title">Preguntas frecuentes sobre el pago</h1>
    <div class="toogle-block">
      <input type="checkbox" id="rule1" class="toggle">
      <label for="rule1">Por qué estoy pagando exactamente</label>
      <div>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis placerat leo quis pellentesque. Proin sollicitudin vel felis vulputate varius. Aenean non ante nec dolor sagittis ornare sit amet vel diam. Etiam eu dui at odio tempor eleifend. Nunc urna justo, volutpat sed mollis efficitur, venenatis id purus. Fusce elementum tellus in ligula maximus, in aliquet erat tincidunt. Aenean mollis sollicitudin tincidunt. Etiam ac velit eu erat placerat condimentum. Donec lorem tortor, convallis pretium finibus eu, euismod eget dolor. </p>
      </div>
    </div>
    <div class="toogle-block">
      <input type="checkbox" id="rule2" class="toggle">
      <label for="rule2">¿Cuánto puedo ganar?</label>
      <div>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis placerat leo quis pellentesque. Proin sollicitudin vel felis vulputate varius. Aenean non ante nec dolor sagittis ornare sit amet vel diam. Etiam eu dui at odio tempor eleifend. Nunc urna justo, volutpat sed mollis efficitur, venenatis id purus. Fusce elementum tellus in ligula maximus, in aliquet erat tincidunt. Aenean mollis sollicitudin tincidunt. Etiam ac velit eu erat placerat condimentum. Donec lorem tortor, convallis pretium finibus eu, euismod eget dolor. </p>
      </div>
    </div>
    <div class="toogle-block">
      <input type="checkbox" id="rule3" class="toggle">
      <label for="rule3">¿Es este juego legal en España y la Unión Europea?</label>
      <div>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis placerat leo quis pellentesque. Proin sollicitudin vel felis vulputate varius. Aenean non ante nec dolor sagittis ornare sit amet vel diam. Etiam eu dui at odio tempor eleifend. Nunc urna justo, volutpat sed mollis efficitur, venenatis id purus. Fusce elementum tellus in ligula maximus, in aliquet erat tincidunt. Aenean mollis sollicitudin tincidunt. Etiam ac velit eu erat placerat condimentum. Donec lorem tortor, convallis pretium finibus eu, euismod eget dolor. </p>
      </div>
    </div>
  </div>
   Comentado hasta que tengamos los textos legales -->


  <ng-view></ng-view>
  <!--div class="default-header-text"> MI CUENTA </div>
  <div class="blue-separator"></div>
  <div class="profile-content">

    <div class="personal-data">
      <div class="data-header">
        <span class="data-header-title">INFORMACION PERSONAL</span>
        <div class="button-wrapper"><button class="action-button" ng-click="editPersonalData()">EDITAR</button></div>
      </div>
      <div class="bloque-sm">
        <div class="data-row"><span class="data-key">Nombre personal:</span><span class="data-value">{{userData.firstName + ' ' + userData.lastName}}</span></div>
        <div class="data-row"><span class="data-key">Nombre de usuario:</span><span class="data-value">{{userData.nickName}}</span></div>
        <div class="data-row"><span class="data-key">Correo electrónico:</span><span class="data-value">{{userData.email}}</span></div>
        <div class="data-row"><span class="data-key">Contraseña:</span><span class="data-value">********</span></div>
      </div>
      <!--
      <div class="bloque-sm">
        <div class="data-row"><span class="data-key">Pais:</span><span class="data-value">&lt; Pais &gt;</span></div>
        <div class="data-row"><span class="data-key">Region:</span><span class="data-value">&lt; Region &gt;</span></div>
        <div class="data-row"><span class="data-key">Ciudad:</span><span class="data-value">&lt; Ciudad &gt;</span></div>
        <div class="data-row"><span class="data-key">Notificaciones:</span><span class="data-value">&lt; Notificaciones &gt;</span></div>
      </div>
      -->
    <!--/div-->

    <!--
    <div class="pocket-data">
      <div class="data-header">
          <span class="data-header-title">MONEDERO</span>
          <div class="button-wrapper">
            <button class="action-button-transaction">TRANSACCIONES</button>
            <button class="action-button-get-funds">RETIRAR FONDOS</button>
          </div>
       </div>
      <div class="data-container-9">
        <div class="data-row"><span class="data-key">Balance actual:</span><span class="data-value-balance">&lt;balance&gt;€</span></div>
        <div class="data-row"><span class="data-key">Bonus pendientes:</span><span class="data-value">&lt;pending-bonuses&gt;€</span></div>
      </div>
      <div class="data-container-3">
        <button class="add-funds-button">AÑADIR FONDOS</button>
      </div>
    </div>

    <div class="epicpoints-data">
      <div class="data-header"><span class="data-header-title">EPIC POINTS</span></div>
      <div class="data-row">
        <div class="data-column"><span class="data-key">E11P BALANCE:</span><span class="data-value">--€</span></div>
        <div class="data-column"><span class="data-key">&lt;ulti-month&gt;:</span><span class="data-value">--€</span></div>
      </div>
      <div class="data-row">
        <div class="data-column"><span class="data-key">THIS MONTH:</span><span class="data-value">--€</span></div>
        <div class="data-column"><span class="data-key">&lt;penul-month&gt;:</span><span class="data-value">--€</span></div>
        <div class="data-column"><a class="data-link" href="">¿Cómo gastar tus EPs?</a></div>
      </div>
    </div>
    -->

  <!--/div-->
</div>"""));
tc.put("packages/webclient/components/account/change_password_comp.html", new HttpResponse(200, r"""<div id="changePasswordRoot">
  <div id="changePasswordBox" class="main-box air">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div ng-switch="state">
          <!-- SI ES INVALID URL -->
          <div ng-switch-when="STATE_INVALID_URL"     class="panel-title">{{getLocalizedText("error503")}}</div>
          <!-- SI ES TOKEN INVALIDO -->
          <div ng-switch-when="STATE_INVALID_TOKEN"   class="panel-title">{{getLocalizedText("changepass")}}</div>
          <!-- SI ES TOKEN VALIDO/INVALIDO -->
          <div ng-switch-when="STATE_CHANGE_PASSWORD" class="panel-title">{{getLocalizedText("changepass")}}</div>
        </div>

        <button type="button" class="close" ng-click="navigateTo('lobby',{}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>

      </div>
      <div class="panel-body" >

        <form  id="changePasswordForm" class="form-horizontal" ng-submit="changePassword()" role="form">
          <div ng-switch="state">
                <div ng-switch-when="STATE_INVALID_URL" class="form-description">
                  {{getLocalizedText("unavailable")}}
                </div>
                <div ng-switch-when="STATE_INVALID_TOKEN" class="form-description">
                  {{getLocalizedText("tokenexpired")}}
                </div>
                <div ng-switch-when="STATE_CHANGE_PASSWORD">
                  <div class="form-description">
                    {{getLocalizedText("createpass")}}
                  </div>
                  <!-- PASSWORD -->
                  <div  class="user-form-field">
                    <!-- Description -->
                    <div class="new-row bottom-separation-10">
                      <div class="small-text">{{getLocalizedText("passrequires")}}</div>
                    </div>
                    <!-- Field Input 1 -->
                    <div id="passwordInputGroup" class="input-group  bottom-separation-10">
                      <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
                      <input id="password" name="password" type="password"  placeholder="{{getLocalizedText('pass')}}"         ng-model="thePassword"   data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH" class="form-control" tabindex="1" autocapitalize="off" auto-focus>
                    </div>
                    <!-- Field Input 2 -->
                    <div id="rePasswordInputGroup" class="input-group">
                      <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
                      <input id="rePassword" name="password" type="password" placeholder="{{getLocalizedText('repass')}}" ng-model="theRePassword" data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH" class="form-control" tabindex="2" autocapitalize="off">
                    </div>
                    <!-- Error de password -->
                    <div id="errorContainer" class="new-row">
                      <div id="errorLabel" class="pass-err-text">{{errorMessage}}</div>
                    </div>
                  </div>

                  <!-- BUTTONS -->
                  <div class="input-group user-form-field">
                    <div class="new-row">
                      <div class="buttons-wrapper">
                        <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">{{getLocalizedText("buttoncontinue")}}</button>
                        <button id="btnCancelLogin" ng-click="navigateTo('lobby', {}, $event)" class="cancel-button-half">{{getLocalizedText("buttoncancel")}}</button>
                      </div>
                    </div>
                  </div>
                </div>
          </div>
        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/edit_personal_data_comp.html", new HttpResponse(200, r"""<div id="personalDataContent" ng-show="!loadingService.isLoading" ng-cloack>

  <div class="edit-personal-data-header">
    <span class="header-title">{{getLocalizedText("title")}}</span>
  </div>
  <form id="editPersonalDataForm" class="form-horizontal" ng-submit="saveChanges()" role="form" autocomplete="off">
    <div class="content">
      <!-- Nombre -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("name")}}</span></div>
        <div class="control-wrapper">
          <input id="txtName" type="text" ng-model="editedFirstName" placeholder="{{getLocalizedText('name')}}" class="form-control"  tabindex="1">
        </div>
      </div>
      <!-- Apelidos -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("lastname")}}</span></div>
        <div class="control-wrapper">
          <input id="txtLastName" type="text" ng-model="editedLastName" placeholder="{{getLocalizedText('lastname')}}" class="form-control" tabindex="2">
        </div>
      </div>
      <!-- Nickname -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("username")}}</span></div>
        <div class="control-wrapper">
          <input id="txtNickName" type="text" ng-model="editedNickName" placeholder="{{getLocalizedText('username')}}" class="form-control" tabindex="3" autocapitalize="off">
        </div>
        <!-- Error de nickName -->
        <div id="nickNameErrorContainer" class="content-field-block">
          <div id="nickNameErrorLabel" class="err-text"></div>
        </div>
      </div>

      <!-- Correo Electrónico -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("mail")}}</span></div>
        <div class="control-wrapper">
          <input id="txtEmail" type="email" ng-model="editedEmail" placeholder="{{getLocalizedText('mail')}}" class="form-control" tabindex="4" autocapitalize="off">
        </div>
        <!-- Error de mail -->
        <div id="emailErrorContainer" class="content-field-block">
          <div id="emailErrorLabel" class="err-text"></div>
        </div>
      </div>

      <!-- Label Contraseña -->
      <div class="content-field-block">
        <div class="control-wrapper"><span id="lblPassword" class="text-label">{{getLocalizedText("passrequires")}}</span></div>
      </div>
      <!-- Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtPassword" type="password" ng-model="editedPassword" placeholder="{{getLocalizedText('pass')}}" class="form-control" tabindex="5" autocapitalize="off"></div>
      </div>
      <!-- Repetir Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtRepeatPassword" type="password" ng-model="editedRepeatPassword" placeholder="{{getLocalizedText('repass')}}" class="form-control" tabindex="6" autocapitalize="off"></div>
      </div>

      <!-- Error de contraseñas -->
      <div id="passwordErrorContainer" class="content-field-block">
        <div id="passwordErrorLabel" class="err-text"></div>
        <!--  WTF: delete <div class="control-wrapper"><span id="lblPasswordIntructions" class="text-label">Asegúrate al menos que tiene 8 caracteres y que no contiene espacios</span></div> -->
      </div>
      <!-- Pais, Region y Ciudad
      <div class="content-field">
        <div class="control-wrapper"><input id="txtCountry" type="text" ng-model="country" placeholder="País" class="form-control"></div>
      </div>

      <div class="content-field">
        <div class="control-wrapper"><input id="txtRegion" type="text" ng-model="region" placeholder="Región" class="form-control"></div>
      </div>

      <div class="content-field">
        <div class="control-wrapper"><input id="txtCity" type="text" ng-model="city" placeholder="Ciudad" class="form-control"></div>
      </div>
       -->
    </div>
  <!-- Notificaciones -->
    <div class="header">{{getLocalizedText("notifications")}}</div>
    <div class="subscriptions-content">

      <div class="content-field-block">

        <div class="subscription-wrapper">
          <div class="subscription-label">{{getLocalizedText("newletternotifications")}}</div>
          <div class="check-wrapper"> <input type="checkbox" id="inputNewsletter" name="switchNewsletter"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">{{getLocalizedText("gamenotifications")}}</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchGameAlerts"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">{{getLocalizedText("transfernotifications")}}</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchsoccerPlayerAlerts"> </div>
        </div>

      </div>

    </div>

    <div class="save-changes-content">
      <div class="forms-wrapper-button">
        <button id="btnSubmit" class="action-button-save" type="submit">{{getLocalizedText("buttonsave")}}</button>
      </div>
      <div class="forms-wrapper-button">
        <button id="btnSubmit" class="action-button-cancel" ng-click="exit($event)">{{getLocalizedText("buttoncancel")}}</button>
      </div>
    </div>

  </form>
</div>"""));
tc.put("packages/webclient/components/account/energy_shop_comp.html", new HttpResponse(200, r"""<modal id="energyshopComp">

  <!--<div class="header"></div> -->

  <div class="content">

    <div class="content-banner">
      <img ng-src="{{getShopBanner()}}">
    </div>

    <div class="products-wrapper">

      <div ng-repeat="item in products"  ng-click="buyEnergy(item.id)">


        <div ng-class="{'no-purchasable': !item.purchasable}" class="product" ng-if="item.price != null || timeLeft != ''">



          <div class="slot-base">
            <div class="shop-item-left"></div>
            <div class="shop-item-middle"></div>
            <div class="shop-item-right"></div>
          </div>
          <div class="shop-item-pattern"></div>

          <div class="slot-content">

            <div class="image-column">
              <img class="item-icon" ng-src="{{item.captionImage}}">
            </div>

            <div class="quantity-column">
              <span class="product-description">{{item.description}}</span>
              <div ng-switch="item.purchasable">
                <span ng-switch-when="true"  class="product-count">{{item.price}}</span>
                <span ng-switch-when="false" class="product-time-left">{{timeLeft}}</span>
              </div>
            </div>

       	  </div>



        </div>



      </div>

    </div>

    <div class="buttons-wrapper">
     <div class="button-box"><button id="btnClose" class="cancel-button" ng-click="CloseModal()">{{getLocalizedText('buttonback')}}</button></div>
    </div>

  </div>

</modal>"""));
tc.put("packages/webclient/components/account/gold_shop_comp.html", new HttpResponse(200, r"""<modal id="goldShopComp">

  <!--<div class="header"></div> -->

  <div class="content">

    <div class="content-banner">
      <img ng-src="{{getShopBanner()}}">
    </div>

    <div class="products-wrapper">

      <div ng-repeat="item in products" class="product" ng-click="buyItem(item.id)">
        <div class="slot-base">
          <div class="shop-item-left"></div>
          <div class="shop-item-middle"></div>
          <div class="shop-item-right"></div>
        </div>
        <div class="shop-item-pattern" ng-if="!item.isMostPopular"></div>

        <div class="slot-content">

          <div class="image-column">
            <img class="item-icon" ng-src="{{item.captionImage}}">
          </div>

          <div class="quantity-column">
            <span class="product-description">{{item.description}}</span>
            <span class="product-count">{{item.quantity}}</span>
          </div>

          <div class="price-column">
            <div class="free-increment" ng-if="item.freeIncrement > 0">
              <span class="free-increment-count">{{item.freeIncrement}}</span>
              <span class="free-increment-desc">{{getLocalizedText('free')}}</span>
            </div>
            <span class="product-price" ng-class="{'no-frees' : !(item.freeIncrement > 0)}">{{item.price}}</span>
          </div>
          <div class="clearfix"></div>
          <img ng-src="{{getLocalizedText('mostpopularimagesource')}}" class="shop-item-popular" ng-if="item.isMostPopular">

        </div>
      </div>

    </div>

    <div class="buttons-wrapper">
       <div class="button-box"><button id="btnClose" class="cancel-button" ng-click="CloseModal()">{{getLocalizedText('buttonback')}}</button></div>
    </div>


  </div>

</modal>"""));
tc.put("packages/webclient/components/account/join_comp.html", new HttpResponse(200, r"""<div id="joinRoot" ng-show="!loadingService.isLoading" ng-class="{'air':!isModal}">
  <div id="signupbox" class="main-box" ng-class="{'air':!isModal}">

    <div class="panel">

      <div class="panel-heading">
        <div class="panel-title">{{getLocalizedText("title")}}</div>
        <button type="button" class="close" ng-click="onAction('CANCEL', $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" >

        <form id="signupForm" class="form-horizontal" ng-submit="onAction('SUBMIT')" role="form" formAutofillFix>
          <div class="form-description" ng-bind-html="getLocalizedText('description')"></div>

          <!-- NICKNAME  -->
          <div class="user-form-field">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText('nickrequires')}}</div>
            </div>
            <!-- Field Input -->
            <div id="nickNameInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-user"></div></span>
              <input id="nickName" name="NickName" type="text" ng-model="theNickName" placeholder="{{getLocalizedText('nick')}}" class="form-control" maxlength="{{MAX_NICKNAME_LENGTH}}" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="nickNameError" class="join-err-text">{{getLocalizedText("invalidnick")}}</div>
            </div>
          </div>

          <!-- EMAIL -->
          <div  class="user-form-field" >
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText("email")}}:</div>
            </div>
            <!-- Field Input -->
            <div id="emailInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
              <input id="email" name="Email" type="email" ng-model="theEmail" placeholder="{{getLocalizedText('email')}}" class="form-control" tabindex="2" autocapitalize="off">
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="emailError" class="join-err-text">{{getLocalizedText("invalidemail")}}</div>
            </div>
          </div>

          <!-- PASSWORD -->
          <div  class="user-form-field">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText("passrequires")}}</div>
            </div>
            <!-- Field Input 1 -->
            <div id="passwordInputGroup" class="input-group  bottom-separation-10">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="password" name="Password" type="password" ng-model="thePassword" placeholder="{{getLocalizedText('pass')}}" class="form-control" data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH"  tabindex="3" autocapitalize="off">
            </div>
            <!-- Field Input 2 -->
            <div id="rePasswordInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="rePassword" name="RePassword" type="password" ng-model="theRePassword" placeholder="{{getLocalizedText('repass')}}" class="form-control" tabindex="4" autocapitalize="off">
            </div>
            <!-- Error de password -->
            <div class="new-row">
              <div id="passwordError" class="join-err-text">{{getLocalizedText("invalidpass")}}</div>
            </div>
          </div>

          <!-- BUTTONS -->
          <div class="input-group user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">{{getLocalizedText("buttonsignup")}}</button>
                <button id="btnCancelJoin" ng-click="onAction('CANCEL', $event)" class="cancel-button-half">{{getLocalizedText("buttoncancel")}}</button>
             </div>
            </div>
          </div>

          <!-- GOTO LOGIN -->
          <div class="user-form-field">
            <div class="small-text">{{getLocalizedText("registered")}} <a id="gotoLoginLink" ng-click="onAction('LOGIN', $event)"> {{getLocalizedText("loginhere")}}</a></div>
          </div>

          <!--
          Facebook stuff-->
          <div  class="user-form-field">
            <div class="fb-button-wrapper">
              <fb:login-button scope="public_profile,email" size="large" onlogin="jsLoginFB()">
              </fb:login-button>
            </div>
          </div>
          <!-- -->

        </form>
      </div>
    </div>
  </div>
</div>
 <script>
 if (typeof FB !== "undefined" && FB != null) {
   FB.XFBML.parse();
 }
 </script>
"""));
tc.put("packages/webclient/components/account/login_comp.html", new HttpResponse(200, r"""<div id="loginRoot" ng-show="!loadingService.isLoading" ng-class="{'air':!isModal}">
  <div id="loginBox" class="main-box" ng-class="{'air':!isModal}">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title">{{GetLocalizedText('title')}}</div>
        <button type="button" class="close" ng-click="onAction('CANCEL', $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" >

        <form id="loginForm" class="form-horizontal" ng-submit="onAction('SUBMIT')" role="form" formAutofillFix>
          <div class="form-description">{{GetLocalizedText('description')}}</div>

          <!-- LOGIN FIELDS -->
          <div class="user-form-field">
            <!-- MAIL -->
            <div class="input-group  bottom-separation-10">
              <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
              <input id="login-mail" ng-model="emailOrUsername" type="email" name="Email" placeholder="{{GetLocalizedText('email')}}" class="form-control" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- PÂSSWORD -->
            <div class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="login-password" type="password" ng-model="password" name="password" placeholder="{{GetLocalizedText('pass')}}" class="form-control" tabindex="2" autocapitalize="off">
            </div>

            <!-- Error de login/pass -->
            <div id="loginErrorSection" class="new-row">
              <div id="loginErrorLabel" class="login-err-text">{{GetLocalizedText('loginerror')}}</div>
            </div>

          </div>

          <!-- REMEMBER PASS -->
          <div class="user-form-field-righted">
            <a id="rememberPasswordLink" class="small-link-righted" ng-click="onAction('REMEMBER_PASSWORD', $event)">{{GetLocalizedText('forgotpass')}}</a>
          </div>

          <!-- BUTTONS -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">{{GetLocalizedText('buttonlogin')}}</button>
                <button id="btnCancelLogin" ng-click="onAction('CANCEL', $event)" class="cancel-button-half">{{GetLocalizedText('buttoncancel')}}</button>
              </div>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="small-text">{{GetLocalizedText('unregistered')}} <a id="gotoRegisterLink" ng-click="onAction('JOIN', $event)"> {{GetLocalizedText('signuphere')}} </a></div>
            </div>
          </div>

          <!--Facebook stuff-->
          <div  class="user-form-field">
            <div class="fb-button-wrapper">
              <fb:login-button scope="public_profile,email" size="large" onlogin="jsLoginFB()">
              </fb:login-button>
            </div>
          </div>
          <!-- -->

        </form>
      </div>
    </div>
  </div>
</div>
 <script>
   if (typeof FB !== "undefined" && FB != null) {
     FB.XFBML.parse();
   }
 </script>
"""));
tc.put("packages/webclient/components/account/remember_password_comp.html", new HttpResponse(200, r"""<div id="rememberPasswordRoot" ng-show="!loadingService.isLoading">
  <div id="loginBox" class="main-box air">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title" ng-class="{'center-text':state=='STATE_REQUESTED'}">{{getLocalizedText("title")}}</div>
        <button ng-show="state=='STATE_REQUEST'" type="button" class="close" ng-click="navigateTo('login', {}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" ng-switch >
        <!-- Mensaje cuando todo ha ido correctamente. -->
        <div ng-show="state=='STATE_REQUESTED'">
          <div class="form-description">{{getLocalizedText("confirmpart1")}}<br><br><p class="email-detail">'{{email}}'</p>{{getLocalizedText("confirmpart2")}}</div>
          <!-- BUTTONS -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-click="backToLanding()" class="enter-button">{{getLocalizedText("buttoncontinue")}}</button>
              </div>
            </div>
          </div>
        </div>

        <form ng-show="state=='STATE_REQUEST'" id="rememberPasswordForm" class="form-horizontal" ng-submit="rememberMyPassword()" role="form">

          <div class="form-description">{{getLocalizedText("description")}}</div>

          <!-- EMAIL -->
          <div  class="user-form-field" >
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText("emailrequires")}}</div>
            </div>
            <!-- Field Input -->
             <div id="emailInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
              <input id="rememberEmail" name="Email" type="email" ng-model="email" placeholder="{{getLocalizedText('email')}}" class="form-control" tabindex="1" autocapitalize="off"  auto-focus>
            </div>
            <!-- Error label -->
            <div id="errContainer" class="new-row">
              <div id="errLabel" class="login-err-text">...</div>
            </div>
          </div>

          <!-- BUTTONS -->
          <div class="input-group user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="RememberPassword" ng-disabled="!enabledSubmit" class="enter-button-half">{{getLocalizedText("buttoncontinue")}}</button>
                <button id="btnCancelRemember" ng-click="navigateTo('login', {}, $event)" class="cancel-button-half">{{getLocalizedText("buttoncancel")}}</button>
             </div>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="new-row bottom-separation-10">
            <div class="small-text">{{getLocalizedText("unregistered")}}<a id="gotoRegisterLink" ng-click="navigateTo('join', {}, $event)"> {{getLocalizedText("signuphere")}} </a></div>
          </div>

        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/shop_comp.html", new HttpResponse(200, r"""<div id="mainShopCompWrapper">

  <div class="items-wrapper">  
    <div ng-repeat="item in shops" class="shop-item" ng-click="openShop(item.name)">
      <div class="slot-base">        
        <div class="shop-item-left"></div>
        <div class="shop-item-middle"></div>      
        <div class="shop-item-right"></div>        
      </div>
      <div class="shop-item-pattern"></div>
      <div class="slot-content">    
        <img class="item-icon" ng-src="{{item.image}}">
        <span class="shop-item-info" ng-bind-html="'<span>'+item.description+'</span>'"></span>
      </div>   
    </div>
  
    <!-- Punto de insercion de nuestra ruta hija contest-info (modal) -->
    <ng-view ng-show="!loadingService.isLoading"></ng-view>
  
  </div>
  
</div>"""));
tc.put("packages/webclient/components/account/transaction_history_comp.html", new HttpResponse(200, r"""<div id="transactionHistoryRoot">
  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText("title")}}</div>

  <div class="transaction-headers">
    <span class="header-date">{{getLocalizedText("date")}}</span>
    <span class="header-id">{{getLocalizedText("id")}}</span>
    <span class="header-concept">{{getLocalizedText("subject")}}</span>
    <span class="header-amount">{{getLocalizedText("value")}}</span>
    <span class="header-balance">{{getLocalizedText("balance")}}</span>
  </div>

  <div class="transaction-row" ng-repeat="transaction in currentPageList">
    <div class="field-date">{{transaction.formattedDate}}</div>
    <div class="field-id">{{transaction.transactionID}}</div>
    <div class="field-concept">{{transaction.transactionDescription}}</div>
    <div class="field-amount"><div class="money-label">{{getLocalizedText("value")}}: </div> {{transaction.value}}</div>
    <div class="field-balance"><div class="money-label">{{getLocalizedText("balance")}}: </div> {{transaction.balance}}</div>
  </div>

  <paginator on-page-change="onPageChange(currentPage, itemsPerPage)" items-per-page="20" list-length="transactions.length"></paginator>

</div>
"""));
tc.put("packages/webclient/components/account/user_profile_comp.html", new HttpResponse(200, r"""<div id="viewProfileContent">
  <div class="profile-content">

    <div class="personal-data profile-section">
      <div class="data-header">
        <span class="data-header-title">{{getLocalizedText("title")}}</span>
      </div>
      <div class="data-content">
        <div class="data-row"><span class="data-key">{{getLocalizedText("fullname")}}:</span><span class="data-value">{{userData.firstName + ' ' + userData.lastName}}</span></div>
        <div class="data-row"><span class="data-key">{{getLocalizedText("nick")}}:</span><span class="data-value">{{userData.nickName}}</span></div>
        <div class="data-row"><span class="data-key">{{getLocalizedText("email")}}:</span><span class="data-value">{{userData.email}}</span></div>
        <div class="data-row"><span class="data-key">{{getLocalizedText("pass")}}:</span><span class="data-value">********</span></div>
      </div>
      <div class="data-action">
        <button class="action-button edit-button" ng-click="editPersonalData()">{{getLocalizedText("buttonedit")}}</button>
      </div>
    </div>

    <div class="pocket-data profile-section">
      <div class="data-header">
          <span class="data-header-title">{{getLocalizedText("wallet")}}</span>
      </div>
      <div class="data-content">
        <div class="data-row">
          <div class="wrapper-box"> <span class="data-value-coins">{{userData.balance}}</span><img class="coin-icon" src="images/icon-coin-lg.png"> </div>
        </div>
      </div>
      <div class="data-action">
        <button class="action-button buy-button" ng-click="goBuyGold()">{{getLocalizedText("buttonbuy")}}</button>
      </div>
    </div>
    <div class="ranking-data profile-section">
      <div class="data-header">
          <span class="data-header-title">{{getLocalizedText("ranking")}}</span>
      </div>
      <div class="data-content">
        <div class="single-ranking-info ranking-by-points wrapper-box">
          <img class="ranking-badge" src="images/icon-Ranking-Skill-Blue.png">
          <span class="ranking-position" ng-show="!loadingService.isLoading">{{rankingPointsPosition}}º</span>
          <span class="ranking-score" ng-show="!loadingService.isLoading">{{rankingPoints}} {{getLocalizedText("abrevpoints", "common")}}</span>
        </div>
        <div class="single-ranking-info ranking-by-money wrapper-box">
        
          <img class="ranking-badge" src="images/icon-coin-lg.png">
          <span class="ranking-position" ng-show="!loadingService.isLoading">{{rankingMoneyPosition}}º</span>
          <span class="ranking-score" ng-show="!loadingService.isLoading">{{rankingMoney}}</span>
        </div>
      </div>
      <div class="data-action">
        <button class="action-button ranking-table-button" ng-click="goLeaderboard()">{{getLocalizedText("buttonrankingtable")}}</button>
      </div>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/contest_header_f2p_comp.html", new HttpResponse(200, r"""
<div class="contest-header-f2p-wrapper" ng-if="contest != null">
  
  <!-- margen arriba -->
  <div class="name-section">
    <div class="contest-name">{{contest.name}}</div>
    <div class="contest-description">{{contest.description}}</div>
  </div>

  <div class="conditions-section">
  
    <div class="player-position" ng-if="contest.isLive || contest.isHistory">
      <div class="condition-name"><span>{{getLocalizedText("position")}}</span></div>
      <div class="condition-amount"><span class="current-position">{{printableMyPosition()}}</span>/{{contest.numEntries}}</div>
    </div>
    
    <div class="entry-fee-box" ng-if="!(contest.isLive || contest.isHistory)">
      <span class="condition-name">{{getLocalizedText("entryfee")}}</span>
      <span class="condition-amount" ng-class="{'entry-fee-coin':getContestTypeIcon() == 'real', 'entry-fee-energy':getContestTypeIcon() == 'train'}">{{contest.entryFee}}</span>
    </div>
    <div class="prize-box">
      <span class="condition-name">{{getLocalizedText("prize")}}</span>
      <span class="condition-amount" ng-class="{'prize-coin':getContestTypeIcon() == 'real', 'prize-managerpoints':getContestTypeIcon() == 'train'}">{{getPrizeToShow()}}</span>
    </div>
  </div>
  
  <div class="date-time-data">
    <div class="contest-start-date">
      <span>{{info['startTime']}}&nbsp;</span>
    </div>
  </div>
  
  <div class="tournament-and-type-section">
    <span class="{{getSourceFlag()}}"></span>
    <span class="contest-type {{getContestTypeIcon()}}"></span>
  </div>
  
  <div class="close-contest" ng-switch="isInsideModal">
    <button type="button" ng-switch-when="true"  class="close" data-dismiss="modal">   <span class="glyphicon glyphicon-remove"></span></button>
    <button type="button" ng-switch-when="false" class="close" ng-click="goToParent()"><span class="glyphicon glyphicon-remove"></span></button>
  </div>

</div>
<teams-panel id="teamsPanelComp" contest="contest" contest-id="contest.contestId"  ng-if="showMatches"></teams-panel>

<div class="clearfix"></div>
"""));
tc.put("packages/webclient/components/contest_info_comp.html", new HttpResponse(200, r"""<modal id="contestInfoModal" ng-if="isModal">

  <contest-header-f2p id="contestInfoHeader" contest="contest" contest-id="contestId"  modal="true" show-matches="false"></contest-header-f2p>

  <div class="modal-info-content">

      <div class="tabs-background">
        <!-- Nav tabs -->
        <div class="tabs-navigation">
          <ul class="contest-info-tabs " id="modalInfoContestTabs">
              <li class="tab active"><a data-toggle="tab" ng-click="tabChange('matches')">{{getLocalizedText("matches")}}</a></li>
              <li class="tab"><a data-toggle="tab" ng-click="tabChange('prizes')">{{getLocalizedText("prizes")}}</a></li>
              <li class="tab"><a data-toggle="tab" ng-click="tabChange('contestants')">{{getLocalizedText("contenders")}}</a></li>
              <li class="tab"><a data-toggle="tab" ng-click="tabChange('scoring')">{{getLocalizedText("scoringrules")}}</a></li>
              <!--<li class="buton-place">
                <button id="btn-go-enter-contest" class="btn btn-primary" ng-click="enterContest()">ENTER</button>
              </li>-->
          </ul>

          <div id="enterContestButton">
            <button id="btn-go-enter-contest" class="btn btn-primary" ng-click="enterContest()">{{getLocalizedText("buttonenter")}}</button>
          </div>
        </div>
      </div>

      <div class="contest-info-content" id="modalInfoContestTabContent">
          <div class=" tab-content">

              <!-- Tab panes -->
              <div class="tab-pane active" id="matches">
                  <p class="instructions">{{currentInfoData['rules']}}</p>
                  <div class="matches-involved">
                      <div class="match" ng-repeat="match in currentInfoData['matchesInvolved']">
                          <p class="teams">{{match.soccerTeamA.shortName}} - {{match.soccerTeamB.shortName}}</p>
                          <p class="date">{{formatMatchDate(match.startDate)}}</p>
                      </div>
                  </div>
              </div>

              <div class="tab-pane" id="prizes">
                <div class="prizes-wrapper">
                  <!--<div ng-if="!loadingService.isLoading && currentInfoData['prizes'].isEmpty" class="default-info-text">
                    Este concurso no tiene premios
                  </div>-->
                  <div class="default-info-text">
                    {{currentInfoData["prizeType"]}}
                  </div>
                  <div id="prizes-list">
                    <div class="prize-element-wrapper" ng-repeat="prize in currentInfoData['prizes']">
                      <div class="prize-element">
                          {{$index + 1}}º &nbsp;&nbsp; {{prize}}
                      </div>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>

              <div class="tab-pane" id="contestants">
                <div class="contestant-list-wrapper">
                  <div ng-if="!loadingService.isLoading && currentInfoData['contestants'].isEmpty" class="default-info-text" ng-bind-html="getLocalizedText('nocontenders')"></div>
                  <div class="contestant-list">
                    <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
                      <div class="contestant-position">{{$index + 1}}º</div>
                      <div class="contestant-name">{{contestant.name}}</div>
                      <div class="contestant-points">{{contestant.trueSkill + ' '}}<span class="prize-currency">{{getLocalizedText("skill")}}</span></div>
                    </div>
                  </div>
                </div>
              </div>

                            <!-- Tab panes -->
              <div class="tab-pane" id="scoring">
                  <!--div class="clearfix"></div-->
                  <div class="rules-description">
                    <scoring-rules></scoring-rules>
                  </div>
              </div>

          </div>
      </div>
  </div>
</modal>

<div id="contestInfoTabbed" ng-if="!isModal" ng-show="contest != null">
  <p class="title">{{currentInfoData['rules']}}</p>
  <div class="matches-involved">
      <div class="match" ng-repeat="match in currentInfoData['matchesInvolved']">
          <p class="teams">{{match.soccerTeamA.shortName}} - {{match.soccerTeamB.shortName}}</p>
          <p class="date">{{formatMatchDate(match.startDate)}}</p>
      </div>
  </div>
  <div class="clearfix"></div>
  <div class="info-section"></div>

  <p class="title">{{getLocalizedText("prizes").toUpperCase()}}</p>
  <div class="prizes-wrapper">
      <div id="prizes-list">
        <!--<div ng-if="!loadingService.isLoading && currentInfoData['prizes'].isEmpty" class="default-info-text">
          Este concurso no tiene premios
        </div> -->
        <div class="default-info-text">
          {{currentInfoData["prizeType"]}}
        </div>
        <div class="prize-element-wrapper" ng-repeat="prize in currentInfoData['prizes']">
          <div class="prize-element">
              {{$index + 1}}º &nbsp;&nbsp; {{prize}}
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
  </div>
  <div class="clearfix"></div>
  <div class="info-section"></div>

  <p class="title">{{getLocalizedText("contenders").toUpperCase()}}</p>
  <div ng-if="!loadingService.isLoading && currentInfoData['contestants'].isEmpty" class="default-info-text" ng-bind-html="getLocalizedText('nocontenders')"></div>
  <div class="contestant-list">
      <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
          <div class="contestant-position">{{$index + 1}}º</div>
          <div class="contestant-name">{{contestant.name}}</div>
          <div class="contestant-points">{{contestant.trueSkill + ' '}}<span class="prize-currency">{{getLocalizedText("skill")}}</span></div>
      </div>
  </div>
  <div class="clearfix"></div>
  <div class="info-section"></div>

  <p class="title">{{getLocalizedText("scoringrules").toUpperCase()}}</p>
  <div class="rules-description">
    <scoring-rules></scoring-rules>
  </div>
  <div class="clearfix"></div>

</div>

"""));
tc.put("packages/webclient/components/contests_list_f2p_comp.html", new HttpResponse(200, r"""<div class="contests-list-f2p-root" ng-if="contestsListOriginal.isNotEmpty">
  <div ng-repeat="contest in contestsListOrdered">
    <div class="contestSlot" ng-class="{'special' : getContestMorfology(contest) == 'special'}" ng-click="onRow(contest)">

      <div class="special-image-section" ng-if="getContestMorfology(contest) == 'special'">
        <img ng-src="{{getContestImage(contest)}}"></img>
      </div>

      <div class="time-section">
        <div class="fake-time-column"></div>
        <div class="column-start-time">
          <div class="column-start-hour" ng-class="{'start-soon' : isSoon(contest.startDate)}" ng-bind-html="timeInfo(contest.startDate)"></div>
          <div class="column-start-date" ng-if="showDate && !isSoon(contest.startDate)" ng-bind-html="dateInfo(contest.startDate)"></div>
        </div>
      </div>

      <!-- margen arriba -->
      <div class="name-section">
        <div class="contest-name">{{contest.name}}</div>
        <div class="contest-description">{{contest.description}}</div>
      </div>

      <div class="conditions-section">
      
        <div class="player-position" ng-if="contest.isLive || contest.isHistory">
          <div class="condition-name"><span>{{getLocalizedText("position")}}</span></div>
          <div class="condition-amount"><span class="current-position">{{printableMyPosition(contest)}}</span>/{{contest.numEntries}}</div>
        </div>
        
        <div class="entry-fee-box" ng-if="!(contest.isLive || contest.isHistory)">
          <span class="condition-name">{{getLocalizedText("entryfee")}}</span>
          <span class="condition-amount" ng-class="{'entry-fee-coin':getContestTypeIcon(contest) == 'real', 'entry-fee-energy':getContestTypeIcon(contest) == 'train'}">{{contest.entryFee}}</span>
        </div>
        <div class="prize-box" ng-if="!contest.isLive">
          <span class="condition-name">{{getLocalizedText("prize")}}</span>
          <span class="condition-amount" ng-class="{'prize-coin':getContestTypeIcon(contest) == 'real', 'prize-managerpoints':getContestTypeIcon(contest) == 'train'}">{{getPrizeToShow(contest)}}</span>
        </div>
        <div class="points-box" ng-if="contest.isLive">
          <span class="condition-name">{{getLocalizedText("points")}}</span>
          <span class="condition-amount">{{getPointsToShow(contest)}}</span>
        </div>
      </div>

      <div class="action-section" ng-click="onAction(contest, $event)">
        <img class="ticket" ng-src="images/arrow{{getContestMorfology(contest) == 'normal' ? 'Black' : 'White'}}.png">
        <!--div class="button-wrapper" ng-if="contest.isLive">
          <button type="button" class="action-button" ng-click="onAction(contest, $event)">{{actionButtonTitle}}</button>
        </div-->
      </div>

      <div class="tournament-and-type-section">
        <span class="{{getSourceFlag(contest)}}"></span>
        <span class="contest-type {{getContestTypeIcon(contest)}}"></span>
      </div>
      
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/enter_contest/enter_contest_comp.html", new HttpResponse(200, r"""<div id="enter-contest-wrapper" >

  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId" show-matches="false"></contest-header-f2p>

  <!-- Nav tabs -->
  <ul class="enter-contest-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('lineup-tab-content')">{{getLocalizedText("tablineup")}}</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('contest-info-tab-content')">{{getLocalizedText("tabcontestinfo")}}</a></li>
  </ul>

  <div id="enterContest">
    <div class="tabs">
      <div class="tab-content">

        <!-- Tab del contenido normal de seleccion de lineup -->
        <div class="tab-pane active" id="lineup-tab-content">

            <!-- Este sera el selector de partidos en "grande", con botones-->
            <matches-filter contest="contest" selected-option="matchFilter" ng-if="scrDet.isNotXsScreen"></matches-filter>

            <div class="enter-contest-actions-wrapper" ng-if="scrDet.isXsScreen">
              <div class="total-salary" ng-class="{'red-numbers':availableSalary < 0}">
                <span class="total-salary-money" ng-show="contest != null">{{formatCurrency(printableAvailableSalary)}}</span>
              </div>
              <button id="cancelSoccerPlayerSelection" type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer">{{getLocalizedText("buttoncancel")}}</button>
            </div>

            <div class="enter-contest-lineup-wrapper">
              <div class="enter-contest-lineup">
                <div class="enter-contest-total-salary">
                    <span class="total-salary-text">{{getLocalizedText("yourlineup")}}</span>
                    <div class="total-salary">
                      <span class="total-salary-text">{{getLocalizedText("remainsalary")}}:</span>
                      <span class="total-salary-money" ng-class="{'red-numbers': availableSalary < 0 }" ng-show="contest != null">{{formatCurrency(printableAvailableSalary)}}</span>
                    </div>
                </div>

                <lineup-selector ng-show="!isSelectingSoccerPlayer || scrDet.isNotXsScreen"
                                 not-enough-resources="!enoughResourcesForEntryFee"
                                 resource="resourceName"
                                 has-max-players-same-team="playersInSameTeamInvalid"
                                 has-negative-balance="isNegativeBalance"
                                 manager-level="playerManagerLevel"></lineup-selector>
              </div>
            </div>

            <div class="enter-contest-soccer-players-wrapper" ng-show="isSelectingSoccerPlayer || scrDet.isNotXsScreen">
              <div class="enter-contest-soccer-players">

                <!-- Este es el desplegable para el movil -->
                <matches-filter contest="contest" selected-option="matchFilter" ng-if="scrDet.isXsScreen"></matches-filter>

                <soccer-players-filter name-filter="nameFilter" field-pos-filter="fieldPosFilter"></soccer-players-filter>

                <soccer-players-list soccer-players="allSoccerPlayers"
                                     lineup-filter="lineupSlots"
                                     manager-level="playerManagerLevel"
                                     field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                                     on-row-click="onRowClick(soccerPlayerId)"
                                     on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-list>
              </div>
            </div>

            <div class="enter-contest-actions-wrapper">
              <div class="button-wrapper-block" ng-if="isSelectingSoccerPlayer && scrDet.isXsScreen">
                <button type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer">{{getLocalizedText("buttoncancel")}}</button>
              </div>
              <div  class="bottom-content" ng-if="!isSelectingSoccerPlayer || scrDet.isNotXsScreen">
                <div class="button-wrapper">
                  <button type="button" class="btn-clean-lineup-list" ng-click="deleteFantasyTeam()" ng-disabled="isPlayerSelected()">{{getLocalizedText("buttonclean")}}</button>
                </div>
                <div class="button-wrapper">
                  <button type="button" class="btn-confirm-lineup-list"
                          ng-click="createFantasyTeam()"
                          ng-disabled="isInvalidFantasyTeam"
                          ng-bind-html="getConfirmButtonText()"></button>
                </div>
                <p>{{getLocalizedText("tip")}}</p>
              </div>
            </div>

        </div>

        <!-- El otro tab, el del contest-info  -->
        <div class="tab-pane" id="contest-info-tab-content">
          <contest-info ng-if="contestInfoFirstTimeActivation"></contest-info>
        </div>

      </div>
    </div>

    <div class="contest-id-bar">
      <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
    </div>
  </div>

</div>

<ng-view></ng-view>"""));
tc.put("packages/webclient/components/enter_contest/lineup_selector_comp.html", new HttpResponse(200, r"""<div class="lineup-selector">
  <div class="lineup-selector-slot" ng-repeat="slot in enterContestComp.lineupSlots" ng-click="enterContestComp.onLineupSlotSelected($index)" ng-class="getSlotClassColor($index)">

    <div ng-if="slot == null">
      <div class="column-fieldpos"></div>
      <div class="column-empty-slot">{{getSlotDescription($index)}}</div>
      <div class="column-action"><a class="iconButtonSelect"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
    </div>

    <div ng-if="slot != null">
      <!--div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div-->
      <div class="column-primary-info">
        <span class="soccer-player-name">{{slot.fullName}}</span>
        <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
      </div>
      <div class="column-salary">${{getPrintableSalary(slot.salary)}}</div>
      <div class="column-gold-cost" ng-bind-html="getPrintableGoldCost(slot)"></div>
      <div class="column-action"><a class="iconButtonRemove"><span class="glyphicon glyphicon-remove"></span></a></div>
    </div>
  </div>
  
  <div class="alert alert-danger alert-dismissible alert-red-numbers" ng-class="{'active':alertNotEnoughResources}" role="alert" ng-bind-html="getLocalizedText('not-enough-resources')"></div>
  <div class="alert alert-danger alert-dismissible alert-red-numbers" ng-class="{'active':alertNegativeBalance}" role="alert" ng-bind-html="getLocalizedText('wastedsalarycap')"></div>
  <div class="alert alert-danger alert-max-players-same-team" ng-class="{'active':alertMaxPlayersSameTeamExceed}" role="alert" ng-bind-html="getLocalizedText('maxplayersteam')"></div>
  
</div>"""));
tc.put("packages/webclient/components/enter_contest/matches_filter_comp.html", new HttpResponse(200, r"""<div id="matchesFilterWrapper" ng-switch="srcDet.isXsScreen">

  <select id="matchesSelectorFilter" ng-switch-when="true" class="matches-selector-filter" ng-model="optionsSelectorValue" >
    <option ng-repeat="match in matchEvents" id="option-match-{{match.id}}" value="{{$index + 1}}" ng-value="match.id">{{match.textoSelector}}</option>
  </select>

  <div id="matchesFilterButtons" class="matches-filter-buttons" ng-switch-when="false">
    <div class="button-filter-wrapper" ng-repeat="match in matchEvents" >
      <button class="btn btn-default button-filter-team"ng-bind-html="match.texto" id="match-{{match.id}}"
              ng-click="optionsSelectorValue = match.id" ng-class="{'active': optionsSelectorValue == match.id }">
      </button>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/enter_contest/soccer_player_stats_comp.html", new HttpResponse(200, r"""<modal id="modalSoccerPlayerStats">

  <div class="soccer-player-stats-header">

    <!-- En XS mostramos botones de Añadir / Cancelar -->
    <div class="actions-header-xs">
        <button class="button-cancel" data-dismiss="modal">{{getLocalizedText("buttoncancel")}}</button>
        <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">{{getLocalizedText("buttonadd")}}</button>
    </div>

    <!-- En el resto de versiones título y cruz de cerrar -->
    <div class="actions-header-sm">
      <div class="text-header">{{getLocalizedText("tittle")}}</div>
      <button type="button" class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
    </div>

    <!-- Extra info en la cabecera -->
    <div class="description-header">
      <div class="soccer-player-description">
        <div class="soccer-player-pos-team">
          <span>{{currentInfoData['fieldPos']}}</span> | <span>{{currentInfoData['team']}}</span>
        </div>
        <div class="soccer-player-name">{{currentInfoData['name']}}</div>
      </div>
      <div class="soccer-player-stats-info">
        <div class="soccer-player-fantasy-points"><span>{{getLocalizedText("dfp")}}</span><span>{{currentInfoData['fantasyPoints']}}</span></div>
        <div class="soccer-player-matches"><span>{{getLocalizedText("matches")}}</span><span>{{currentInfoData['matchesCount']}}</span></div>
        <div class="soccer-player-salary"><span>{{getLocalizedText("salary")}}</span><span>{{printableSalary}}</span></div>
      </div>
    </div>

    <div class="next-match-wrapper">
      <div class="next-match"  ng-bind-html="currentInfoData['nextMatchEvent']"></div>
      <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">{{getLocalizedText("buttonadd")}}</button>
    </div>

  </div>

  <div class="soccer-player-stats-content">
      <!-- Nav tabs -->
      <ul id="soccer-player-stats-tabs" class="soccer-player-stats-tabs" role="tablist">
        <li id="seasonTab" class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('season-stats-tab-content')">{{getLocalizedText("seasondata")}}</a></li>
        <li id="matchTab" ><a role="tab" data-toggle="tab" ng-click="tabChange('match-by-match-stats-tab-content')">{{getLocalizedText("matchbymatch")}}</a></li>
      </ul>

      <div class="tabs">
        <!-- Tab panes -->
        <div class="tab-content">
          <!-- START BY-SEASON-STATS -->
          <div class="tab-pane active" id="season-stats-tab-content">
            <div class="next-match" ng-bind-html="currentInfoData['nextMatchEvent']"></div>
            <!-- MEDIAS -->
            <div class="season-header" ng-bind-html="getLocalizedText('seasonstats')"></div>
            <div class="season-stats">
                <div class="season-stats-row" ng-repeat="stat in seasonResumeStats"  data-toggle="tooltip" title="{{stat['helpInfo']}}">
                    <div class="season-stats-header">{{stat['nombre']}}</div>
                    <div class="season-stats-info">{{stat['valor']}}</div>
                </div>
                <div div class="season-stats-row" ng-if="seasonResumeStats.length % 2 != 0"  data-toggle="" title="">
                    <div class="season-stats-header"></div>
                    <div class="season-stats-info"></div>
                </div>
            </div>

          </div>
          <!-- END BY-SEASON-STATS -->
          <!-- START BY-MATCH-STATS-->
          <div class="tab-pane" id="match-by-match-stats-tab-content">
            <div class="match-header">{{getUppercaseLocalizedText("matchbymatch")}}</div>
            <div class="noMatchesPlayed" ng-class="{'hidden':currentInfoData['matchesCount'] > 0}">
                <span>{{getLocalizedText("noseasonstats")}}</span>
            </div>
            <div class="match-stats-table-wrapper" ng-class="{'hidden':currentInfoData['matchesCount'] == 0}">
              <!--HEADER-->
              <table id="statsTable" class="table table-striped">
                <thead class="stats-headings">
                  <tr>
                    <th class="head-of-headings">{{getLocalizedText("season")}}</th> <!-- necesitamos una vacía -->
                    <th class="stat-field-header" ng-repeat="item in seasonTableHeaders">{{item}}</th>
                  </tr>
                </thead>
                <tbody class="stats-rows">
                  <tr>
                    <td ng-repeat="year in seasonsList" class="year-season">
                      <div class="year">{{year['year']}}</div>
                      <table class="match-stats-block" ng-repeat="stats in year['stats']">
                        <tbody>
                          <tr ng-repeat="stat in stats">
                            <td class="match-block" ng-class="{'blue':$index == 1}">{{stat}} </td>
                          </tr>
                        </tbody>
                      </table>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <!--END BY-MATCH-->
        </div>
      </div>
  </div>
  <div class="actions-footer-xs">
    <button class="button-cancel" data-dismiss="modal">{{getLocalizedText("buttoncancel")}}</button>
    <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">{{getLocalizedText("buttonadd")}}</button>
  </div>
</modal>

"""));
tc.put("packages/webclient/components/enter_contest/soccer_players_filter_comp.html", new HttpResponse(200, r"""<div class="soccer-players-filter">

  <div class="filter-by-position" ng-if="scrDet.isNotXsScreen">
    <span>{{getLocalizedText("players", group: "soccerplayerlist")}}</span>
    <button class="button-filter-position" ng-click="fieldPosFilter = fieldPos"
            ng-repeat="fieldPos in posFilterList" ng-bind-html="getTextForFieldPos(fieldPos)" ng-class="getClassForFieldPos(fieldPos)"></button>
  </div>

  <input type="text" class="name-player-input-filter" placeholder="{{getLocalizedText('search-player', group: 'soccerplayerlist')}}" ng-model="nameFilter" />
</div>"""));
tc.put("packages/webclient/components/home_comp.html", new HttpResponse(200, r"""<div id="homeRoot">
  <!--
  Torneos
  Tutorial
  Blog
  Crear Torneos
  Torneos en directo
  Scouting??
  -->
  
  <div id="contestTile" class="home-tile-wrapper enabled" ng-click="onContestsClick()">
    <div class="tile">
      <span class="tile-title">Torneos</span>
      <span class="tile-info">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer elementum justo vel eleifend fringilla.</span>
      <span class="tile-action"></span>
    </div>
  </div>
  
  <div id="manageTile" class="vertical-layout-tilling">
    <div id="createContestTile" class="home-tile-wrapper" ng-click="onCreateContestClick()" ng-class="{'disabled': !userIsLogged, 'enabled': userIsLogged}">
      <div class="tile">
        <span class="tile-title">Reta a tus amigos</span>
        <span class="tile-info">Primero debes aprender a jugar</span>
        <span class="tile-action"></span>
      </div>
    </div>
    <div id="scoutingTile" class="home-tile-wrapper" ng-click="onScoutingClick()" ng-class="{'disabled': !userIsLogged, 'enabled': userIsLogged}">
      <div class="tile">
        <span class="tile-title">Ojeador</span>
        <span class="tile-info ">Primero debes aprender a jugar</span>
        <span class="tile-action"></span>
      </div>
    </div>
  </div>
  
  <div id="myContestsTile" class="vertical-layout-tilling">
    <div id="upcomingTile" class="home-tile-wrapper" ng-click="onUpcomingClick()" ng-class="{'disabled': !userIsLogged, 'enabled': userIsLogged}">
      <div class="tile">
        <span class="tile-title">Próximos</span>
        <span class="tile-info">Primero debes aprender a jugar</span>
        <span class="tile-action"></span>
      </div>
    </div>
    <div id="liveTile" class="home-tile-wrapper" ng-click="onLiveClick()" ng-class="{'disabled': !userIsLogged, 'enabled': userIsLogged}">
      <div class="tile">
        <span class="tile-title">En vivo</span>
        <span class="tile-info">Primero debes aprender a jugar</span>
        <span class="tile-action"></span>
      </div>
    </div>
    <div id="historyTile" class="home-tile-wrapper" ng-click="onHistoryClick()" ng-class="{'disabled': !userIsLogged, 'enabled': userIsLogged}">
      <div class="tile">
        <span class="tile-title">Histórico</span>
        <span class="tile-info">Primero debes aprender a jugar</span>
        <span class="tile-action"></span>
      </div>
    </div>
  </div>
  
  <div id="blogTile" class="home-tile-wrapper enabled" ng-click="onBlogClick()">
    <div class="tile">
      <span class="tile-title">Palabra de Míster</span>
      <span class="tile-info">Un blog escrito por Salva Carmona, el tio que más sabe de estadísticas futboleras del mundo.</span>
      <span class="tile-action"></span>
    </div>
  </div>
  
  <div class="clearfix"></div>
</div>"""));
tc.put("packages/webclient/components/leaderboard_comp.html", new HttpResponse(200, r"""<div id="leaderboard-wrapper">

  <div id="leaderboard-header-wrapper">

    <h1>{{getLocalizedText("title")}}</h1>
    <div class="rankings-wrapper">
      <div class="ranking ranking-by-points">
        <span class="ranking-position">{{playerPointsInfo['position']}}º</span>
        <div class="ranking-info">
          <span class="ranking-name">{{getLocalizedText("topskill")}}</span>
          <span class="ranking-value">{{playerPointsInfo['points']}} ptos</span>
        </div>
      </div>
  
      <div class="ranking ranking-by-money">
        <span class="ranking-position">{{playerMoneyInfo['position']}}º</span>
        <div class="ranking-info">
          <span class="ranking-name">{{getLocalizedText("topgold")}}</span>
          <span class="ranking-value">{{playerMoneyInfo['points']}} </span>
        </div>
      </div>
      <div class="clearfix"></div>
    </div>

  </div>

  <div class="clearfix"></div>


  <ul class="leaderboard-tabs" role="tablist">
    <li class="active"><a class="leaderboard-tab top-points-tab" role="tab" data-toggle="tab" ng-click="tabChange('top-points')">{{getLocalizedText("trueskill")}}</a></li>
    <li><a class="leaderboard-tab top-money-tab" role="tab" data-toggle="tab" ng-click="tabChange('top-money')">{{getLocalizedText("gold")}}</a></li>
  </ul>
  
  <div class="tabs">
    <div class="tab-content">

      <!-- LIVE CONTESTS -->
      <div class="tab-pane active" id="top-points">      
        
        <leaderboard-table show-header="true" highlight-element="playerPointsInfo" table-elements="pointsUserList" rows="usersToShow" points-column-label="pointsColumnName" hint="playerPointsHint" ng-show="!loadingService.isLoading"></leaderboard-table>
        
      </div>

      <!-- WAITING CONTESTS -->
      <div class="tab-pane" id="top-money">

        <leaderboard-table show-header="true" highlight-element="playerMoneyInfo" table-elements="moneyUserList" rows="usersToShow" points-column-label="moneyColumnName" hint="playerMoneyHint" ng-show="!loadingService.isLoading"></leaderboard-table>
      
      </div>
    </div>
  </div>


</div>"""));
tc.put("packages/webclient/components/leaderboard_table_comp.html", new HttpResponse(200, r"""<div class="leaderboard-table">
  <div class="leaderboard-table-header" ng-show="isHeaded">
    <div class="leaderboard-table-element">
      <span class="leaderboard-column leaderboard-table-position">{{getLocalizedText("abrevposition")}}</span>
      <span class="leaderboard-column leaderboard-table-name">{{getLocalizedText("name")}}</span>
      <span class="leaderboard-column leaderboard-table-hint"> </span>
      <span class="leaderboard-column leaderboard-table-skillpoints">{{pointsColumnName}}</span>
    </div>
  </div>
  <div class="leaderboard-table-data">
    <div class="leaderboard-table-element {{isThePlayer(element['id'])? 'player-position' : ''}}" ng-repeat="element in shownElements">
      <span class="leaderboard-column leaderboard-table-position">{{element['position']}} </span>
      <span class="leaderboard-column leaderboard-table-name">{{element['name']}} </span>
      <span class="leaderboard-column leaderboard-table-hint">{{isThePlayer(element['id'])? playerHint : ''}} </span>
      <span class="leaderboard-column leaderboard-table-skillpoints">{{element['points']}} </span>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/lobby_f2p_comp.html", new HttpResponse(200, r"""<div id="lobbyf2pRoot">

  <!-- Header de Promociones -->
  <simple-promo-f2p id="promosComponent" ng-show="scrDet.isNotXsScreen"></simple-promo-f2p>

  <!-- Temporalmente pongo la imagen del calendario (maquetar mas adelante). -->
  <week-calendar on-day-selected="onSelectedDayChange(day)" dates="dayList"></week-calendar>

  <!-- Lista de concursos -->
  <contests-list-f2p  id="activeContestList"
                      contests-list="currentContestList"
                      on-action-click='onActionClick(contest)'
                      on-row-click="onRowClick(contest)"
                      action-button-title="'>'">
  </contests-list-f2p>

  <!-- Punto de insercion de nuestra ruta hija contest-info (modal) -->
  <ng-view  ng-show="!loadingService.isLoading"></ng-view>

</div>
"""));
tc.put("packages/webclient/components/modal_comp.html", new HttpResponse(200, r"""<div id="modalRoot" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-{{modalSize}}">
    <div class="modal-content">
      <content></content>
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/my_contests_comp.html", new HttpResponse(200, r"""<div id="myContest" >
  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText("title")}}</div>
  <!-- Nav tabs -->
  <ul  id="myContestMenuTabs" class="my-contest-tabs" role="tablist">
    <li id="live-contest-tab" class="active"><a role="tab" data-toggle="tab" ng-click="gotoSection('live')"> {{getLocalizedText("tablive")}} <span class="contest-count" ng-if="hasLiveContests">{{numLiveContests}}</span></a></li>
    <li id="waiting-contest-tab"><a role="tab" data-toggle="tab" ng-click="gotoSection('upcoming')">{{getLocalizedText("tabupcoming")}}</a></li>
    <li id="history-contest-tab"><a role="tab" data-toggle="tab" ng-click="gotoSection('history')">{{getLocalizedText ("tabhistory")}}</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tabs">
    <div class="tab-content">

      <!-- LIVE CONTESTS -->
      <div class="tab-pane active" id="live-contest-content">
        <!-- Barra de resumen de actividad -->
        <div class="resume-bar"><span class="information-no-contest">{{liveContestsMessage}}</span></div>

        <section ng-unless="loadingService.isLoading" ng-switch="hasLiveContests">
          <!-- lista vacía -->
          <div class="no-contests-wrapper" ng-switch-when="false">
            <div class="no-contests-content">
              <div class="default-info-text" ng-bind-html="getLocalizedText('nolives')"></div>
              <div class="no-contests-text">{{getLocalizedText("nolivestip1")}} <strong data-toggle="tab" ng-click="gotoSection('upcoming')">{{getLocalizedText("nolivestip2")}}</strong> {{getLocalizedText("nolivestip3")}}</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list-f2p id="liveContests" contests-list="contestsService.liveContests"
                           sorting="liveSortType" on-action-click='onLiveActionClick(contest)' on-row-click='onLiveActionClick(contest)'>
            </contests-list-f2p>
          </div>
        </section>
      </div>

      <!-- WAITING CONTESTS -->
      <div class="tab-pane" id="waiting-contest-content">
        <div class="resume-bar"><span class="information-no-contest">{{waitingContestsMessage}}</span></div>

        <section ng-unless="loadingService.isLoading" ng-switch="hasWaitingContests">
          <!-- lista vacía -->
          <div class="no-contests-wrapper" ng-switch-when="false">
            <div class="no-contests-content">
              <div class="default-info-text" ng-bind-html="getLocalizedText('noupcomings')"></div>
              <div class="no-contests-text">{{getLocalizedText("noupcomingstip1")}}</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list-f2p id="waitingContests" contests-list='contestsService.waitingContests' show-date="true"
                           sorting="waitingSortType" on-action-click='onWaitingActionClick(contest)' on-row-click='onWaitingActionClick(contest)'>
            </contests-list-f2p>
          </div>
        </section>
      </div>

      <!-- HISTORY CONTESTS -->
      <div class="tab-pane" id="history-contest-content">
        <div class="resume-bar"><span class="information-no-contest">{{historyContestsMessage}}</span></div>

        <section ng-unless="loadingService.isLoading" ng-switch="hasHistoryContests">
          <!-- lista vacía -->
          <div class="no-contests-wrapper" ng-switch-when="false">
            <div class="no-contests-content">
              <div class="default-info-text" ng-bind-html="getLocalizedText('nohistorys')"></div>
              <div class="no-contests-text">{{getLocalizedText("nohistoryestip")}}</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list-f2p id="historyContests" contests-list="contestsService.historyContests" show-date="true"
                           sorting="historySortType" on-action-click='onHistoryActionClick(contest)' on-row-click='onHistoryActionClick(contest)'>
            </contests-list-f2p>
          </div>
        </section>
      </div>

    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/promos_comp.html", new HttpResponse(200, r"""<div id="promosRoot" ng-class="{'hide-promos': !hasPromos()}">
<div ng-if="!scrDet.isXsScreen">
  <a class="banner2"  ng-click="gotoPromo(0)">
  <img ng-src="{{getThumb(0,'imageDesktop')}}" class="promoDesktop" />
  </a>

  <a class="banner2" ng-click="gotoPromo(1)">
  <img ng-src="{{getThumb(1,'imageDesktop')}}" class="promoDesktop" />
  </a>
</div>

<!--<div class="beta-version-desktop" ng-if="!scrDet.isXsScreen">
  <span class="beta-version-text">VERSIÓN BETA</span>
</div>-->

<a ng-if="scrDet.isXsScreen" ng-click="gotoPromo(0)">
 <img ng-src="{{getThumb(0,'imageXs')}}" class="promoXs" />
</a>
<!--<div class="beta-version-xs" ng-if="scrDet.isXsScreen">
  <span class="beta-version-text">BETA</span>
  <img src="images/betaHeaderXsTexto.png" class="betaVersionXs" />
</div>-->
</div>"""));
tc.put("packages/webclient/components/scoring_rules_comp.html", new HttpResponse(200, r"""<div id="scoringForAll" class="panel-points">
  <div class="rules-header">{{getLocalizedText("all")}}</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in AllPlayers">
      <span class="name">{{event["name"]}}</span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForGoalKeepers" class="panel-points">
  <div class="rules-header">{{getLocalizedText("goalkeepers")}}</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in GoalKeepers">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForDefenders" class="panel-points">
  <div class="rules-header">{{getLocalizedText("defenders")}}</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Defenders ">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForMidFielders" class="panel-points">
  <div class="rules-header">{{getLocalizedText("middles")}}</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in MidFielders">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForForwards" class="panel-points">
  <div class="rules-header">{{getLocalizedText("forwards")}}</div>
  <div class=rules-content>
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Forwards">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/tutorial_list_comp.html", new HttpResponse(200, r"""<div id="tutorialListRoot">
  
  <div id="initiation" class="tutorial-tile-wrapper" ng-click="onTutorialClick('initiation')">
    <div class="tile">
      <span class="tile-info">Iniciación</span>
    </div>
  </div>
  <div id="oficialContests" class="tutorial-tile-wrapper" ng-click="onTutorialClick('oficialContests')">
    <div class="tile">
      <span class="tile-info">Jugar Torneos Oficiales</span>
    </div>
  </div>
  <div id="creatingContests" class="tutorial-tile-wrapper" ng-click="onTutorialClick('creatingContests')">
    <div class="tile">
      <span class="tile-info">Crear Torneos con tus amigos</span>
    </div>
  </div>
  
  <div class="clearfix"></div>
</div>"""));
tc.put("packages/webclient/components/view_contest/fantasy_team_comp.html", new HttpResponse(200, r"""<div id="fantasyTeamRoot" class="fantasy-team-wrapper" >

  <div class="fantasy-team-header" ng-class="{'opponent-team-gradient': isOpponent, 'header-view-contest-entry-mode': isViewContestEntryMode}">

    <div class="edit-team" ng-if="isViewContestEntryMode">
      <button class="btn-edit-team" ng-click="editTeam()">{{getLocalizedText("editlineup")}}</button>
    </div>

    <div class="ranking-box" ng-if="!isViewContestEntryMode">
      <span class="title">{{getLocalizedText("pos")}}</span>
      <span class="content">{{userPosition}}</span>
    </div>

    <div class="score-box" ng-if="!isViewContestEntryMode">
      <span class="title">{{getLocalizedText("points")}}</span>
      <span class="content">{{userScore}}</span>
    </div>

    <div class="user-picture"></div>
    <div class="user-nickname" ng-class="{'nickname-view-contest-entry-mode': isViewContestEntryMode}">{{userNickname}}</div>
    <div class="total-remaining-matches-time" ng-if="!isViewContestEntryMode">{{getLocalizedText("remainingtime")}}: {{remainingTime}}</div>

    <div class="close-team" ng-click="onCloseButtonClick()" ng-show="showCloseButton">
      <span class="title">{{getLocalizedText("close")}}</span>
      <span class="glyphicon glyphicon-remove"></span>
    </div>

  </div>

  <div class="fantasy-team-list">
    <div class="fantasy-team-slot" ng-repeat="slot in slots">
      <div class="soccer-player-row" data-toggle="collapse" data-target="#statistic_{{owner}}_{{$index}}" data-id="{{slot['id']}}">
        <div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div>
        <div class="column-primary-info">
          <span class="soccer-player-name">{{slot.fullName}}</span>
          <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
          <span class="remaining-match-time" ng-if="!isViewContestEntryMode">{{slot.percentOfUsersThatOwn}}% {{getLocalizedText("owned")}}</span>
        </div>
        <div class="column-score" ng-if="!isViewContestEntryMode"><span>{{slot.score}}</span></div>
        <div class="column-salary" ng-if="isViewContestEntryMode">${{slot.salary}}</div>
      </div>
      <div id="statistic_{{owner}}_{{$index}}" class="soccer-player-statistics collapse" ng-if="!isViewContestEntryMode">
        <div class="statistic" ng-repeat="stat in slot.stats">
          <div class="stat-times"><span>{{stat['count']}}</span></div>
          <div class="stat-name">{{stat['name']}}</div>
          <div class="stat-points">{{stat['points']}}</div>
        </div>
      </div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/teams_panel_comp.html", new HttpResponse(200, r"""<div class="teams-toggler-wrapper">
  <div id="teamsToggler" type="button" class="teams-toggler toggleOff" ng-click="toggleTeamsPanel()"  data-toggle="collapse" data-target="#teamsPanel">{{getLocalizedText("showmatches")}}</div>
</div>
<div id="teamsPanelRoot" ng-show="contest != null" class="animate">

  <div class="teams-comp-bar" >

    <div id="teamsPanel" class="teams-container collapse">
      <div class="top-border"></div>
      <div class="teams-box" ng-repeat="match in matchEventsSorted">
        <div class="teams-info" ng-bind-html="getMatchAndPeriodInfo($index)"></div>
      </div>
      <div class="bottom-border"></div>
    </div>
  </div>


</div>"""));
tc.put("packages/webclient/components/view_contest/users_list_comp.html", new HttpResponse(200, r"""<div id="usersListRoot" >

  <div ng-class="{'users-header-next': isViewContestEntryMode, 'users-header' : !isViewContestEntryMode}">
    <h1>{{getLocalizedText("title")}}</h1>
    <h2 ng-if="!isViewContestEntryMode">{{getLocalizedText("desc")}}:</h2>
  </div>

  <div class="users-table-header">
    <div class="pos">{{getLocalizedText("pos")}}</div>
    <div class="name" ng-class="{'name-view-contest-entry-mode': isViewContestEntryMode}">{{getLocalizedText("player")}}</div>
    <div class="remaining-time" ng-if="!isViewContestEntryMode">{{getLocalizedText("rt")}}</div>
    <div class="score-container">{{getLocalizedText("points")}}</div>
    <div class="prize-container" ng-if="!isViewContestEntryMode">{{getLocalizedText("prizes")}}</div>
  </div>

  <div class="users-table-rows">
    <div class="user-row" ng-repeat="user in users" ng-click="onUserClick(user)" ng-class="{'user-main': isMainPlayer(user)}">
      <div class="pos">{{$index + 1}}</div>
      <div class="name" ng-class="{'name-view-contest-entry-mode': isViewContestEntryMode}">{{user.name}}</div>
      <div class="remaining-time" ng-if="!isViewContestEntryMode">{{user.remainingTime}}</div>
      <div class="score-container"><span>{{user.score}}</span></div>
      <div class="prize-container" ng-if="!isViewContestEntryMode">{{getPrize($index)}}</div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/view_contest_comp.html", new HttpResponse(200, r"""<section>

  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId"></contest-header-f2p>

  <div id="viewContestRoot" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
     <!-- Tabs de la versión XS -->
      <ul class="view-contest-tabs" id="liveContestTab" >
        <li class="active"> <a id="userFantasyTeamTab" ng-click="tabChange('userFantasyTeam')">{{getLocalizedText("yourlineup")}}</a></li>
        <li>                <a id="usersListTab" ng-click="tabChange('usersList')">{{getLocalizedText("users")}}</a></li>
        <li ng-disabled="!isOpponentSelected"><a id="opponentFantasyTeamTab" ng-click="tabChange('opponentFantasyTeam')">{{lastOpponentSelected}}</a></li>
      </ul>

      <div class="tab-content" id="liveContestTabContent">
        <fantasy-team class="tab-pane active" id="userFantasyTeam" contest-entry="mainPlayer" watch="updatedDate" is-opponent="false"></fantasy-team>
        <users-list class="tab-pane" id="usersList" contest-entries="contestEntries" on-row-click="onUserClick(contestEntry)" watch="updatedDate"></users-list>
        <fantasy-team class="tab-pane" is-opponent="true" id="opponentFantasyTeam" parent="ctrl" contest-entry="selectedOpponent" watch="updatedDate"></fantasy-team>
      </div>
    </div>

    <div ng-switch-when="false">
      <fantasy-team id="userFantasyTeam" contest-entry="mainPlayer" watch="updatedDate" is-opponent="false"></fantasy-team>
      <users-list id="usersList" ng-show="selectedOpponent == null" contest-entries="contestEntries" on-row-click="onUserClick(contestEntry)" watch="updatedDate"></users-list>
      <fantasy-team id="opponentFantasyTeam" contest-entry="selectedOpponent" is-opponent="true" ng-show="selectedOpponent != null"
                    show-close-button="true" on-close="selectedOpponent=null" watch="updatedDate"></fantasy-team>
    </div>
    <div class="contest-id-bar">
      <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
    </div>
    <div class="clear-fix-bottom"></div>
  </div>

</section>
"""));
tc.put("packages/webclient/components/view_contest/view_contest_entry_comp.html", new HttpResponse(200, r"""<section ng-show="!loadingService.isLoading">

  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId"></contest-header-f2p>

  <!--<div class="separator-bar"></div>-->
  <div class="info-complete-bar" ng-if="!isModeViewing">
    <p ng-if="isModeCreated">{{getLocalizedText("created")}}</p>
    <p ng-if="isModeEdited">{{getLocalizedText("edited")}}</p>
    <p ng-if="isModeSwapped">{{getLocalizedText("swapped")}}</p>
    <p>{{getLocalizedText("tip")}}</p>
  </div>

  <div id="viewContestEntry" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
      <!-- Tabs de la versión XS -->
      <ul class="view-contest-entry-tabs" id="viewContestEntryTab" >
        <li class="active"><a ng-click="tabChange('userFantasyTeam')" data-toggle="tab">{{getLocalizedText("yourlineup")}}</a></li>
        <li><a ng-click="tabChange('usersList')" data-toggle="tab">{{getLocalizedText("users")}}</a></li>
      </ul>
      <div class="tab-content" id="viewContestEntryTabContent">
        <fantasy-team class="tab-pane active" id="userFantasyTeam" contest-entry="mainPlayer" watch="updatedDate" is-opponent="false"></fantasy-team>
        <users-list class="tab-pane" id="usersList" contest-entries="contestEntries" watch="updatedDate"></users-list>
      </div>
    </div>

    <div ng-switch-when="false">
      <fantasy-team id="userFantasyTeam" contest-entry="mainPlayer" watch="updatedDate" is-opponent="false"></fantasy-team>
      <users-list id="usersList" ng-show="selectedOpponent == null" contest-entries="contestEntries" watch="updatedDate"></users-list>
    </div>


    <div class="view-contest-entry-actions-wrapper">
<!-- Nuevos Bottons Autocentrables-->
  <div class="new-row">
    <div class="autocentered-buttons-wrapper">
      <div ng-if="scrDet.isXsScreen" class="button-box"><button type="button" class="ok-button" ng-click="goToParent()">{{getLocalizedText("backtocontests")}}</button></div>
      <!--div class="button-box"  ng-if="isModeViewing || isModeEdited"><button type="button" class="cancel-button" ng-click="confirmContestCancellation()">{{getLocalizedText("cancel")}}</button></div-->
      <div ng-if="!scrDet.isXsScreen" class="button-box ok"><button type="button" class="ok-button" ng-click="goToParent()">{{getLocalizedText("backtocontests")}}</button></div>
    </div>
  </div>
<!-- End Nuevos Bottons Autocentrables-->



      <!--Viejos Bottons
      <div class="button-wrapper">
        <button type="button" class="btn-cancel-contest" ng-click="cancelContestEntry()">ABANDON</button>
      </div>
      <div class="button-wrapper">
        <button type="button" class="btn-back-contest" ng-click="goToParent()">SAVE CHANGES</button>
      </div>
      End Viejos Bottons-->


    </div>
    <div class="clear-fix-bottom"></div>
  </div>
<ng-view></ng-view>
</section>"""));
tc.put("packages/webclient/components/week_calendar_comp.html", new HttpResponse(200, r"""<div class="week-calendar">
  <ul class="week-days-wrapper">
    <li class="week-day {{$index==0? ' today':''}} {{isCurrentSelected(day['date'], $index)? ' active':''}}{{(!day['enabled'])? ' disabled':''}}"  ng-click="selectDay($event, day)" ng-repeat="day in dayList">
      <div class="day-info"> 
        <span class="week-day-name">{{getLocalizedText(day["weekday"])}}</span>
        <span class="day-number">   {{day["monthday"]}}</span>
      </div>
    </li>
  </ul>
</div>"""));
}