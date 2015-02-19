// GENERATED, DO NOT EDIT!
library template_cache;

import 'package:angular/angular.dart';

primeTemplateCache(TemplateCache tc) {
tc.put("packages/webclient/components/account/add_funds_comp.html", new HttpResponse(200, r"""<div id="addFundsContent">

  <!-- header title -->
  <div class="default-section-header">ADD FUNDS</div>

  <div>
    <div class="description">
      <p id="descriptionTip1">In order to play Epic Eleven with real money, you need to add funds to your account.</p>
      <p id="descriptionTip2">Don't worry, you can withdraw your money whenever you want for free.</p>
    </div>
    <div class="add-founds-box">
      <p>Minimum allowed is 10€</p>
      <div class="money-selector">
        <div class="money-element">
          <input type="radio" name="money-radio" id="firstOffer" value="10"><label for="firstOffer">10€</label>
        </div>
        <div class="money-element">
          <input type="radio" name="money-radio" id="secondOffer" value="25" checked="checked"><label for="secondOffer">25€</label>
        </div>
        <div class="money-element">
          <input type="radio" name="money-radio" id="thirdOffer" value="50"><label for="thirdOffer">50€</label>
        </div>
        <div class="money-element custom-money-element">
          <input type="radio" name="money-radio" id="customEuros">
          <input type="number" id="customEurosAmount" value="10"><label for="customEuros">€</label>
        </div>
      </div>
      <h2 class="paypal-info">Add <span id="selectedAmountInfo">25€</span> vía <img src="images/markPaypalMed.jpg"></h2>
      <p class="paypal-info">You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.</p>
      <div class="button-wrapper"><button class="add-funds-button" id="addFundsButton">Add funds</button></div>
    </div>
  </div>
  <div class="need-help-box">
    <p id="need-help-text">Need help?</p>
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
  <div id="changePasswordBox" class="main-box">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div ng-switch="state">
          <!-- SI ES INVALID URL -->
          <div ng-switch-when="STATE_INVALID_URL"     class="panel-title">ERROR 503</div>
          <!-- SI ES TOKEN INVALIDO -->
          <div ng-switch-when="STATE_INVALID_TOKEN"   class="panel-title">CHANGE PASSWORD</div>
          <!-- SI ES TOKEN VALIDO/INVALIDO -->
          <div ng-switch-when="STATE_CHANGE_PASSWORD" class="panel-title">CHANGE PASSWORD</div>
        </div>

        <button type="button" class="close" ng-click="navigateTo('landing_page',{}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>

      </div>
      <div class="panel-body" >

        <form  id="changePasswordForm" class="form-horizontal" ng-submit="changePassword()" role="form">
          <div ng-switch="state">
                <div ng-switch-when="STATE_INVALID_URL" class="form-description">
                  The page is not available
                </div>
                <div ng-switch-when="STATE_INVALID_TOKEN" class="form-description">
                  The provided token is invalid or has expired.
                </div>
                <div ng-switch-when="STATE_CHANGE_PASSWORD">
                  <div class="form-description">
                    Create a new password.
                  </div>
                  <!-- PASSWORD -->
                  <div  class="user-form-field">
                    <!-- Description -->
                    <div class="new-row bottom-separation-10">
                      <div class="small-text"> Password: at least {{MIN_PASSWORD_LENGTH}} characters. (Type it twice).</div>
                    </div>
                    <!-- Field Input 1 -->
                    <div id="passwordInputGroup" class="input-group  bottom-separation-10">
                      <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
                      <input id="password" name="password" type="password"  placeholder="Password"         ng-model="thePassword"   data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH" class="form-control" tabindex="1" autocapitalize="off" auto-focus>
                    </div>
                    <!-- Field Input 2 -->
                    <div id="rePasswordInputGroup" class="input-group">
                      <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
                      <input id="rePassword" name="password" type="password" placeholder="Repeat password" ng-model="theRePassword" data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH" class="form-control" tabindex="2" autocapitalize="off">
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
                        <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">CONTINUE</button>
                        <button id="btnCancelLogin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCEL</button>
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
    <span class="header-title">EDIT ACCOUNT</span>
  </div>
  <form id="editPersonalDataForm" class="form-horizontal" ng-submit="saveChanges()" role="form" autocomplete="off">
    <div class="content">
      <!-- Nombre -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">Name</span></div>
        <div class="control-wrapper">
          <input id="txtName" type="text" ng-model="editedFirstName" placeholder="Name" class="form-control"  tabindex="1">
        </div>
      </div>
      <!-- Apelidos -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">Last name</span></div>
        <div class="control-wrapper">
          <input id="txtLastName" type="text" ng-model="editedLastName" placeholder="Last name" class="form-control" tabindex="2">
        </div>
      </div>
      <!-- Nickname -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">Nick</span></div>
        <div class="control-wrapper">
          <input id="txtNickName" type="text" ng-model="editedNickName" placeholder="Nick" class="form-control" tabindex="3" autocapitalize="off">
        </div>
        <!-- Error de nickName -->
        <div id="nickNameErrorContainer" class="content-field-block">
          <div id="nickNameErrorLabel" class="err-text"></div>
        </div>
      </div>

      <!-- Correo Electrónico -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">Email</span></div>
        <div class="control-wrapper">
          <input id="txtEmail" type="email" ng-model="editedEmail" placeholder="Email" class="form-control" tabindex="4" autocapitalize="off">
        </div>
        <!-- Error de mail -->
        <div id="emailErrorContainer" class="content-field-block">
          <div id="emailErrorLabel" class="err-text"></div>
        </div>
      </div>

      <!-- Label Contraseña -->
      <div class="content-field-block">
        <div class="control-wrapper"><span id="lblPassword" class="text-label">Password (Fill the both fields to update it)</span></div>
      </div>
      <!-- Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtPassword" type="password" ng-model="editedPassword" placeholder="Password" class="form-control" tabindex="5" autocapitalize="off"></div>
      </div>
      <!-- Repetir Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtRepeatPassword" type="password" ng-model="editedRepeatPassword" placeholder="Repeat password" class="form-control" tabindex="6" autocapitalize="off"></div>
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
    <div class="header">NOTIFICATIONS</div>
    <div class="subscriptions-content">

      <div class="content-field-block">

        <div class="subscription-wrapper">
          <div class="subscription-label">NEWSLETTER/SPECIAL OFFERS</div>
          <div class="check-wrapper"> <input type="checkbox" id="inputNewsletter" name="switchNewsletter"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">GAME NOTIFICATIONS</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchGameAlerts"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">OWN SOCCER PLAYER TRANSFER NOTIFICACIONS</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchsoccerPlayerAlerts"> </div>
        </div>

      </div>

    </div>

    <div class="save-changes-content">
      <div class="forms-wrapper-button">
        <button id="btnSubmit" class="action-button-save" type="submit">SAVE</button>
      </div>
      <div class="forms-wrapper-button">
        <button id="btnSubmit" class="action-button-cancel" ng-click="exit($event)">CANCEL</button>
      </div>
    </div>

  </form>
</div>"""));
tc.put("packages/webclient/components/account/join_comp.html", new HttpResponse(200, r"""<div id="joinRoot" ng-show="!loadingService.isLoading">
  <div id="signupbox" class="main-box">

    <div class="panel">

      <div class="panel-heading">
        <div class="panel-title">SIGN UP</div>
        <button type="button" class="close" ng-click="navigateTo('landing_page', {}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" >

        <form id="signupForm" class="form-horizontal" ng-submit="submitSignup()" role="form" formAutofillFix>
          <div class="form-description">Don't you have an EPIC ELEVEN account yet?<br>Fill out this form.</div>

          <!-- NICKNAME  -->
          <div class="user-form-field">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">Your nickname must be {{MIN_NICKNAME_LENGTH}} to {{MAX_NICKNAME_LENGTH}} characters long.</div>
            </div>
            <!-- Field Input -->
            <div id="nickNameInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-user"></div></span>
              <input id="nickName" name="NickName" type="text" ng-model="theNickName" placeholder="Nickname" class="form-control" maxlength="{{MAX_NICKNAME_LENGTH}}" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="nickNameError" class="join-err-text">Invalid Nickname.</div>
            </div>
          </div>

          <!-- EMAIL -->
          <div  class="user-form-field" >
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">Email:.</div>
            </div>
            <!-- Field Input -->
            <div id="emailInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
              <input id="email" name="Email" type="email" ng-model="theEmail" placeholder="Email" class="form-control" tabindex="2" autocapitalize="off">
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="emailError" class="join-err-text">Invalid Email.</div>
            </div>
          </div>

          <!-- PASSWORD -->
          <div  class="user-form-field">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">Password: Should be at least {{MIN_PASSWORD_LENGTH}} characters. (Type it twice).</div>
            </div>
            <!-- Field Input 1 -->
            <div id="passwordInputGroup" class="input-group  bottom-separation-10">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="password" name="Password" type="password" ng-model="thePassword" placeholder="Password" class="form-control" data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH"  tabindex="3" autocapitalize="off">
            </div>
            <!-- Field Input 2 -->
            <div id="rePasswordInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="rePassword" name="RePassword" type="password" ng-model="theRePassword" placeholder="Repeat password" class="form-control" tabindex="4" autocapitalize="off">
            </div>
            <!-- Error de password -->
            <div class="new-row">
              <div id="passwordError" class="join-err-text">Invalid Password.</div>
            </div>
          </div>

          <!-- BUTTONS -->
          <div class="input-group user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">SIGN UP</button>
                <button id="btnCancelJoin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCEL</button>
             </div>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="user-form-field">
            <div class="small-text">Already have an account? <a ng-click="navigateTo('login', {}, $event)"> log in here! </a></div>
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
tc.put("packages/webclient/components/account/login_comp.html", new HttpResponse(200, r"""<div id="loginRoot" ng-show="!loadingService.isLoading">
  <div id="loginBox" class="main-box">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title">LOG IN</div>
        <button type="button" class="close" ng-click="navigateTo('landing_page',{}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" >

        <form id="loginForm" class="form-horizontal" ng-submit="login()" role="form" formAutofillFix>
          <div class="form-description">Enter your email and password.</div>

          <!-- LOGIN FIELDS -->
          <div class="user-form-field">
            <!-- MAIL -->
            <div class="input-group  bottom-separation-10">
              <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
              <input id="login-mail" ng-model="emailOrUsername" type="email" name="Email" placeholder="Email" class="form-control" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- PÂSSWORD -->
            <div class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
              <input id="login-password" type="password" ng-model="password" name="password" placeholder="Password" class="form-control" tabindex="2" autocapitalize="off">
            </div>

            <!-- Error de login/pass -->
            <div id="loginErrorSection" class="new-row">
              <div id="loginErrorLabel" class="login-err-text">LOGIN ERROR: The nickname or password is not correct.</div>
            </div>

          </div>

          <!-- REMEMBER PASS -->
          <div class="user-form-field-righted">
            <a class="small-link-righted" ng-click="navigateTo('remember_password', {}, $event)">Forgot your password?</a>
          </div>

          <!-- BUTTONS -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">CONTINUE</button>
                <button id="btnCancelLogin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCEL</button>
              </div>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="small-text">Don't have an account? <a ng-click="navigateTo('join', {}, $event)"> Sign Up here! </a></div>
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
tc.put("packages/webclient/components/account/payment_comp.html", new HttpResponse(200, r"""<div>
  <a ng-click="checkoutPaypal('PRODUCT_1')"><img src="https://www.paypal.com/es_ES/ES/i/btn/btn_xpressCheckout.gif" align="left" style="margin-right:7px;"></a>
  <ng-view></ng-view>
</div>
"""));
tc.put("packages/webclient/components/account/payment_response_comp.html", new HttpResponse(200, r"""<modal>
  <div id="paymentResponse" class="main-box">
    <div class="panel">

      <div class="panel-heading">
        <div class="panel-title paypal-success">{{titleText}} pay</div>
        <!--div class="panel-title paypal-cancel" login="">Pago cancelado</div-->
        <button type="button" class="close">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>
      <div class="panel-body">
        The requested transaction cannot be completed. Please check your payment method and try again.
      </div>
    </div>
  </div>
  <!--h1>Payment Response: {{result}}</h1-->
</modal>
"""));
tc.put("packages/webclient/components/account/remember_password_comp.html", new HttpResponse(200, r"""<div id="rememberPasswordRoot" ng-show="!loadingService.isLoading">
  <div id="loginBox" class="main-box">

    <div class="panel">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title" ng-class="{'center-text':state=='STATE_REQUESTED'}">REMEMBER PASSWORD</div>
        <button ng-show="state=='STATE_REQUEST'" type="button" class="close" ng-click="navigateTo('login', {}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" ng-switch >
        <!-- Mensaje cuando todo ha ido correctamente. -->
        <div ng-show="state=='STATE_REQUESTED'">
          <div class="form-description">We have sent you an email to<br><br><p class="email-detail">'{{email}}'</p>Check your inbox and follow the instructions in the email.</div>
          <!-- BUTTONS -->
          <div class="user-form-field">
            <div class="new-row">
              <div class="buttons-wrapper">
                <button type="submit" id="btnSubmit" name="JoinNow" ng-click="backToLanding()" class="enter-button">CONTINUE</button>
              </div>
            </div>
          </div>
        </div>

        <form ng-show="state=='STATE_REQUEST'" id="rememberPasswordForm" class="form-horizontal" ng-submit="rememberMyPassword()" role="form">

          <div class="form-description">Forgot password? Enter you email and you will receive an email to recover your password.</div>

          <!-- EMAIL -->
          <div  class="user-form-field" >
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">Enter the email address used to sign up for EPIC ELEVEN:</div>
            </div>
            <!-- Field Input -->
             <div id="emailInputGroup" class="input-group">
              <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
              <input id="rememberEmail" name="Email" type="email" ng-model="email" placeholder="Email" class="form-control" tabindex="1" autocapitalize="off"  auto-focus>
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
                <button type="submit" id="btnSubmit" name="RememberPassword" ng-disabled="!enabledSubmit" class="enter-button-half">CONTINUE</button>
                <button id="btnCancelRemember" ng-click="navigateTo('login', {}, $event)" class="cancel-button-half">CANCEL</button>
             </div>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="new-row bottom-separation-10">
            <div class="small-text">Don't have an account?<a ng-click="navigateTo('join', {}, $event)"> Sign up here! </a></div>
          </div>

        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/transaction_history_comp.html", new HttpResponse(200, r"""<div id="transactionHistoryRoot">
  <!-- header title -->
  <div class="default-section-header">TRANSACTION HISTORY</div>

  <div class="transaction-headers">
    <span class="header-date">DATE</span>
    <span class="header-id">ID</span>
    <span class="header-concept">SUBJECT</span>
    <span class="header-amount">VALUE</span>
    <span class="header-balance">BALANCE</span>
  </div>

  <div class="transaction-row" ng-repeat="transaction in currentPageList">
    <div class="field-date">{{transaction.formattedDate}}</div>
    <div class="field-id">{{transaction.transactionID}}</div>
    <div class="field-concept">{{transaction.transactionDescription}}</div>
    <div class="field-amount"><div class="money-label">VALUE: </div> {{transaction.value}}</div>
    <div class="field-balance"><div class="money-label">BALANCE: </div> {{transaction.balance}}</div>
  </div>

  <paginator on-page-change="onPageChange(currentPage, itemsPerPage)" items-per-page="20" list-length="transactions.length"></paginator>

</div>
"""));
tc.put("packages/webclient/components/account/user_profile_comp.html", new HttpResponse(200, r"""<div id="viewProfileContent">
  <div class="profile-content">

    <div class="personal-data">
      <div class="data-header">
        <span class="data-header-title">My Account</span>
        <div class="close-profile">
          <button type="button" class="close" ng-click="closeProfile()">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </div>
        <div class="button-wrapper"><button class="action-button" ng-click="editPersonalData()">EDIT</button></div>

      </div>
      <div class="bloque-sm">
        <div class="data-row"><span class="data-key">Full Name:</span><span class="data-value">{{userData.firstName + ' ' + userData.lastName}}</span></div>
        <div class="data-row"><span class="data-key">Nick:</span><span class="data-value">{{userData.nickName}}</span></div>
        <div class="data-row"><span class="data-key">Email:</span><span class="data-value">{{userData.email}}</span></div>
        <div class="data-row"><span class="data-key">Password:</span><span class="data-value">********</span></div>
      </div>
      <!--
      <div class="bloque-sm">
        <div class="data-row"><span class="data-key">Pais:</span><span class="data-value">&lt; Pais &gt;</span></div>
        <div class="data-row"><span class="data-key">Region:</span><span class="data-value">&lt; Region &gt;</span></div>
        <div class="data-row"><span class="data-key">Ciudad:</span><span class="data-value">&lt; Ciudad &gt;</span></div>
        <div class="data-row"><span class="data-key">Notificaciones:</span><span class="data-value">&lt; Notificaciones &gt;</span></div>
      </div>
      -->
    </div>

    <div class="pocket-data">
      <div class="data-header">
          <span class="data-header-title">WALLET</span>
          <div class="button-wrapper">
            <button class="action-button-transaction" ng-click="goTransactions()">TRANSACTIONS</button>
            <button class="action-button-get-funds" ng-click="goWithdrawFounds()">WITHDRAW FUNDS</button>
          </div>
       </div>
      <div class="data-container-9">
        <div class="data-row"><span class="data-key">Actual balance:</span><span class="data-value-balance">{{userData.balance}}</span></div>
        <!--div class="data-row"><span class="data-key">Bonus pendientes:</span><span class="data-value">&lt;pending-bonuses&gt;€</span></div-->
      </div>
      <div class="data-container-3">
        <button class="add-funds-button" ng-click="goAddFounds()">ADD FUNDS</button>
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
        <div class="data-column"><a class="data-link" href="">How to use your EPs?</a></div>
      </div>
    </div>
  </div>



</div>"""));
tc.put("packages/webclient/components/account/withdraw_funds_comp.html", new HttpResponse(200, r"""<div id="withdrawFundsContent">
  <!-- header title -->
  <div class="default-section-header">WITHDRAW FUNDS</div>

  <div class="top-separation">
    <div class="withdraw-founds-box">
      <div class="data-header">
        <span class="data-header-title">YOUR BALANCE IS <span class="money"><span id="moneyAmount">{{userData.balance}}</span></span></span>
      </div>

      <p>¿How much money want to withdraw?</p>
      <div class="money-element">
        <input type="number" id="customEurosAmount"><label for="customEuros">€</label>
      </div>
      <p class="paypal-info">You can only withdraw amounts larger to 20 €</p>
      <div class="button-wrapper"><button class="withdraw-funds-button" id="withdrawFundsButton">Withdraw funds</button></div>
    </div>
  </div>
  <div class="need-help-box">
    <p id="need-help-text">Need help?</p>
    <p id="need-help-email">support@epiceleven.com</p>
  </div>
</div>"""));
tc.put("packages/webclient/components/contest_filters_comp.html", new HttpResponse(200, r"""<div id="contestSortsFilters">

  <!-- Resumen y Botón de filtros XS -->
  <div class="choosed-filters-container" ng-show="scrDet.isXsScreen">
      <div class="competition-filter-name" ng-bind-html="filterResume"></div>
      <div class="filterToggler">
        <div id="filtersButtonMobile" type="button" class="filters-button" ng-click="toggleFilterMenu()" data-toggle="collapse" data-target="#filtersPanel">FILTERS</div>
      </div>
  </div>

  <!-- Ordenación -->
  <div id="contestFastSort">
    <span class="filter-text">Sort by: </span>
    <div class="btn-group" >
      <div ng-repeat="button in sortingButtons" id="{{button['id']}}" type="button" class="btn sorting-button" ng-class="button['state']" ng-click="sortListByField(button['field-name'])">{{button["name"].toUpperCase()}}</div>
    </div>
  </div>

  <!-- Filtro por nombre -->
  <div id="contestFastSearch">
      <input class="searcher" type="text" placeholder="Search contest" ng-model="filterContestName" ng-keyUp="filterByName()">
  </div>

  <div class="filterToggler" ng-show="!scrDet.isXsScreen">
      <div id="filtersButtonDesktop" type="button" class="filters-button" ng-click="toggleFilterMenu()" data-toggle="collapse">FILTERS</div>
  </div>

</div>

<div id="filtersPanel" class="collapse">

  <div class="filters-panel-row">

    <!-- Filtro x tipos de concurso -->
    <div class="filter-column-competition">
      <p class="filter-title">COMPETITION</p>
      <div class="filter-content">
        <div class="check-group-wrapper">

          <!-- Botones -->
          <div class="button-check-{{competitionType.flag}}" ng-repeat="competitionType in competitionFilterList">
            <input id="{{competitionType['id']}}" type="checkbox" ng-disabled="competitionType['disabled']"
                   ng-click="filterByCompetitionType(competitionType)">
            <label for="{{competitionType['id']}}">{{competitionType["text"].toUpperCase()}}</label>
          </div>

        </div>
      </div>
    </div>

    <!-- Filtro x tipos de concurso -->
    <div class="filter-column-tournaments">
      <p class="filter-title">CONTESTS</p>
      <div class="filter-content">
          <div class="check-group-wrapper">

            <!-- Botones -->
            <div class="button-check" ng-repeat="contestType in contestTypeFilterList">
              <input id="{{contestType['id']}}" type="checkbox" ng-disabled="contestType['disabled']"
                     ng-click="filterByTournamentType(contestType)">
              <label for="{{contestType['id']}}">{{contestType["text"].toUpperCase()}}</label>

            </div>
          </div>
      </div>
    </div>

    <!-- Filtro x dificultad -->
    <div class="filter-column-salary-limit">
      <p class="filter-title">SALARY CAP</p>
      <div class="filter-content">
          <div class="check-group-wrapper">

            <!-- Botones -->
            <div class="button-check" ng-repeat="tier in salaryCapFilterList">
              <input id="{{tier['id']}}" type="checkbox" ng-disabled="tier['disabled']"
                     ng-click="filterByTier(tier)">
              <label for="{{tier['id']}}">{{tier["text"].toUpperCase()}}</label>
            </div>

        </div>
      </div>
    </div>

    <div class="filter-column-entry-fee">
      <p class="filter-title">ENTRY FEE</p>
      <div class="filter-content">
         <div class="entry-fee-value-min">MIN: {{filterEntryFeeRangeMin | number:0}}€ </div>
         <div class="entry-fee-value-max">MAX: {{filterEntryFeeRangeMax | number:0}}€ </div>
          <div class="slider-wrapper">
            <div id="slider-range"></div>
          </div>
      </div>
    </div>

  </div>
  <div class="filters-panel-row">

      <div class="reset-button-wrapper">
        <button type="button" class="btn-reset" ng-click="resetAllFilters()">CLEAR FILTERS</button>
      </div>
      <div class="confirm-button-wrapper">
        <button type="button" class="btn-confirm" ng-click="toggleFilterMenu()">ACCEPT</button>
      </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/contest_header_comp.html", new HttpResponse(200, r"""<div id="contestHeaderWrapper">
  <div ng-if="isInsideModal" class="border-top"></div>
  <div class="contest-relevant-data">
    <div class="contest-name-description">
      <div class="contest-name">{{info['description']}}</div>
      <div class="contest-explanation">{{info['contestType']}} {{info['contestantCount']}}</div>
   </div>
    <div class="contest-price">
      <div class="contest-coins-content"><span>{{info['entryPrice']}}</span></div>
      <div class="contest-coins-header">ENTRY FEE</div>
    </div>

    <div class="contest-prize">
      <div class="contest-coins-content prize-icon-big"><span>{{info['prize']}}</span></div>
      <div class="contest-coins-header">
        <div class="contest-coins-header-title">PRIZES</div>
        <!--<div class="contest-coins-header-prize-type">{{info['prizeType']}}</div>-->
      </div>

    </div>
  </div>

  <div class="date-time-data">
    <div class="contest-start-date">
      <span>{{info['startTime']}}&nbsp;</span>
    </div>
    <div class="contest-countdown-text">
      <span class="text-countdown">{{info['textCountdownDate']}}&nbsp;</span>
      <span class="time-countdown">{{info['countdownDate']}}&nbsp;</span>
    </div>
  </div>

  <div class="close-contest" ng-switch="isInsideModal">
    <button type="button" ng-switch-when="true"  class="close" data-dismiss="modal">   <span class="glyphicon glyphicon-remove"></span></button>
    <button type="button" ng-switch-when="false" class="close" ng-click="goToParent()"><span class="glyphicon glyphicon-remove"></span></button>
  </div>

</div>

<div class="clearfix"></div>
"""));
tc.put("packages/webclient/components/contest_info_comp.html", new HttpResponse(200, r"""<modal id="contestInfoModal" ng-if="isModal">

  <contest-header id="contestInfoHeader" contest="contest" contest-id="contestId"  modal="true"></contest-header>

  <div class="modal-info-content">

      <div class="tabs-background">
        <!-- Nav tabs -->
        <div class="tabs-navigation">
          <ul class="contest-info-tabs " id="modalInfoContestTabs">
              <li class="tab active"><a data-toggle="tab" ng-click="tabChange('info')">Information</a></li>
              <li class="tab"><a data-toggle="tab" ng-click="tabChange('contestants')">Contenders</a></li>
              <li class="tab"><a data-toggle="tab" ng-click="tabChange('prizes')">Prizes</a></li>
              <!--<li class="buton-place">
                <button id="btn-go-enter-contest" class="btn btn-primary" ng-click="enterContest()">ENTER</button>
              </li>-->
          </ul>

          <div id="enterContestButton">
            <button id="btn-go-enter-contest" class="btn btn-primary" ng-click="enterContest()">ENTER</button>
          </div>
        </div>
      </div>

      <div class="contest-info-content" id="modalInfoContestTabContent">
          <div class=" tab-content">

              <!-- Tab panes -->
              <div class="tab-pane active" id="info">
                  <p class="instructions">{{currentInfoData['rules']}}</p>
                  <div class="matches-involved">
                      <div class="match" ng-repeat="match in currentInfoData['matchesInvolved']">
                          <p class="teams">{{match.soccerTeamA.shortName}} - {{match.soccerTeamB.shortName}}</p>
                          <p class="date">{{formatMatchDate(match.startDate)}}</p>
                      </div>
                  </div>
                  <div class="clearfix"></div>
                  <p class="bases-title">SCORING RULES</p>

                  <div class="rules-description">
                    <scoring-rules></scoring-rules>
                  </div>
              </div>

              <div class="tab-pane" id="contestants">
                <div class="contestant-list-wrapper">
                  <div ng-if="!loadingService.isLoading && currentInfoData['contestants'].isEmpty" class="default-info-text">
                    There are still no contenders in this contest. <br> Encourage to be the first.
                  </div>
                  <div class="contestant-list">
                    <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
                      <div class="contestant-position">{{$index + 1}}º</div>
                      <div class="contestant-name">{{contestant.name}}</div>
                      <div class="contestant-points">{{contestant.wins + ' '}}<span class="prize-currency">Wins</span></div>
                    </div>
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

  <p class="title">SCORING POINTS</p>
  <div class="rules-description">
    <scoring-rules></scoring-rules>
  </div>
  <div class="clearfix"></div>
  <div class="info-section"></div>

  <p class="title">PRIZES</p>
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

  <p class="title">CONTENDERS</p>
  <div ng-if="!loadingService.isLoading && currentInfoData['contestants'].isEmpty" class="default-info-text">
    There are still no contenders in this contest. <br> Encourage to be the first.
  </div>
  <div class="contestant-list">
      <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
          <div class="contestant-position">{{$index + 1}}º</div>
          <div class="contestant-name">{{contestant.name}}</div>
          <div class="contestant-points">{{contestant.wins + ' '}}<span class="prize-currency">Wins</span></div>
      </div>
  </div>
  <div class="clearfix"></div>
</div>

"""));
tc.put("packages/webclient/components/contests_list_comp.html", new HttpResponse(200, r"""<div class="contests-list-root">
  <div class="contest-row" ng-repeat="contest in currentPageList">

    <div class="column-contest-name" ng-click="onRow(contest)">
      <div class="column-name">{{contest.name}}</div>
      <div class="column-start-date-time-xs">{{dateInfo(contest.startDate)}} {{timeInfo(contest.startDate)}}</div>
      <div class="column-description">{{contest.description}}</div>
    </div>

    <div class="column-contest-empty" ng-click="onRow(contest)" ng-if="contest.isLive"></div>

    <div class="column-contest-price" ng-click="onRow(contest)" ng-if="!contest.isLive && !contest.isHistory">
      <div class="column-contest-price-content">{{contest.entryFee}}</div>
      <div class="column-contest-price-header">ENTRY FEE</div>
      <!-- torneo gratis -->
      <!--<div ng-if="isFreeContest(contest)"><img src="images/iconFree.png" alt="GRATIS"></div>-->
    </div>

    <div class="column-contest-position" ng-click="onRow(contest)" ng-if="contest.isLive || contest.isHistory">
      <div class="column-contest-position-content"><span>{{printableMyPosition(contest)}}</span></div>
      <div class="column-contest-position-header">OF {{contest.maxEntries}}</div>
    </div>

    <div class="column-contest-prize" ng-click="onRow(contest)" ng-if="!contest.isLive">
      <div ng-if="!contest.isHistory" class="column-contest-prize-content" ng-class="{'prize-icon-big':contest.prizePool.amount > 0}">{{contest.prizePool}}</div>
      <div ng-if="contest.isHistory"  class="column-contest-prize-content prize-icon-big">{{getMyPrize(contest)}}</div>
      <div class="column-contest-prize-header">PRIZE</div>
    </div>

    <div class="column-contest-points" ng-click="onRow(contest)" ng-if="contest.isLive">
      <div class="column-contest-points-content"><span>{{getMyFantasyPoints(contest)}}</span></div>
      <div class="column-contest-points-header">POINTS</div>
    </div>

    <div class="column-contest-start-date" ng-click="onRow(contest)" ng-if="!contest.isLive">
      <div class="column-start-date-day">{{dateInfo(contest.startDate)}}</div>
      <div class="column-start-date-hour">{{timeInfo(contest.startDate)}}</div>
    </div>

    <div class="column-contest-action">
      <button type="button" class="action-button" ng-click="onAction(contest)">{{actionButtonTitle}}</button>
    </div>

  </div>

  <paginator on-page-change="onPageChange(currentPage, itemsPerPage)" list-length="contestsListFiltered.length"></paginator>

</div>"""));
tc.put("packages/webclient/components/enter_contest/enter_contest_comp.html", new HttpResponse(200, r"""<div id="enter-contest-wrapper" >

  <contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header>

  <!-- Nav tabs -->
  <ul class="enter-contest-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('lineup-tab-content')">Your Lineup</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('contest-info-tab-content')">Contest Info</a></li>
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
                <span class="total-salary-money" ng-show="contest != null">{{availableSalary}}€</span>
              </div>
              <button id="cancelSoccerPlayerSelection" type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer">CANCEL</button>
            </div>

            <div class="enter-contest-lineup-wrapper">
              <div class="enter-contest-lineup">
                <div class="enter-contest-total-salary">
                    <span class="total-salary-text">YOUR LINEUP</span>
                    <div class="total-salary">
                      <span class="total-salary-text">REMAINING SALARY:</span>
                      <span class="total-salary-money" ng-class="{'red-numbers': availableSalary < 0 }" ng-show="contest != null">{{availableSalary}}€</span>
                    </div>
                </div>

                <lineup-selector ng-show="!isSelectingSoccerPlayer || scrDet.isNotXsScreen"></lineup-selector>
              </div>
            </div>

            <div class="enter-contest-soccer-players-wrapper" ng-show="isSelectingSoccerPlayer || scrDet.isNotXsScreen">
              <div class="enter-contest-soccer-players">

                <!-- Este es el desplegable para el movil -->
                <matches-filter contest="contest" selected-option="matchFilter" ng-if="scrDet.isXsScreen"></matches-filter>

                <soccer-players-filter name-filter="nameFilter" field-pos-filter="fieldPosFilter"></soccer-players-filter>

                <soccer-players-list soccer-players="allSoccerPlayers"
                                     lineup-filter="lineupSlots"
                                     field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                                     on-row-click="onRowClick(soccerPlayerId)"
                                     on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-list>
              </div>
            </div>

            <div class="enter-contest-actions-wrapper">
              <div class="button-wrapper-block" ng-if="isSelectingSoccerPlayer && scrDet.isXsScreen">
                <button type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer" >CANCEL</button>
              </div>
              <div  class="bottom-content" ng-if="!isSelectingSoccerPlayer || scrDet.isNotXsScreen">
                <div class="button-wrapper">
                  <button type="button" class="btn-clean-lineup-list" ng-click="deleteFantasyTeam()" ng-disabled="isPlayerSelected()">REMOVE ALL</button>
                </div>
                <div class="button-wrapper">
                  <button type="button" class="btn-confirm-lineup-list" ng-click="createFantasyTeam()" ng-disabled="isInvalidFantasyTeam">CONTINUE</button>
                </div>
                <p>Remember that you can edit your team as many times as you want until the contest starts</p>
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
      <div class="column-fieldpos">{{getSlotPosition($index)}}</div>
      <div class="column-empty-slot">{{getSlotDescription($index)}}</div>
      <div class="column-action"><a class="iconButtonSelect"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
    </div>

    <div ng-if="slot != null">
      <div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div>
      <div class="column-primary-info">
        <span class="soccer-player-name">{{slot.fullName}}</span>
        <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
      </div>
      <div class="column-salary">{{slot.salary}}€</div>
      <div class="column-action"><a class="iconButtonRemove"><span class="glyphicon glyphicon-remove"></span></a></div>
    </div>
  </div>

  <div class="alert alert-danger alert-dismissible alert-red-numbers" role="alert">
    <button type="button" class="close" ng-click="enterContestComp.alertDismiss()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
    <strong>You've spent the salary cap</strong><br> Please choose players that fit the budget.
  </div>

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
        <button class="button-cancel" data-dismiss="modal">CANCEL</button>
        <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">ADD</button>
    </div>

    <!-- En el resto de versiones título y cruz de cerrar -->
    <div class="actions-header-sm">
      <div class="text-header">PLAYER STATISTICS</div>
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
        <div class="soccer-player-fantasy-points"><span>DFP</span><span>{{currentInfoData['fantasyPoints']}}</span></div>
        <div class="soccer-player-matches"><span>MATCHES</span><span>{{currentInfoData['matchesCount']}}</span></div>
        <div class="soccer-player-salary"><span>SALARY</span><span>{{currentInfoData['salary']}}</span></div>
      </div>
    </div>

    <div class="next-match-wrapper">
      <div class="next-match"  ng-bind-html="currentInfoData['nextMatchEvent']"></div>
      <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">ADD</button>
    </div>

  </div>

  <div class="soccer-player-stats-content">
      <!-- Nav tabs -->
      <ul id="soccer-player-stats-tabs" class="soccer-player-stats-tabs" role="tablist">
        <li id="seasonTab" class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('season-stats-tab-content')">Season data</a></li>
        <li id="matchTab" ><a role="tab" data-toggle="tab" ng-click="tabChange('match-by-match-stats-tab-content')">match by match</a></li>
      </ul>

      <div class="tabs">
        <!-- Tab panes -->
        <div class="tab-content">
          <!-- START BY-SEASON-STATS -->
          <div class="tab-pane active" id="season-stats-tab-content">
            <div class="next-match" ng-bind-html="currentInfoData['nextMatchEvent']"></div>
            <!-- MEDIAS -->
            <div class="season-header">SEASON STATISTICS <span>(DATA BY MATCH)</span></div>
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
            <div class="match-header">MATCH BY MATCH</div>
            <div class="noMatchesPlayed" ng-class="{'hidden':currentInfoData['matchesCount'] > 0}">
                <span>Has not played any game this season</span>
            </div>
            <div class="match-stats-table-wrapper" ng-class="{'hidden':currentInfoData['matchesCount'] == 0}">
              <!--HEADER-->
              <table id="statsTable" class="table table-striped">
                <thead class="stats-headings">
                  <tr>
                    <th class="head-of-headings">Season</th> <!-- necesitamos una vacía -->
                    <th class="stat-field-header" ng-repeat="item in seasonTableHeaders">{{item}}</th>
                  </tr>
                </thead>
                <tbody class="stats-rows">
                  <tr ng-repeat="year in seasonsList">
                    <td class="year-season">
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
    <button class="button-cancel" data-dismiss="modal">CANCEL</button>
    <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">ADD</button>
  </div>
</modal>

"""));
tc.put("packages/webclient/components/enter_contest/soccer_players_filter_comp.html", new HttpResponse(200, r"""<div class="soccer-players-filter">

  <div class="filter-by-position" ng-if="scrDet.isNotXsScreen">
    <span>Players</span>
    <button class="button-filter-position" ng-click="fieldPosFilter = fieldPos"
            ng-repeat="fieldPos in posFilterList" ng-bind-html="getTextForFieldPos(fieldPos)" ng-class="getClassForFieldPos(fieldPos)"></button>
  </div>

  <input type="text" class="name-player-input-filter" placeholder="Search player..." ng-model="nameFilter" />
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/beta_info_comp.html", new HttpResponse(200, r"""<div id="betaComp">
  <!-- header title -->
  <div class="default-section-header">EPIC ELEVEN: BETA VERSION</div>

  <div class="block-blue-header">
    <div class="title_white">SECTION NOT AVAILABLE</div>
  </div>
  <div class="beta-info-wrapper">
    <div class="texto">
      Sorry, this is a beta version of Epic Eleven.<br>
      We are working hard on all the features that Epic Eleven will include.
      We will keep you updated.
      <br><br>
      <b>Thank you</b>
    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/help_info_comp.html", new HttpResponse(200, r"""<div id="helpInfo">

  <!-- header title -->
  <div class="default-section-header">HELP</div>

  <!-- Nav tabs -->
  <ul class="help-info-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('how-works-content')">How it works</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('rules-scores-content')">Rules and scoring</a></li>
  </ul>

  <div class="tab-pane active" id="how-works-content">
    <div class="block-light">
      <div class="title">Choose a contest</div>
      <div class="description"><p>In the Lobby you can find several contests to participate, either with your friends or with other players.</p>Play as many contests as you like: new contests EVERY week!<br> Use as many lineups as you want, or always the same if possible: is totally up to you. <br> Daily contests, not season long-term commitment.</div>
      <!--div class="description">
      <p>
      In the Lobby you can find several contests to participate, either with your friends or with other players.
      </p>

      <ul><li>Play as many contests as you like: new contests EVERY week!</li><li> Use as many lineups as you want, or always the same if possible: is totally up to you. </li><li> Daily contests, not season long-term commitment.</li></ul>

      </div-->

      <div class="img-wrapper">
        <img src="images/help01.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help01-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
      <div class="description">You can filter contests by competition, salary cap, entry fee or contest type.</div>
      <div class="img-wrapper">
        <img src="images/help02.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help02-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
    </div>
    <div class="block-dark">
      <div class="title">PICK YOUR TEAM</div>
      <div class="description"><p>Next, choose your lineup. Pick 11 players and remember:</p> You can't spend more than your salary cap.<br>You can't choose more than 4 players from the same team.</div>
      <div class="img-wrapper">
        <img src="images/help03.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help03-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
      <!--div class="description">Do not forget you can view the statistics of the players you have chosen <br>in real time and compare the results of your alignment with other users.</div-->
    </div>
    <div class="block-light">
      <div class="title">SCORE AND WIN</div>
      <!--div class="description">In EPIC ELEVEN be a good football manager has a reward.<br>Make your lineup for each tournament you want to participate and observe the statistics of the players.<br>Prove you're the best, because soon you'll win fantastic prizes.</div-->
      <div class="img-wrapper">
        <img src="images/help04.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help04-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
      <!--div class="img-wrapper"-->
        <!--img src="images/help05.jpg" ng-if="!scrDet.isXsScreen"-->
        <!--p class="img-footer">Compare your lineup with other users live.</p-->
      <!--/div-->
    </div>
    <div class="block-light">
      <div class="title">PLAY EVERYWHERE</div>
      <div class="block-last">
        <div class="img-wrapper-left">
          <img src="images/help06.jpg">
        </div>
        <div class="description-right">
          <p>It is very easy to play EPIC 11 from any device, any place. You can keep track of your lineup's live stats from your computer, tablet or smartphone, with an optimized interface for each one.</p>
          <!--p>See how easy it is to participate in contests EPIC 11 from wherever you want. You can follow live stats of your players from your computer, tablet or smartphone optimized for all devices,to improve usability.</p-->
          <button type="button" class="button-play" ng-click="goTo('lobby')">PLAY NOW</button>
        </div>
      </div>
    </div>
  </div>
  <div class="tab-pane" id="rules-scores-content">
    <div class="block-dark">
      <div class="title">SCORING AND RULES</div>
      <div class="scores-wrapper">
        <scoring-rules></scoring-rules>
      </div>
    </div>
    <div class="block-light">
      <div class="title">RULES</div>
      <div class="toogle-block">
        <input type="checkbox" id="rule1" class="toggle">
        <label for="rule1">LEGALS</label>
        <div>
          <p>To play any of our tournaments, you must be 18 years or older and a resident in Spain. For further information, please, see our<a ng-click="goTo('terminus_info')">Terms of Use</a>.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule2" class="toggle">
        <label for="rule2">MULTI ACCOUNTS</label>
        <div>
          <p>Each Epic Eleven player, can only own a single account. However, in special cases, Epic Eleven allows the creation of a second account. To do this, you must revceive express written permission of Epic Eleven before opening the second account. In this case, is Epic Eleven final decision, determining the right of a user to ve in possession of two accounts. The penalties will be issued at the discretion of Epic Eleven staff and may involve the closuere of all user accounts and retention of cach, if we determine that has been obtained fraudulently.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule3" class="toggle">

        <label for="rule3">BANNED ACCOUNTS</label>
        <div>
          <p>There are certain behaviors that are detrimental to "Epic Eleven" and the other players. These behaviors may imply the cancellation of some (or all) of the functions associated with a user account. As a result of the foregoing, users whose accounts have been canceled shall respect the disciplinary measures imposed. All communication pertaining to the restoration of a user account must be made through the email account support@epiceleven.com.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule4" class="toggle">
        <label for="rule4">NICKNAMES</label>
        <div>
          <p>"Epic Eleven" holds the right to request to change user name where that is offensive or respond to commercial interests. The requirement of change will be determined solely by Epic Eleven. If the user ignores the request, Epic Eleven alter this username.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule5" class="toggle">
        <label for="rule5">UNFILLED CONTESTS</label>
        <div>
          <p>All open tournaments that take place in Epic Eleven have a certain prize and a number of specific participants. If at the start of the tournament this number of participants is not reached, it may be canceled. For example, a competition "One on One" without 2 competitors and a league of 10 people with only 9 participants can not be held.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule6" class="toggle">
        <label for="rule6">CANCEL PARTICIPATION</label>
        <div>
          <p>Users can cancel participation in any tournament by clicking the "Cancel Entry" button at the bottom left of the section in which you can edit your team. Once the tournament has begun the button "Cancel entry" disappear. Eleven Epic will not consider requests for cancellation of entries in competitions that are completed during the first 15 minutes of the start of the game. Epic Eleven has no obligation to attend requests for cancellation that are not received or are received after the deadlines listed above in this section, due to technical difficulties or other reasons. Also, Epic Eleven will not entertain requests to cancel registrations in tournaments "One versus One". </p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule7" class="toggle">
        <label for="rule7">GAMES POSTPONED</label>
        <div>
          <p>The rules that specify the treatment of postponed games vary depending on the type of tournament. Epic Eleven reserves the right to act in this regard depending on the particular circumstances.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule8" class="toggle">
        <label for="rule8">MATCHES SUSPENDED</label>
        <div>
          <p>The rules referred to suspended matches have a given treatment depending on the type of tournament. It is considered that a match has been suspended when it is unfinished, but with prospects for completion in the future. At a minimum, the statistics collected before the end of the tournament period will be taken into account between the parties.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule9" class="toggle">
        <label for="rule9">PLAYERS IN NEGOTIATION PROCESS</label>
        <div>
          <p>The players involved in negotiation processes can affect the development of the tournaments that have already been planned considering these players in their old equipment. The listings players Epic Eleven teams are updated once a day (at night). Keep in mind that the tournaments are created with an advance of 5-6 days before the match, so players who are under negotiation may not be available for tournaments that include a game with his new team, but not with his old team. Also keep in mind that, in some cases, a player who has been selected is no longer available for a tournament that will play his old team and his new team. In this case, the user should select an alternate or be credited with zero points for the player in question.</p>
          <p>Note that, the same day that a player is under negotiation, may still appear in the list of players from his former team. If negotiation is occurring precisely negotiations with the player in the same game the rival team in which you are involved, you'll still receive points for participating in the competition. These points may not accurately reflect during the live score, but will be considered at the time of completion of the game. Also note that settlement may be delayed tournament in order to ensure maximum accuracy.</p>
          <p>In very rare cases, a player is transferred early enough in the day to play a game for his new team the same day. If it is transferred from a computer playing a game late to a team that will play a game early, you can select the player for the game to take place so late knowing that the transfer was made de facto before the game. If this is the case, you will be assigned zero points for their performance.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule10" class="toggle">
        <label for="rule10">LINEUP RESTRICTIONS</label>
        <div>
          <p>    --- -   En casos muy raros, un jugador se traspasa lo suficientemente temprano en el día como para poder jugar un partido para su nuevo equipo esa misma jornada. Si se traspasa desde un equipo que juega un partido tarde a un equipo que va a jugar un partido temprano, podrás seleccionar este jugador para el juego que tenga lugar de manera tardía aun sabiendo que el traspaso se ha realizado de facto antes del partido. Si este fuera el caso, se te asignarán cero puntos por su desempeño</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule11" class="toggle">
        <label for="rule11">PUNCTUATION REVISIONS</label>
        <div>
          <p>During the game we received scores direct from our Statistics supplier, Opta. After the game, send us the final document with full match statistics. Once received and confirmed the statistics of all matches of the day, we began to manage the liquidation of all entries. However, on rare occasions, leagues and statistics reviewed by the provider suffer some after publication of the final box score modification. If this happens, the player's score on Epic Eleven will not be updated. Note that this situation is not the same as a case where a correction must be made after closing due to a problem with the data source or the resolution process.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule12" class="toggle">
        <label for="rule12">ACCESS ASSOCIATED ISSUES</label>
        <div>
          <p>Although we assure the correct operation of Epic Eleven at any time, like any other online services, we may experience cuts or slow performance. Sometimes, the user may experience problems while accessing the service, editing lineups or entering new tournaments.</p>
          <p>If you experience problems accessing the service, please contact us vía <a href="support@epiceleven.com">support@epiceleven.com</a>. If there are long periods wich users can not access to our services, lineup editing does not work properly or other unspecified cases, from Epic Eleven, provide instructions to cancel the tickets in tournaments by email before the game starts.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule13" class="toggle">
        <label for="rule13">CONTEST CANCELLATION</label>
        <div>
          <p>Epic Eleven also reserves the right to cancel tournaments at its discretion, without any restrictions. Normally this will be done only in cases where we believe that due to problems in service or events that affect sporting events, there would be a widespread impact on most of the competitions.</p>
        </div>
      </div>
    </div>
  </div>

</div>
"""));
tc.put("packages/webclient/components/legalese_and_help/legal_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">
  <!-- header title -->
  <div class="default-section-header">LEGAL</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
    <h1>Datos de identificación</h1>
  	<p>Usted está visitando la página web www.epiceleven.com, titularidad de FANTASY SPORTS GAMES, S.L (en adelante EPIC ELEVEN). La misma está domiciliada en la Avenida de Brasil, 23, Oficinal 5-A, 28020, Madrid, siendo su e-mail de contacto: info@epiceleven.com identificada con C.I.F. B-87028445.</p>
  	<h1>Aceptación del Usuario</h1>
  	<p>Este Aviso Legal regula el acceso y utilización de la página web www.epiceleven.com (en adelante la “Web”) que EPIC ELEVEN pone a disposición de los usuarios de Internet. El acceso a la misma implica la aceptación sin reservas del presente Aviso Legal. Asimismo, EPIC ELEVEN puede ofrecer a través de la Web, servicios que podrán encontrarse sometidos a unas condiciones particulares propias sobre las cuales se informará al Usuario en cada caso concreto.</p>
  	<h1>Acceso a la Web y Contraseñas</h1>
  	<p>Al acceder a la página web de EPIC ELEVEN el usuario declara tener capacidad suficiente para navegar por la mencionada página web, esto es ser mayor de dieciocho años y no estar incapacitado. A su vez, de manera general no se exige la previa suscripción o registro como Usuario para el acceso y uso de la Web, sin perjuicio de que para la utilización de determinados servicios o contenidos de la misma se deba realizar dicha suscripción o registro. Los datos de los Usuarios obtenidos a través de la suscripción o registro a la presente Web, están protegidos mediante contraseñas elegidas por ellos mismos. El Usuario se compromete a mantener su contraseña en secreto y a protegerla de usos no autorizados por terceros. El Usuario deberá notificar a EPIC ELEVEN inmediatamente cualquier uso no consentido de su cuenta o cualquier violación de la seguridad relacionada con el servicio de la Web de la que haya tenido conocimiento. EPIC ELEVEN adopta las medidas técnicas y organizativas necesarias para garantizar la protección de los datos de carácter personal y evitar su alteración, ida, tratamiento y/o acceso no autorizado, habida cuenta del estado de la técnica, la naturaleza de los datos almacenados y los riesgos a que están expuestos, todo ello conforme a lo establecido por la legislación española de Protección de Datos de Carácter Personal. EPIC ELEVEN no se hace responsable frente a los Usuarios, por la revelación de sus datos personales a terceros que no sea debida a causas directamente imputables a EPIC ELEVEN, ni por el uso que de tales datos hagan terceros ajenos a EPIC ELEVEN.</p>
  	<h1>Uso correcto de la Web</h1>
  	<p>El Usuario se compromete a utilizar la Web, los contenidos y servicios de conformidad con la Ley, el presente Aviso Legal, las buenas costumbres y el orden público. Del mismo modo el Usuario se obliga a no utilizar la Web o los servicios que se presten a través de ésta con fines o efectos ilícitos o contrarios al contenido del presente Aviso Legal, lesivos de los intereses o derechos de terceros, o que de cualquier forma pueda dañar, inutilizar o deteriorar la Web o sus servicios o impedir un normal disfrute de la Web por otros Usuarios. Sin perjuicio de lo anterior, EPIC ELEVEN puede ofrecer a través de la web servicios adicionales que cuenten con su propia regulación adicional. En estos casos, se informará adecuadamente a los Usuarios en cada caso concreto. Asimismo, el Usuario se compromete expresamente a no destruir, alterar, inutilizar o, de cualquier otra forma, dañar los datos, programas o documentos electrónicos que se encuentren en la Web. El Usuario se compromete a no obstaculizar el acceso de otros Usuarios al servicio de acceso mediante el consumo masivo de los recursos informáticos a través de los cuales EPIC ELEVEN presta el servicio, así como realizar acciones que dañen, interrumpan o generen errores en dichos sistemas. El Usuario se compromete a no introducir programas, virus, macros, applets, controles ActiveX o cualquier otro dispositivo lógico o secuencia de caracteres que causen o sean susceptibles de causar cualquier tipo de alteración en los sistemas informáticos de EPIC ELEVEN o de terceros.</p>
  	<h1>Enlaces de terceros</h1>
  	<p>El presente Aviso Legal se refiere únicamente a la Web y contenidos de EPIC ELEVEN, y no se aplica a los enlaces o a las páginas web de terceros accesibles a través de la Web. Los destinos de dichos enlaces no están bajo el control de EPIC ELEVEN, y el mismo no es responsable del contenido de ninguna de las páginas Web de destino de un enlace, ni de ningún enlace incluido en una página Web a la que se llegue desde la Web de EPIC ELEVEN, ni de ningún cambio o actualización de dichas páginas. Estos enlaces se proporcionan únicamente para informar al Usuario sobre la existencia de otras fuentes de información sobre un tema concreto, y la inclusión de un enlace no implica la aprobación de la página Web enlazada por parte de EPIC ELEVEN.</p>
  	<h1>Propiedad intelectual</h1>
  	<p>EPIC ELEVEN advierte que los derechos de propiedad intelectual de la Web, su código fuente, diseño, estructura de navegación, bases de datos y los distintos elementos en ésta contenidos son titularidad exclusiva de EPIC ELEVEN, a quien corresponde el ejercicio exclusivo de los derechos de explotación de los mismos en cualquier forma y, en especial, con carácter enunciativo que no limitado, los derechos de reproducción, copia, distribución, transformación, comercialización, y comunicación pública. La reproducción, copia, distribución, transformación, comercialización, y comunicación pública parcial o total de la información contenida en esta Web, queda estrictamente prohibida sin la previa autorización expresa y por escrito de EPIC ELEVEN, y constituye una infracción de los derechos de propiedad intelectual e industrial.</p>
  	<h1>Foros, Blogs e imágenes</h1>
  	<p>EPIC ELEVEN ofrece a los Usuarios la posibilidad de introducir comentarios y/o de remitir fotografías, para incorporarlos en las secciones correspondientes. La publicación de los comentarios y/o las fotografías está sujeta al presente Aviso Legal. La persona identificada en cada caso como la que ha realizado los comentarios y/o ha enviado las fotografías, es responsable de los mismos. Los comentarios y/o las fotografías, no reflejan la opinión de EPIC ELEVEN, ni el mismo hace declaraciones a este respecto. EPIC ELEVEN no se hará responsable, a no ser en aquellos extremos a los que le obligue la Ley, de los errores, inexactitudes o irregularidades que puedan contener los comentarios y/o las fotografías, así como de los daños o perjuicios que se pudieran ocasionar por la inserción de los comentarios y/o las fotografías en el Foro o en las demás secciones de la Web que permitan esta clase de servicios.El Usuario suministrador del texto y/o fotografías cede a EPIC ELEVEN los derechos para su reproducción, uso, distribución, comunicación pública en formato electrónico, en el marco de las actividades para esta web. Y, en especial, el Usuario cede dichos derechos para el emplazamiento del texto y/o las fotografías en la Web, con el fin de que los demás Usuarios del sitio Web puedan acceder a los mismos. El Usuario suministrador declara ser el titular de los derechos sobre los textos o fotografías o, en su caso, garantiza que dispone de los derechos y autorizaciones necesarios del autor o propietario del texto y/o fotografías, para su utilización por parte de EPIC ELEVEN a través de la Web. EPIC ELEVEN no se hará responsable, a no ser en aquellos extremos a los que obligue la Ley, de los daños o perjuicios que se pudieran ocasionar por el uso, reproducción, distribución o comunicación pública o cualquier tipo de actividad que realice sobre los textos y/o fotografías que se encuentren protegidos por derechos de propiedad intelectual pertenecientes a terceros, sin que el Usuario haya obtenido previamente de sus titulares la autorización necesaria para llevar a cabo el uso que efectúa o pretende efectuar. Asimismo, EPIC ELEVEN se reserva el derecho de retirar de forma unilateral los comentarios y/o fotografías albergados en cualquier otra sección de la Web, cuando EPIC ELEVEN lo estime oportuno. EPIC ELEVEN no será responsable por la información enviada por el Usuario cuando no tenga conocimiento efectivo de que la información almacenada es ilícita o de que lesiona bienes o derechos de un tercero susceptibles de indemnización. En el momento que EPIC ELEVEN tenga conocimiento efectivo de que aloja datos como los anteriormente referidos, se compromete a actuar con diligencia para retirarlos o hacer imposible el acceso a ellos. En todo caso, para interponer cualquier reclamación relacionada con los contenidos insertados en el Foro o secciones análogas, puede hacerlo dirigiéndose a la siguiente dirección de correo electrónico: info@epiceleven.com.</p>
  	<h1>Modificaciones de las condiciones de uso</h1>
  	<p>EPIC ELEVEN se reserva el derecho de modificar, desarrollar o actualizar en cualquier momento y sin previa notificación las condiciones de uso de la mencionada página web. El usuario quedará obligado automáticamente por las condiciones de uso que se hallen vigentes en el momento en que acceda a la web, por lo que deberá leer periódicamente dichas condiciones de uso.</p>
  	<h1>Régimen de responsabilidad</h1>
  	<p>La utilización de la página web es responsabilidad única y exclusiva de cada Usuario, por lo que será responsabilidad suya cualquier infracción o cualquier perjuicio que pueda causar por el uso de dicha página. EPIC ELEVEN, sus socios, colaboradores, empleados y cualquier otro representante o tercero quedan pues exonerados de cualquier responsabilidad que pudiera conllevar las acciones del Usuario. EPIC ELEVEN, aún cuando ponga todo su esfuerzo en facilitar siempre información actualizada mediante su página web, no garantiza la inexistencia de errores o inexactitudes en ninguno de los contenidos, siempre que sea por razones no imputables de forma directa a EPIC ELEVEN. Por lo anterior, será el Usuario el único responsable frente a todas aquellas reclamaciones o acciones legales iniciadas contra EPIC ELEVEN basadas en el uso de la página web o sus contenidos por parte del usuario, siempre que esta utilización se haya realizado de forma ilícita, vulnerando derechos de terceros, o causando cualquier tipo de perjuicio, asumiendo por ello cuantos gastos, costes o indemnizaciones en los que pueda incurrir EPIC ELEVEN.</p>
  	<h1>Ley aplicable y Jurisdicción</h1>
	  <p>Esta Web se rige por la legislación española. EPIC ELEVEN y el Usuario, con renuncia expresa a su propio fuero, si lo tuvieren, se someten a la jurisdicción de los juzgados y tribunales de la ciudad de Madrid (España). Esto siempre que este no sea un usuario final, siendo el foro que la ley estipula el domicilio del demandado.</p>
  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/policy_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">

  <!-- header title -->
  <div class="default-section-header">POLÍTICA DE PRIVACIDAD</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
    <h1>
        Formularios Web
    </h1>
    <p>
        El Usuario podrá remitir a EPIC ELEVEN sus datos de carácter personal a través de los distintos formularios que a tal efecto aparecen incorporados en la
        Web. Dichos formularios incorporan un texto legal en materia de protección de datos personales que da cumplimiento a las exigencias establecidas en la Ley
        Orgánica 15/1999, de 13 de diciembre, de Protección de Datos de Carácter Personal, y en su Reglamento de Desarrollo, aprobado por el Real Decreto
        1720/2007, de 21 de diciembre. Por ello, rogamos lea atentamente los textos legales antes de facilitar sus datos de carácter personal.
    </p>
    <h1>
        Cláusulas de privacidad
    </h1>
    <p>
        Esta declaración tiene como finalidad informar a los usuarios de la Política general de Privacidad y Protección de Datos Personales seguida por EPIC
        ELEVEN. Esta Política de Privacidad podría variar en función del criterio empresarial o bien de aquellas modificaciones legislativas, por lo que se
        aconseja a los usuarios que la visiten periódicamente. A su vez, informamos al usuario que EPIC ELEVEN realiza el tratamiento de los datos de acuerdo a las
        finalidades que el contenido de la web www.epiceleven.com requiera. Para ello, actuará de forma proporcionada, obteniendo datos que sean pertinentes,
        enviando solo comunicaciones comerciales a quién así lo haya permitido de manera expresa en los formularios arriba mencionados.
    </p>
    <h1>
        Secreto y seguridad de los datos
    </h1>
    <p>
        EPIC ELEVEN se compromete a cumplir con el deber de secreto respecto a los datos de carácter personal. A su vez, dichos datos serán guardados adoptando las
        medidas de índole técnica y organizativa necesarias que garanticen la seguridad de los datos de carácter personal. Todo ello, con la finalidad de evitar su
        alteración, pérdida, tratamiento o acceso no autorizado, teniendo siempre en cuenta el estado de la tecnología, de acuerdo con lo establecido por el RLOPD.
    </p>
    <h1>
        Envío de comunicaciones comerciales y cesión de datos
    </h1>
    <p>
        El usuario que desee recibir la newsletter o cualquier tipo de información comercial de la empresa marcará una casilla habilitada al efecto en el
        formulario. Esto habilitará a EPIC ELEVEN para poder realizar acciones comerciales por vía electrónica, según los datos disponsibles y siempre para una
        finalidad acorde con el tratamiento de datos autorizado por el usuario, pudiendo oponerse a este tratamiento en cualquier momento. El usuario consiente que
        EPIC ELEVEN, pueda ceder datos a terceros, siempre que se trate de empresas colaboradoras, socios o proveedoras que tenga conexión con el desarrollo del
        modelo de negocio. En todo caso, cuando el prestador vaya a ceder datos del usuario a un tercero no referido anteriormente el mismo solicitará de manera
        expresa el consentimiento del usuario, garantizando su no cesión hasta la obtención del mismo.
    </p>
    <h1>
        Derechos de Acceso, rectificación, oposición y cancelación
    </h1>
    <p>
        En todo caso, cuando el usuario quisiera ejercer cualquiera de los derechos arriba mencionados podrá ponerse en contacto con EPIC ELEVEN en el correo
        electrónico: info@epiceleven.com, haciendo constar como asunto del correo el derecho a ejercer, de cara a poder facilitarle el formulario correspondiente.
    </p>
    <h1>
        Tratamiento de datos de menores de edad
    </h1>
    <p>
        La web va principalmente dirigida a usuarios mayores de edad. Sin embargo, con el objetivo de cumplir con el Real Decreto 1720/2007, de 21 de diciembre,
        por el que se aprueba el Reglamento de desarrollo de la Ley Orgánica 15/1999, de 13 de diciembre, de protección de datos de carácter personal, EPIC ELEVEN,
        informa que para proceder al tratamiento de datos de menores de 14 años requerirá el consentimiento de los padres o tutores. Corresponde a EPIC ELEVEN
        articular los procedimientos que garanticen que se ha comprobado de modo efectivo la edad del menor, y la autenticidad del consentimiento prestado en su
        caso, por lo padres, tutores o representantes legales, en caso de sospechar que es menor de catorce años.
    </p>
    <h1>
        Registro como usuario
    </h1>
    <p>
        En el momento en que el usuario se registre en cualquiera de las Webs de EPIC ELEVEN, se le solicitarán una serie de datos personales que ayudarán a
        personalizar el servicio ofrecido por EPIC ELEVEN (nombre, apellidos, email, dirección postal, etc.). En dicha línea, EPIC ELEVEN podrá solicitar algunos
        datos adicionales que tienen por finalidad mejorar su experiencia de usuario.
    </p>
  </div>

</div>

"""));
tc.put("packages/webclient/components/legalese_and_help/terminus_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">

  <!-- header title -->
  <div class="default-section-header">TÉRMINOS Y CONDICIONES</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
    <h1>
        1. Generales
    </h1>
    <p>
        1.1 Estos Términos y condiciones regulan el acceso y uso del Portal, siendo aceptados expresa y plenamente por el mero hecho de acceder al Portal y/o por
        la visualización de los contenidos o utilización de los servicios contenidos en el mismo. En caso de que no se acepten estas condiciones generales o, en su
        caso, las condiciones particulares que puedan regular el uso de un determinado servicio y/o contenido, el Usuario deberá abstenerse de acceder al Portal
        así como en su caso a dicho servicio y/o contenido.
    </p>
    <p>
        1.2 Epic Eleven se reserva el derecho de modificar estos Términos y condiciones cuando lo considere oportuno, sin asumir responsabilidad alguna por ello,
        quedando el usuario vinculado por los Términos y condiciones vigentes en cada momento por el mero hecho de acceder o registrarse en el Portal en ese
        momento.
    </p>
    <p>
        1.3 El Portal está orientado a ciudadanos de cualquier nacionalidad y residencia, pero siempre mayores de edad de acuerdo con la legislación que les
        resulte de aplicación, no autorizándose por tanto el alta de menores de edad. Epic Eleven prohíbe expresamente a los menores de edad, según la legislación
        que les resulte de aplicación, que soliciten el alta en el servicio. Además, los usuarios tendrán una sola cuenta en Epic Eleven. Epic Eleven podrá
        cancelar las cuentas de los usuarios que cometan fraude, como duplicidad de cuentas o introducción de datos falsos, con la intención de conseguir más
        puntos. Los usuarios aceptan que hay un proceso de validación de su identidad que puede incluir aspectos como la validación de un número de móvil o la
        entrega de documentación que permita identificar al usuario y comprobar que es mayor de edad.
    </p>
    <p>
        1.4 El Portal está orientado a ciudadanos de cualquier nacionalidad y residencia, siempre y cuando la legislación que les resulte de aplicación les permita
        desarrollar la actividad del Portal, con una finalidad puramente promocional, de manera absolutamente gratuita, que constituye el objeto del Portal,
        conforme a estos Términos y condiciones, por lo que Epic Eleven prohíbe expresamente a aquellas personas a las que la legislación que les resulte de
        aplicación conforme a su nacionalidad o residencia les prohíba participar en el Portal, que se registren en el mismo y participen en él, declinando Epic
        Eleven cualquier responsabilidad en caso de no atender esta prohibición.
    </p>
    <p>
        1.5 Se adquiere la condición de participante (en adelante el “Participante”) mediante el proceso de registro definido en el Portal, pudiendo desde ese
        momento acceder a los servicios ofrecidos en el mismo. El Participante deberá identificarse para garantizar la seguridad del proceso, el cumplimiento de
        estos Términos y condiciones y, sobre todo, la entrega de los obsequios a la persona que los obtenga (cuando corresponda). A la hora de registrarse en el
        Portal, el Participante tendrá que hacerlo únicamente con una dirección válida de email. El acceso como Visitante (en adelante el “Visitante”) al Portal no
        requerirá el registro de datos personales excepto el e-mail (el email para registrarse debe ser una cuenta de correo privada, no se aceptará ninguna cuenta
        pública) para aquellos casos en los que desee el envío periódico de información y así lo solicite expresamente.
    </p>
    <p>
        1.6 Tanto el Participante como el Visitante (en adelante ambos denominados de forma conjunta e indistinta el “Usuario”) son conscientes de que el acceso y
        utilización de los servicios y contenidos del Portal se realiza bajo su única y exclusiva responsabilidad. En este sentido, durante el proceso de registro
        se le solicitará que escoja un nombre de usuario y una contraseña, recomendándole a tal efecto que no comparta la contraseña con terceros, ni permita que
        ninguna persona acceda a su cuenta en su nombre o la manipule de forma que pueda poner en peligro la seguridad de la misma. En el caso de que tenga
        conocimiento o sospeche que se esté violando la seguridad de su cuenta deberá notificarlo inmediatamente a Epic Eleven y modificar su contraseña. Usted
        será el único y exclusivo responsable de guardar confidencialmente su contraseña y del uso que se haga de ella.
    </p>
    <p>
        1.7 El Usuario deberá establecer las medidas de seguridad de carácter técnico adecuadas para evitar acciones no deseadas en su sistema de información,
        archivos y equipos informáticos empleados para acceder a Internet y, en especial, al Portal.
    </p>
    <h1>
        2. Derechos y obligaciones del usuario
    </h1>
    <p>
        El Usuario podrá:
    </p>
    <p>
        2.1 Acceder de forma gratuita y sin necesidad de autorización previa a los contenidos y servicios del Portal disponibles como tales, sin perjuicio de las
        condiciones técnicas, particulares o la necesidad del previo registro respecto de servicios y contenidos específicos, según se determine en estas
        condiciones. El Usuario, no obstante, será responsable de la contratación y del abono de las tarifas que correspondan por la conexión y navegación por
        Internet, tanto desde su ordenador como desde cualquier otro dispositivo móvil que utilice para ello, y que le reclamen las correspondientes compañías
        suministradoras en función de los acuerdos alcanzados con las mismas.
    </p>
    <p>
        2.2 Utilizar los servicios y contenidos disponibles para su uso exclusivamente particular, sin perjuicio de lo dispuesto en las condiciones particulares
        que regulen el uso de un determinado servicio y/o contenido. El usuario se compromete por tanto a no utilizar el Portal con fines comerciales sin haber
        recabado previamente el consentimiento por escrito de Epic Eleven y haber convenido con ella los términos y condiciones de tal uso comercial.
    </p>
    <p>
        2.3 Hacer un uso correcto y lícito del sitio, de conformidad con estos Términos y Condiciones, la legislación vigente, la moral, las buenas costumbres y el
        orden público.
    </p>
    <p>
        2.4 En particular, por lo que se refiere a ACTOS DE ENGAÑO O HACKING, el Usuario se compromete a no realizar ninguna de las siguientes conductas:
    </p>
    <ul>
        <li>
            <p>
                Proyectar o utilizar engaños, ardides o cualquier tipo de software no autorizado por Epic Eleven diseñado o que tenga por finalidad modificar o
                interferir con la operativa del Portal, o con cualquier servicio o contenido del mismo.
            </p>
        </li>
        <li>
            <p>
                Modificar algún archivo o software que forme parte del Portal, sin el previo consentimiento expreso y por escrito de Epic Eleven.
            </p>
        </li>
        <li>
            <p>
                Perjudicar, sobrecargar o contribuir en modo alguno a interferir en el buen funcionamiento de algún ordenador o servidor utilizado para ofrecer o
                dar asistencia al Portal o al disfrute del mismo por parte de alguna otra persona.
            </p>
        </li>
        <li>
            <p>
                Impulsar, contribuir o participar en algún tipo de ataque, incluyendo, a título meramente ilustrativo, la distribución de algún virus, correo no
                deseado, cadenas de mensajes, spam,…, u otros intentos de perjudicar el Portal o el uso o disfrute del mismo por cualquier otra persona.
            </p>
        </li>
        <li>
            <p>
                Intentar obtener acceso no autorizado al Portal, a cuentas registradas de otros Usuarios o a los ordenadores, servidores o redes del Portal, de
                Epic Eleven o de terceros.
            </p>
        </li>
    </ul>
    <p>
        Además, por lo que respecta a CONTENIDOS OFENSIVOS, el Usuario se compromete a no realizar ninguna de las siguientes conductas:
    </p>
    <ul>
        <li>
            <p>
                Publicar información que resulte abusiva, amenazante, obscena, difamatoria u ofensiva desde un punto de vista racial, sexual, religioso o de otro
                tipo.
            </p>
        </li>
        <li>
            <p>
                Publicar información que contenga material sexual, violencia excesiva o temas ofensivos, o un enlace a dicho contenido.
            </p>
        </li>
        <li>
            <p>
                Acosar, abusar, ofender o, en general, tratar sin el debido respeto y educación a alguna persona, o grupos de personas, otro Usuario o cualquiera
                de los empleados o colaboradores de Epic Eleven.
            </p>
        </li>
        <li>
            <p>
                Utilizar el Portal, incluyendo el uso de enlaces, para hacer que esté disponible o accesible algún material o información que infrinja algún
                derecho de autor, marca comercial, patente, secreto comercial o industrial, derecho de privacidad, derecho de publicidad, o derecho de alguna
                persona física o jurídica, o que suplante a alguien, incluyendo, a título meramente ilustrativo, a los propios empleados o colaboradores de Epic
                Eleven.
            </p>
        </li>
        <li>
            <p>
                Utilizar de una forma inapropiada el servicio de atención al cliente de Epic Eleven, lo que incluye el envío de falsos informes de abusos o la
                utilización de un lenguaje inadecuado, obsceno o abusivo en sus comunicaciones.
            </p>
        </li>
    </ul>
    <p>
        Con carácter general, en ningún caso el Usuario podrá:
    </p>
    <ul>
        <li>
            <p>
                Acceder o utilizar los servicios y contenidos del Portal con fines ilícitos, lesivos de derechos y libertades de terceros, o que puedan perjudicar,
                dañar o impedir por cualquier forma, el acceso a los mismos, en perjuicio de Epic Eleven o de terceros.
            </p>
        </li>
        <li>
            <p>
                Utilizar los servicios, total o parcialmente, para promocionar, vender, contratar, divulgar publicidad o información propia o de terceras personas
                sin autorización previa de Epic Eleven.
            </p>
        </li>
        <li>
            <p>
                Incluir hipervínculos en sus páginas web particulares o comerciales a este Portal incumpliendo las condiciones previstas para ello. (iv) Utilizar
                los servicios y contenidos ofrecidos a través del Portal de forma contraria a las condiciones que regulen el uso de un determinado servicio y/o
                contenido, y en perjuicio o con menoscabo de los derechos del resto de Usuario o de la propia Epic Eleven.
            </p>
        </li>
        <li>
            <p>
                Realizar cualquier acción que impida o dificulte el acceso al sitio por los Usuarios, así como de los hipervínculos a los servicios y contenidos
                ofrecidos por Epic Eleven o por terceros a través del Portal. (vi) Utilizar el Portal como vía de acceso a Internet para la comisión de acciones
                ilícitas o contrarias a la legislación vigente, la moral, las buenas costumbres y el orden público.
            </p>
        </li>
        <li>
            <p>
                Emplear cualquier tipo de virus informático, código, software, programa informático, equipo informático o de telecomunicaciones, que puedan
                provocar daños o alteraciones no autorizadas de los contenidos, programas o sistemas accesibles a través de los servicios y contenidos prestados en
                el Portal o en los sistemas de información, archivos y equipos informáticos de los Usuarios del mismo; o el acceso no autorizado a cualesquiera
                contenidos y/o servicios del Portal.
            </p>
        </li>
        <li>
            <p>
                Eliminar o modificar de cualquier modo los dispositivos de protección o identificación de Epic Eleven, o sus legítimos titulares que puedan
                contener los contenidos alojados en el Portal, o los símbolos que Epic Eleven o los terceros legítimos titulares de los derechos incorporen a sus
                creaciones objeto de propiedad intelectual o industrial existentes en este Portal.
            </p>
        </li>
        <li>
            <p>
                Incluir en sitios web de su responsabilidad o propiedad "metatags" correspondientes a marcas, nombres comerciales o signos distintivos propiedad de
                Epic Eleven o de terceros.
            </p>
        </li>
        <li>
            <p>
                Reproducir total o parcialmente el Portal en otro sitio o página web y sin cumplir las condiciones previstas para ello.
            </p>
        </li>
        <li>
            <p>
                Realizar enmarcados al Portal o a las páginas web accesibles a través del mismo que oculten o modifiquen -con carácter delimitativo pero no
                limitativo- contenidos, espacios publicitarios y marcas de Epic Eleven o de terceros, con independencia o no de que supongan actos de competencia
                desleal o de confusión.
            </p>
        </li>
        <li>
            <p>
                Crear marcos dentro de un sitio web de su responsabilidad o propiedad que reproduzcan la página principal y/o las páginas accesibles a través de la
                misma, correspondientes al Portal sin la previa autorización de Epic Eleven.
            </p>
        </li>
        <li>
            <p>
                Solicitar o tratar de obtener información personal de otros Usuarios del Portal, así como obtener, recopilar, publicar o tratar por cualquier
                medio, datos de carácter personal de otros Usuarios del mismo, salvo con la previa autorización por escrito de Epic Eleven.
            </p>
        </li>
    </ul>

    <h1>
        3. Derechos de Epic Eleven
    </h1>
    <p>
        Epic Eleven se reserva los siguientes derechos:
    </p>
    <p>
        3.1 Modificar los presentes Términos y condiciones, así como las condiciones de acceso al Portal, técnicas o no, de forma unilateral y sin preaviso a los
        Usuarios, sin perjuicio de lo dispuesto en las condiciones particulares que regulen el uso de un determinado servicio y/o contenido del Portal.
    </p>
    <p>
        3.2 Establecer condiciones particulares y, en su caso, la exigencia de un precio u otros requisitos para el acceso a determinados servicios y/o contenidos.
    </p>
    <p>
        3.3 Limitar, excluir, suspender, cancelar, modificar o condicionar, sin aviso previo, el acceso de los Usuarios cuando no se den todas las garantías de
        utilización correcta del Portal por los mismos conforme a las obligaciones y prohibiciones asumidas por los mismos. En esos casos Epic Eleven podrá
        cancelar el nombre de usuario y contraseña y todos los puntos, beneficios, regalos o ganancias asociados a una determinada cuenta, sin que por ella deba
        compensar en modo alguno al Participante.
    </p>
    <p>
        3.4 Finalizar, suspender, modificar o condicionar, sin aviso previo, la prestación de un servicio o suministro de un contenido, sin derecho a
        indemnización, cuando el mismo resulte ilícito o contrario a las condiciones establecidas para los mismos, sin perjuicio de lo dispuesto en las condiciones
        particulares que regulen el uso de un determinado servicio y/o contenido del Portal. En esos casos Epic Eleven podrá cancelar el nombre de usuario y
        contraseña y todos los puntos, beneficios, regalos o ganancias asociados a una determinada cuenta, sin que por ella deba compensar en modo alguno al
        Participante.
    </p>
    <p>
        3.5 Modificar unilateralmente y sin previo aviso, siempre que lo considere oportuno, la estructura y diseño del Portal, así como actualizar, modificar o
        suprimir todo o parte de los contenidos o servicios y condiciones de acceso y/o uso del Portal, pudiendo incluso limitar o no permitir el acceso a dicha
        información.
    </p>
    <p>
        3.6 Denegar en cualquier momento y sin necesidad de aviso previo el acceso al Portal a aquellos Participantes que incumplan estas condiciones de uso,
        pudiendo cancelar el nombre de usuario y contraseña de los mismos, así como todos los puntos, beneficios, regalos o ganancias asociados a su cuenta, sin
        que por ella deba compensar en modo alguno al Participante en cuestión.
    </p>
    <p>
        3.7 Emprender cualquier acción legal o judicial que resulte conveniente para la protección de los derechos de Epic Eleven así como de terceros que presten
        sus servicios o contenidos a través del Portal, siempre que resulte procedente.
    </p>
    <p>
        3.8 Exigir la indemnización que pudiera derivar por el uso indebido o ilícito de todo o parte de los servicios y contenidos prestados a través del Portal.
    </p>
    <h1>
        4. Operativa del portal
    </h1>
    <p>
        4.1 Podrán ser Participantes todas aquellas personas físicas, mayores de edad, según la legislación de su nacionalidad, con independencia de la misma, que
        se registren como Participantes y faciliten a tal efecto de forma veraz los datos necesarios para ello.
    </p>
    <p>
        4.2 Por el mero hecho de cumplimentar el formulario de registro el Participante acepta de forma irrevocable los presentes Términos y condiciones.
    </p>
    <p>
        4.3 Adicionalmente este saldo puede verse incrementado por promociones que Epic Eleven ponga en práctica en cada momento. Por ejemplo, si un Usuario se
        registra como Participante por la intervención o recomendación de otro Participante, por el uso que el Participante invitado haga del Portal, por la
        adición de un importe fijo y mínimo de Puntos que con carácter periódico Epic Eleven pueda añadir al Participante, por la participación en determinadas
        promociones comerciales de colaboradores de Epic Eleven, por registrarse en otras webs de colaboradores o participar en las mismas,… Estos medios
        adicionales para incrementar el saldo de Puntos del Participante se regirán por las condiciones que Epic Eleven publicite en el Portal en cada momento.
    </p>
    <p>
        4.4 El saldo de puntos disminuirá de forma natural por el consumo de Puntos que el Participante lleve a cabo como consecuencia de los torneos en los que
        participe.
    </p>
    <p>
        4.5 Los Puntos de una cuenta se podrán cancelar y la propia cuenta darse de baja por parte de Epic Eleven, sin que por ello asuma responsabilidad frente al
        Participante ni deba compensarle en modo alguno, si no se producen movimientos en la misma durante un periodo consecutivo de doce meses.
    </p>
    <p>
        4.6 Los Puntos son personales e intransferibles del Participante y de su cuenta, no pudiendo cederse, traspasarse, transmitirse, gravarse en modo alguno,
        tanto de forma gratuita como onerosa, total o parcialmente, por medio directos o indirectos. Los Puntos no pueden traspasarse entre cuentas, aunque el
        Participante acredite ser titular de ambas.
    </p>
    <p>
        4.7 Un Participante únicamente puede ser titular de una cuenta, por lo que Epic Eleven se reserva el derecho de impedir su participación en el Portal en
        caso de que se infrinja esta prohibición.
    </p>
    <p>
        4.8 Se insta y aconseja a los Participantes del Portal actuar conforme a la legislación aplicable en la jurisdicción donde estén domiciliados y/o sean
        residentes. Epic Eleven desconoce la legislación aplicable a los Participantes, por lo que no asume responsabilidad alguna derivada de su aplicación, lo
        que incluye la eventual tributación del Participante. Se aconseja a los Participantes que deseen obtener información con respecto a los impuestos y/o
        asuntos legales, que entren en contacto o recurran a los servicios de asesores apropiados y/o de las autoridades competentes en la jurisdicción en la cual
        estén domiciliados y/o sean residentes.
    </p>
    <p>
        4.9 Extinción. Epic Eleven se reserva el derecho de dar por terminada su condición de Participante del Portal y los derechos que le pudieran corresponder
        en tal condición, en cualquier comento, como consecuencia del incumplimiento de sus obligaciones conforme a los presentes Términos y condiciones, fuerza
        mayor, cese o suspensión de los servicios ofrecidos por el Portal o disolución, extinción o cese en la actividad de Epic Eleven. En caso de cese en su
        condición de Participante del Portal Epic Eleven no tendrá responsabilidad u obligación alguna frente a usted, cancelando su cuenta y anulando los puntos
        acumulados en la misma, no obstante lo cual Epic Eleven sí podrá ejercitar las acciones que en Derecho le correspondan en la forma que considere oportuna
        para exigir las responsabilidades que deriven de cualquier incumplimiento de los presentes Términos y condiciones o de la legislación aplicable.
    </p>
    <h1>
        5. Exención y limitación de responsabilidad de Epic Eleven
    </h1>
    <p>
        Epic Eleven queda exenta de cualquier tipo de responsabilidad por daños y perjuicios de toda naturaleza en los siguientes casos:
    </p>
    <p>
        5.1 Por la imposibilidad o dificultades de conexión a la red de comunicaciones a través de la que resulta accesible este Portal, independientemente de la
        clase de conexión utilizada por el Usuario.
    </p>
    <p>
        5.2 Por la interrupción, suspensión o cancelación del acceso al Portal, así como por la disponibilidad y continuidad del funcionamiento del Portal o de
        los servicios y/o contenidos en el mismo, cuando ello se deba a una causa ajena al ámbito de control de Epic Eleven.
    </p>
    <p>
        5.3 Epic Eleven no asume ninguna responsabilidad respecto de los servicios y contenidos, ni por la disponibilidad y condiciones, técnicas o no, de acceso
        a los mismos, que sean ofrecidos por terceros prestadores de servicios, en especial respecto de los prestadores de servicios de la sociedad de la
        información.
    </p>
    <p>
        5.4 Epic Eleven, en ningún momento, asume responsabilidad por los daños o perjuicios que pudieran causar la información, contenidos, productos y servicios
        prestados, comunicados, alojados, transmitidos, exhibidos u ofertados por terceros ajenos a Epic Eleven, incluidos los prestadores de servicios la sociedad
        de la información, a través de un portal al que pueda accederse mediante un enlace existente en este Portal.
    </p>
    <p>
        5.5 Del tratamiento y utilización posterior de datos personales realizados por terceros ajenos a Epic Eleven, así como la pertinencia de la información
        solicitada por éstos.
    </p>
    <p>
        5.6 De la calidad y velocidad de acceso al Portal y de las condiciones técnicas que debe reunir el Usuario con el fin de poder acceder al Portal y a sus
        servicios y/o contenidos.
    </p>
    <p>
        5.7 Epic Eleven no será responsable de los retrasos o fallos que se produjeran en el acceso y/o funcionamiento de los servicios y/o contenidos del Portal,
        debido a un caso de Fuerza Mayor.
    </p>
    <p>
        5.8 El Usuario responderá personalmente de los daños y perjuicios de cualquier naturaleza causados a Epic Eleven, directa o indirectamente, por el
        incumplimiento de cualquiera de las obligaciones derivadas de estas condiciones generales u otras normas por las que se rija la utilización del Portal.
    </p>
    <h1>
        6. Propiedad intelectual e industrial
    </h1>
    <p>
        6.1 El Usuario conoce que los contenidos y servicios ofrecidos a través del Portal, - incluyendo textos, gráficos, imágenes, animaciones, creaciones
        musicales, vídeos, sonidos, dibujos, fotografías, todos los comentarios, exposiciones, aplicaciones informáticas, bases de datos y código html del mismo,
        sin que esta enumeración tenga carácter limitativo -, se encuentran protegidos por las leyes de propiedad intelectual. El derecho de autor y de explotación
        económica de este Portal corresponde a Epic Eleven. En cuanto a los contenidos incluidos en el Portal los derechos de autor y de explotación económica son
        propiedad de Epic Eleven o en su caso, de terceras entidades, y en ambos casos se encuentran protegidos por las leyes vigentes de propiedad intelectual.
    </p>
    <p>
        6.2 Las marcas, nombres comerciales o signos distintivos que aparecen en el Portal son propiedad de Epic Eleven, y se encuentran protegidos por las leyes
        vigentes de propiedad industrial.
    </p>
    <p>
        6.3 La prestación de los servicios y publicación de los contenidos a través del Portal no implicará en ningún caso la cesión, renuncia o transmisión, total
        o parcial, de la titularidad de los correspondientes derechos de propiedad intelectual e industrial.
    </p>
    <p>
        6.4 Ninguna parte de este Portal puede ser reproducido, distribuido, transmitido, copiado, comunicado públicamente, transformado, en todo o en parte
        mediante ningún sistema o método manual, electrónico o mecánico (incluyendo el fotocopiado, grabación o cualquier sistema de recuperación y almacenamiento
        de información) a través de cualquier soporte actualmente conocido o que se invente en el futuro, sin consentimiento de Epic Eleven. La utilización, bajo
        cualquier modalidad, de todo o parte del contenido del Portal queda sujeta a la necesidad de solicitar autorización previa de Epic Eleven, y la aceptación
        de la correspondiente licencia, en su caso, excepto para lo dispuesto respecto de los derechos reconocidos y concedidos al Usuario en estas condiciones
        generales o lo que así se determine en las condiciones particulares que Epic Eleven tenga a bien establecer para regular el uso de un determinado servicio
        y/o contenido ofrecido a través del Portal.
    </p>
    <p>
        6.5 Bajo ningún concepto, el Usuario podrá realizar un uso o utilización de los servicios y contenidos existentes en la página que no sea exclusivamente
        personal, a salvo de las excepciones determinadas en las presentes condiciones de uso de este Portal o en las condiciones particulares que Epic Eleven
        tenga a bien establecer para regular el uso de un determinado servicio y/o contenido ofrecido a través del Portal.
    </p>
    <p>
        6.6 Si la actuación u omisión culpable o negligente directa o indirectamente imputable al Usuario del Portal que origine la infracción de los derechos de
        propiedad intelectual e industrial de Epic Eleven o de terceros, exista o no beneficio para el mismo, originase a Epic Eleven daños, pérdidas, obligaciones
        solidarias, gastos de cualquier naturaleza, sanciones, medidas coercitivas, multas y otras cantidades surgidas o derivadas de cualquier reclamación,
        demanda, acción, pleito o procedimiento, sea civil, penal o administrativo, Epic Eleven tendrá derecho a dirigirse contra el Usuario por todos los medios
        legales a su alcance y reclamar cualesquiera cantidades indemnizatorias, incluyendo, a título enunciativo y no limitativo, daños morales e imagen, daño
        emergente y lucro cesante, costes publicitarios o de cualquier otra índole que pudieran resultar para su reparación, importes de sanciones o sentencias
        condenatorias, el de los intereses de demora, las costas judiciales y el importe de la defensa en cualquier proceso en el que pudiera resultar demandada
        por las causas anteriormente expuestas, por los daños y perjuicios ocasionados por razón de su actuación u omisión, sin perjuicio de ejercer cualesquiera
        otras acciones que en Derecho le corresponda.
    </p>
    <h1>
        7. Enlaces e Hiperenlaces
    </h1>
    <p>
        7.1 Las personas o entidades que pretendan realizar o realicen un hiperenlace desde una página web de otro portal de Internet a cualquiera de las páginas
        del Portal de Epic Eleven deberán someterse a las siguientes condiciones: (i) No se permite la reproducción ni total ni parcial de ninguno de los servicios
        ni contenidos del Portal. (ii) No se establecerán deep-links, ni frames con las páginas del Portal sin la previa autorización expresa de Epic Eleven. (iii)
        No se incluirá ninguna manifestación falsa, inexacta o incorrecta sobre las páginas del Portal ni sobre los servicios o contenidos del mismo. (iv) Salvo
        aquellos signos que formen parte del "hiperenlace", la página web en la que se establezca no contendrá ninguna marca, nombre comercial, rótulo de
        establecimiento, denominación, logotipo, eslogan u otros signos distintivos pertenecientes a Epic Eleven, salvo autorización expresa de ésta. (v) El
        establecimiento del "hiperenlace" no implicará la existencia de ningún tipo de relación entre Epic Eleven y el titular de la página web o del portal desde
        el cual se realice. (vi) Epic Eleven no será responsable de los contenidos o servicios puestos a disposición del público en la página web o portal desde el
        cual se realice el "hiperenlace" ni de las informaciones y manifestaciones incluidas en las mismas. (vii) Cualquier "hiperenlace" al Portal de Epic Eleven
        se efectuará a su página principal o páginas principales de las secciones que contiene.
    </p>
    <p>
        7.2 Epic Eleven rechaza cualquier responsabilidad sobre la información contenida en páginas web de terceros conectadas por enlaces con el Portal de Epic
        Eleven o que no sean gestionadas directamente por nuestro administrador del Portal. La función de los enlaces que aparecen en este Portal tiene sólo
        finalidad informativa y en ningún caso suponen una sugerencia, invitación o recomendación para la visita de los lugares de destino. Cuando para utilizar
        algunos de los servicios del Portal, los Participantes deban proporcionar previamente a Epic Eleven ciertos datos de carácter personal, Epic Eleven tratará
        tales datos con las finalidades, así como bajo las condiciones definidas, en su Política de Privacidad .
    </p>
    <h1>
        8. Finales
    </h1>
    <p>
        8.1 Controversias. Para la resolución de cualquier controversia que resulte de la interpretación y/o cumplimiento de los Términos y condiciones, los
        Usuarios, tanto Participantes como Visitantes, con expresa renuncia a cualquier otro fuero que pudiera corresponderles, se someten a los Juzgados y
        Tribunales de la Ciudad de Madrid.
    </p>
    <p>
        8.2 Derecho aplicable. Los presentes Términos y condiciones se regirán por la legislación española común y se interpretarán con arreglo a la misma.
    </p>
    <p>
        8.3 Cláusulas inválidas. Si alguna cláusula de los presentes Términos y condiciones se considerara o pudiera ser ilegal, inválida o inaplicable, estos
        Términos y condiciones se considerarán divisibles e inoperativos en relación con dicha cláusula y hasta donde ésta se considere ilegal, inválida o
        inaplicable; y, por lo que hace referencia a cualesquiera otro aspecto de estos Términos y condiciones, permanecerá en vigor y tendrá plenos efectos; sin
        embargo, siempre que alguna cláusula de estos Términos y condiciones se considerara o pudiera ser ilegal, inválida o inaplicable se incluirá
        automáticamente una cláusula lo más similar posible a la cláusula ilegal, inválida o inaplicable para que sea legal, válida y aplicable.
    </p>
    <p>
        8.4 Encabezamientos. Los encabezamientos de las cláusulas de los presentes Términos y condiciones se realizan únicamente a efectos de referencias y, en
        ningún caso, afectan o limitan el sentido y contenido de los mismos.
    </p>
    <p>
        8.5 Reclamaciones. Para efectuar cualquier reclamación sobre los servicios prestados a través del portal el participante puede remitir un correo
        electrónico a epiceleven@epiceleven.com indicando sus datos, exponiendo los hechos que motivan la queja o reclamación y concretando su pretensión. Si lo
        prefieren, disponemos igualmente de Hojas de Reclamaciones a disposición de quienes las soliciten en el domicilio que consta en el Aviso Legal.
    </p>
    <h1>
        Datos de identificación
    </h1>
    <p>
        Usted está visitando la página web www.epiceleven.com, titularidad de FANTASY SPORTS GAMES, S.L (en adelante EPIC ELEVEN). La misma está domiciliada en la
        Avenida de Brasil, 23, Oficinal 5-A, 28020, Madrid, siendo su e-mail de contacto: info@epiceleven.com identificada con C.I.F. B-87028445.
    </p>
    <h1>
        Aceptación del Usuario
    </h1>
    <p>
        Este Aviso Legal regula el acceso y utilización de la página web www.epiceleven.com (en adelante la “Web”) que EPIC ELEVEN pone a disposición de los
        usuarios de Internet. El acceso a la misma implica la aceptación sin reservas del presente Aviso Legal. Asimismo, EPIC ELEVEN puede ofrecer a través de la
        Web, servicios que podrán encontrarse sometidos a unas condiciones particulares propias sobre las cuales se informará al Usuario en cada caso concreto.
    </p>
    <h1>
        Acceso a la Web y Contraseñas
    </h1>
    <p>
        Al acceder a la página web de EPIC ELEVEN el usuario declara tener capacidad suficiente para navegar por la mencionada página web, esto es ser mayor de
        dieciocho años y no estar incapacitado. A su vez, de manera general no se exige la previa suscripción o registro como Usuario para el acceso y uso de la
        Web, sin perjuicio de que para la utilización de determinados servicios o contenidos de la misma se deba realizar dicha suscripción o registro. Los datos
        de los Usuarios obtenidos a través de la suscripción o registro a la presente Web, están protegidos mediante contraseñas elegidas por ellos mismos. El
        Usuario se compromete a mantener su contraseña en secreto y a protegerla de usos no autorizados por terceros. El Usuario deberá notificar a EPIC ELEVEN
        inmediatamente cualquier uso no consentido de su cuenta o cualquier violación de la seguridad relacionada con el servicio de la Web, de la que haya tenido
        conocimiento. EPIC ELEVEN adopta las medidas técnicas y organizativas necesarias para garantizar la protección de los datos de carácter personal y evitar
        su alteración, pérdida, tratamiento y/o acceso no autorizado, habida cuenta del estado de la técnica, la naturaleza de los datos almacenados y los riesgos
        a que están expuestos, todo ello, conforme a lo establecido por la legislación española de Protección de Datos de Carácter Personal. EPIC ELEVEN no se hace
        responsable frente a los Usuarios, por la revelación de sus datos personales a terceros que no sea debida a causas directamente imputables a EPIC ELEVEN,
        ni por el uso que de tales datos hagan terceros ajenos a EPIC ELEVEN.
    </p>
    <h1>
        Uso correcto de la Web
    </h1>
    <p>
        El Usuario se compromete a utilizar la Web, los contenidos y servicios de conformidad con la Ley, el presente Aviso Legal, las buenas costumbres y el orden
        público. Del mismo modo el Usuario se obliga a no utilizar la Web o los servicios que se presten a través de ésta con fines o efectos ilícitos o contrarios
        al contenido del presente Aviso Legal, lesivos de los intereses o derechos de terceros, o que de cualquier forma pueda dañar, inutilizar o deteriorar la
        Web o sus servicios o impedir un normal disfrute de la Web por otros Usuarios. Sin perjuicio de lo anterior, EPIC ELEVEN puede ofrecer a través de la web
        servicios adicionales que cuenten con su propia regulación adicional. En estos casos, se informará adecuadamente a los Usuarios en cada caso concreto.
        Asimismo, el Usuario se compromete expresamente a no destruir, alterar, inutilizar o, de cualquier otra forma, dañar los datos, programas o documentos
        electrónicos que se encuentren en la Web. El Usuario se compromete a no obstaculizar el acceso de otros Usuarios al servicio de acceso mediante el consumo
        masivo de los recursos informáticos a través de los cuales EPIC ELEVEN presta el servicio, así como realizar acciones que dañen, interrumpan o generen
        errores en dichos sistemas. El Usuario se compromete a no introducir programas, virus, macros, applets, controles ActiveX o cualquier otro dispositivo
        lógico o secuencia de caracteres que causen o sean susceptibles de causar cualquier tipo de alteración en los sistemas informáticos de EPIC ELEVEN o de
        terceros.
    </p>
    <h1>
        Enlaces de terceros
    </h1>
    <p>
        El presente Aviso Legal se refiere únicamente a la Web y contenidos de EPIC ELEVEN, y no se aplica a los enlaces o a las páginas web de terceros accesibles
        a través de la Web. Los destinos de dichos enlaces no están bajo el control de EPIC ELEVEN, y el mismo no es responsable del contenido de ninguna de las
        páginas Web de destino de un enlace, ni de ningún enlace incluido en una página Web a la que se llegue desde la Web de EPIC ELEVEN, ni de ningún cambio o
        actualización de dichas páginas. Estos enlaces se proporcionan únicamente para informar al Usuario sobre la existencia de otras fuentes de información
        sobre un tema concreto, y la inclusión de un enlace no implica la aprobación de la página Web enlazada por parte de EPIC ELEVEN.
    </p>
    <h1>
        Propiedad intelectual
    </h1>
    <p>
        EPIC ELEVEN advierte que los derechos de propiedad intelectual de la Web, su código fuente, diseño, estructura de navegación, bases de datos y los
        distintos elementos en ésta contenidos son titularidad exclusiva de EPIC ELEVEN, a quien corresponde el ejercicio exclusivo de los derechos de explotación
        de los mismos en cualquier forma y, en especial, con carácter enunciativo que no limitado, los derechos de reproducción, copia, distribución,
        transformación, comercialización, y comunicación pública. La reproducción, copia, distribución, transformación, comercialización, y comunicación pública
        parcial o total de la información contenida en esta Web, queda estrictamente prohibida sin la previa autorización expresa y por escrito de EPIC ELEVEN, y
        constituye una infracción de los derechos de propiedad intelectual e industrial.
    </p>
    <h1>
        Foros, Blogs e imágenes
    </h1>
    <p>
        EPIC ELEVEN ofrece a los Usuarios la posibilidad de introducir comentarios y/o de remitir fotografías, para incorporarlos en las secciones
        correspondientes. La publicación de los comentarios y/o las fotografías está sujeta al presente Aviso Legal. La persona identificada en cada caso como la
        que ha realizado los comentarios y/o ha enviado las fotografías, es responsable de los mismos. Los comentarios y/o las fotografías, no reflejan la opinión
        de EPIC ELEVEN, ni el mismo hace declaraciones a este respecto. EPIC ELEVEN no se hará responsable, a no ser en aquellos extremos a los que le obligue la
        Ley, de los errores, inexactitudes o irregularidades que puedan contener los comentarios y/o las fotografías, así como de los daños o perjuicios que se
        pudieran ocasionar por la inserción de los comentarios y/o las fotografías en el Foro o en las demás secciones de la Web que permitan esta clase de
        servicios.El Usuario suministrador del texto y/o fotografías cede a EPIC ELEVEN los derechos para su reproducción, uso, distribución, comunicación pública
        en formato electrónico, en el marco de las actividades para esta web. Y, en especial, el Usuario cede dichos derechos para el emplazamiento del texto y/o
        las fotografías en la Web, con el fin de que los demás Usuarios del sitio Web puedan acceder a los mismos. El Usuario suministrador declara ser el titular
        de los derechos sobre los textos o fotografías o, en su caso, garantiza que dispone de los derechos y autorizaciones necesarios del autor o propietario del
        texto y/o fotografías, para su utilización por parte de EPIC ELEVEN a través de la Web. EPIC ELEVEN no se hará responsable, a no ser en aquellos extremos a
        los que obligue la Ley, de los daños o perjuicios que se pudieran ocasionar por el uso, reproducción, distribución o comunicación pública o cualquier tipo
        de actividad que realice sobre los textos y/o fotografías que se encuentren protegidos por derechos de propiedad intelectual pertenecientes a terceros, sin
        que el Usuario haya obtenido previamente de sus titulares la autorización necesaria para llevar a cabo el uso que efectúa o pretende efectuar. Asimismo,
        EPIC ELEVEN se reserva el derecho de retirar de forma unilateral los comentarios y/o fotografías albergados en cualquier otra sección de la Web, cuando
        EPIC ELEVEN lo estime oportuno. EPIC ELEVEN no será responsable por la información enviada por el Usuario cuando no tenga conocimiento efectivo de que la
        información almacenada es ilícita o de que lesiona bienes o derechos de un tercero susceptibles de indemnización. En el momento que EPIC ELEVEN tenga
        conocimiento efectivo de que aloja datos como los anteriormente referidos, se compromete a actuar con diligencia para retirarlos o hacer imposible el
        acceso a ellos. En todo caso, para interponer cualquier reclamación relacionada con los contenidos insertados en el Foro o secciones análogas, puede
        hacerlo dirigiéndose a la siguiente dirección de correo electrónico: info@epiceleven.com.
    </p>
    <h1>
        Modificaciones de las condiciones de uso
    </h1>
    <p>
        EPIC ELEVEN se reserva el derecho de modificar, desarrollar o actualizar en cualquier momento y sin previa notificación las condiciones de uso de la
        mencionada página web. El usuario quedará obligado automáticamente por las condiciones de uso que se hallen vigentes en el momento en que acceda a la web,
        por lo que deberá leer periódicamente dichas condiciones de uso.
    </p>
    <h1>
        Régimen de responsabilidad
    </h1>
    <p>
        La utilización de la página web es responsabilidad única y exclusiva de cada Usuario, por lo que será responsabilidad suya cualquier infracción o cualquier
        perjuicio que pueda causar por el uso de dicha página. EPIC ELEVEN, sus socios, colaboradores, empleados y cualquier otro representante o tercero quedan
        pues exonerados de cualquier responsabilidad que pudiera conllevar las acciones del Usuario. EPIC ELEVEN, aún cuando ponga todo su esfuerzo en facilitar
        siempre información actualizada mediante su página web, no garantiza la inexistencia de errores o inexactitudes en ninguno de los contenidos, siempre que
        sea por razones no imputables de forma directa a EPIC ELEVEN. Por lo anterior, será el Usuario el único responsable frente a todas aquellas reclamaciones o
        acciones legales iniciadas contra EPIC ELEVEN basadas en el uso de la página web o sus contenidos por parte del usuario, siempre que esta utilización se
        haya realizado de forma ilícita, vulnerando derechos de terceros, o causando cualquier tipo de perjuicio, asumiendo por ello cuantos gastos, costes o
        indemnizaciones en los que pueda incurrir EPIC ELEVEN..
    </p>
    <h1>
        Ley aplicable y Jurisdicción
    </h1>
    <p>
        Esta Web se rige por la legislación española. EPIC ELEVEN y el Usuario, con renuncia expresa a su propio fuero, si lo tuvieren, se someten a la
        jurisdicción de los juzgados y tribunales de la ciudad de Madrid (España). Esto siempre que este no sea un usuario final, siendo el foro que la ley
        estipula el domicilio del demandado.
    </p>
  </div>
</div>"""));
tc.put("packages/webclient/components/lobby_comp.html", new HttpResponse(200, r"""<div id="lobbyRoot">

  <!-- Header de Promociones -->
  <promos id="promosComponent"></promos>

  <!-- Barra azul de información -->
  <div id="lobbyTopInfobar">
    <p>{{infoBarText}}</p>
  </div>

  <!-- Filtros y Ordenación -->
  <contest-filters-comp id="contestFiltersRoot"
                        contests-list="contestsService.activeContests" contest-count="contestCount"
                        on-sort-order-change="onSortOrderChange(sortParams)" on-filter-change="onFilterChange(filterList)"></contest-filters-comp>

  <!-- Lista de concursos -->
  <contests-list  id="activeContestList"
                  sorting="lobbySorting"
                  contests-list="contestsService.activeContests"
                  competition-type-filter="lobbyFilters['FILTER_COMPETITION']"
                  tournament-type-filter="lobbyFilters['FILTER_TOURNAMENT']"
                  salary-cap-filter="lobbyFilters['FILTER_TIER']"
                  entry-fee-filter="lobbyFilters['FILTER_ENTRY_FEE']"
                  name-filter="lobbyFilters['FILTER_CONTEST_NAME']"
                  on-action-click='onActionClick(contest)'
                  on-row-click="onRowClick(contest)" action-button-title="'PLAY'"
                  contest-count="contestCount">
  </contests-list>
</div>
<!-- Punto de insercion de nuestra ruta hija contest-info -->
<ng-view></ng-view>"""));
tc.put("packages/webclient/components/modal_comp.html", new HttpResponse(200, r"""<div id="modalRoot" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <content></content>
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/my_contests_comp.html", new HttpResponse(200, r"""<div id="myContest" >
  <!-- header title -->
  <div class="default-section-header">MY CONTESTS</div>
  <!-- Nav tabs -->
  <ul  id="myContestMenuTabs" class="my-contest-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('live-contest-content')"> Live <span class="contest-count" ng-if="hasLiveContests">{{contestsService.liveContests.length}}</span></a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('waiting-contest-content')">Upcoming</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('history-contest-content')">Entry History</a></li>
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
              <div class="default-info-text">YOUR ARE NOT PLAYING ANY CONTEST<br>AT THE MOMENT</div>
              <div class="no-contests-text">CHECK OUT THE LIST OF YOUR <strong data-toggle="tab" ng-click="tabChange('waiting-contest-content')">NEXT CONTESTS</strong> TO SEE WHEN THEY START</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">TO THE CONTESTS</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list id="liveContests" contests-list="contestsService.liveContests"
                           sorting="liveSortType" on-action-click='onLiveActionClick(contest)' on-row-click='onLiveActionClick(contest)'>
            </contests-list>
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
              <div class="default-info-text">YOU DON'T HAVE ANY TEAM FOR ANY CONTEST<br>RIGHT NOW</div>
              <div class="no-contests-text">GO TO THE CONTEST LIST, PICK ONE AND START PLAYING</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">TO THE CONTESTS</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list id="waitingContests" contests-list='contestsService.waitingContests'
                           sorting="waitingSortType" on-action-click='onWaitingActionClick(contest)' on-row-click='onWaitingActionClick(contest)'>
            </contests-list>
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
              <div class="default-info-text">YOU HAVEN'T PLAYED ANY CONTEST YET<br>WHAT ARE YOU WAITING FOR TO START WINNING?</div>
              <div class="no-contests-text">GO TO THE CONTEST LIST, PICK ONE AND START PLAYING</div>
            </div>
            <div class="no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">TO THE CONTESTS</button>
            </div>
          </div>
          <!-- lista de concursos -->
          <div class="list-container" ng-switch-when="true">
            <contests-list id="historyContests" contests-list="contestsService.historyContests"
                           sorting="historySortType" on-action-click='onHistoryActionClick(contest)' on-row-click='onHistoryActionClick(contest)'>
            </contests-list>
          </div>
        </section>
      </div>

    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/promos_comp.html", new HttpResponse(200, r"""<img ng-if="!scrDet.isXsScreen" src="images/bannerPromoDesktop.jpg" class="promoDesktop" />
<!--<div class="beta-version-desktop" ng-if="!scrDet.isXsScreen">
  <span class="beta-version-text">VERSIÓN BETA</span>
</div>-->
<img ng-if="scrDet.isXsScreen" src="images/betaHeaderXsBg.jpg" class="promoXs" />
<!--<div class="beta-version-xs" ng-if="scrDet.isXsScreen">
  <span class="beta-version-text">BETA</span>
  <img src="images/betaHeaderXsTexto.png" class="betaVersionXs" />
</div>-->"""));
tc.put("packages/webclient/components/scoring_rules_comp.html", new HttpResponse(200, r"""<div id="scoringForAll" class="panel-points">
  <div class="rules-header">ALL PLAYERS</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in AllPlayers">
      <span class="name">{{event["name"]}}</span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForGoalKeepers" class="panel-points">
  <div class="rules-header">GOALKEEPERS</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in GoalKeepers">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForDefenders" class="panel-points">
  <div class="rules-header">DEFENDERS</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Defenders ">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForMidFielders" class="panel-points">
  <div class="rules-header">MIDFIELDERS</div>
  <div class="rules-content">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in MidFielders">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForForwards" class="panel-points">
  <div class="rules-header">FORWARDS</div>
  <div class=rules-content>
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Forwards">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/view_contest/fantasy_team_comp.html", new HttpResponse(200, r"""<div id="fantasyTeamRoot" class="fantasy-team-wrapper" >

  <div class="fantasy-team-header" ng-class="{'opponent-team-gradient': isOpponent, 'header-view-contest-entry-mode': isViewContestEntryMode}">

    <div class="edit-team" ng-if="isViewContestEntryMode">
      <button class="btn-edit-team" ng-click="editTeam()">EDIT THE LINEUP</button>
    </div>

    <div class="ranking-box" ng-if="!isViewContestEntryMode">
      <span class="title">POS</span>
      <span class="content">{{userPosition}}</span>
    </div>

    <div class="score-box" ng-if="!isViewContestEntryMode">
      <span class="title">POINTS</span>
      <span class="content">{{userScore}}</span>
    </div>

    <div class="user-picture"></div>
    <div class="user-nickname" ng-class="{'nickname-view-contest-entry-mode': isViewContestEntryMode}">{{userNickname}}</div>
    <div class="total-remaining-matches-time" ng-if="!isViewContestEntryMode">REMAINING TIME: {{remainingTime}}</div>

    <div class="close-team" ng-click="onCloseButtonClick()" ng-show="showCloseButton">
      <span class="title">CLOSE</span>
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
          <span class="remaining-match-time" ng-if="!isViewContestEntryMode">{{slot.percentOfUsersThatOwn}}% OWNED</span>
        </div>
        <div class="column-score" ng-if="!isViewContestEntryMode"><span>{{slot.score}}</span></div>
        <div class="column-salary" ng-if="isViewContestEntryMode">{{slot.salary}}€</div>
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
tc.put("packages/webclient/components/view_contest/teams_panel_comp.html", new HttpResponse(200, r"""<div id="teamsPanelRoot" ng-show="contest != null" ng-switch="scrDet.isXsScreen" class="animate">

  <div class="teams-comp-bar" ng-switch-when="true">
    <div class="teams-toggler-wrapper">
      <div id="teamsToggler" type="button" class="teams-toggler toggleOff" ng-click="toggleTeamsPanel()"  data-toggle="collapse" data-target="#teamsPanel">MATCHES IN THIS CONTEST</div>
    </div>
    <div id="teamsPanel" class="teams-container collapse">
      <div class="top-border"></div>
      <div class="teams-box" ng-repeat="match in matchesInvolved">
        <div class="teams-info" ng-bind-html="getMatchAndPeriodInfo($index, match)"></div>
      </div>
      <div class="bottom-border"></div>
    </div>
  </div>

  <div class="teams-comp-bar" ng-switch-when="false">
    <div class="teams-container">
      <div class="teams-box" ng-repeat="match in matchesInvolved">
        <div class="teams-info" ng-bind-html="getMatchAndPeriodInfo($index, match)"></div>
      </div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/users_list_comp.html", new HttpResponse(200, r"""<div id="usersListRoot" >

  <div ng-class="{'users-header-next': isViewContestEntryMode, 'users-header' : !isViewContestEntryMode}">
    <h1>CONTENDERS IN THIS CONTEST</h1>
    <h2 ng-if="!isViewContestEntryMode">Choose a contender to compare lineups:</h2>
  </div>

  <div class="users-table-header">
    <div class="pos">POS</div>
    <div class="name" ng-class="{'name-view-contest-entry-mode': isViewContestEntryMode}">PLAYER</div>
    <div class="remaining-time" ng-if="!isViewContestEntryMode">R.T.</div>
    <div class="score-container">POINTS</div>
    <div class="prize-container" ng-if="!isViewContestEntryMode">PRIZES</div>
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

  <contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header>
  <teams-panel id="teamsPanelComp" contest="contest" contest-id="contestId"></teams-panel>

  <div id="viewContestRoot" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
     <!-- Tabs de la versión XS -->
      <ul class="view-contest-tabs" id="liveContestTab" >
        <li class="active"> <a id="userFantasyTeamTab" ng-click="tabChange('userFantasyTeam')">Your lineup</a></li>
        <li>                <a id="usersListTab" ng-click="tabChange('usersList')">Users</a></li>
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

  <contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header>

  <teams-panel id="teamsPanelComp" contest="contest" contest-id="contestId"></teams-panel>

  <!--<div class="separator-bar"></div>-->
  <div class="info-complete-bar" ng-if="!isModeViewing">
    <p ng-if="isModeCreated">WELL DONE! YOU HAVE SUCCESSFULLY COMPLETED YOUR LINEUP</p>
    <p ng-if="isModeEdited">WELL DONE! YOU HAVE SUCCESSFULLY EDITED YOUR LINEUP</p>
    <p ng-if="isModeSwapped">THE CONTEST WAS FULL, SO WE HAVE PUT YOU IN THIS EQUIVALENT ONE</p>
    <p>Remember that you can edit your lineup as many times as you want before the contest starts</p>
  </div>

  <div id="viewContestEntry" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
      <!-- Tabs de la versión XS -->
      <ul class="view-contest-entry-tabs" id="viewContestEntryTab" >
        <li class="active"><a ng-click="tabChange('userFantasyTeam')" data-toggle="tab">Your lineup</a></li>
        <li><a ng-click="tabChange('usersList')" data-toggle="tab">Users</a></li>
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
      <div ng-if="scrDet.isXsScreen" class="button-box"><button type="button" class="ok-button" ng-click="goToParent()">BACK TO CONTESTS</button></div>
      <div class="button-box"  ng-if="isModeViewing || isModeEdited"><button type="button" class="cancel-button" ng-click="confirmContestCancellation()">CANCEL PARTICIPATION</button></div>
      <div ng-if="!scrDet.isXsScreen" class="button-box ok"><button type="button" class="ok-button" ng-click="goToParent()">BACK TO CONTESTS</button></div>
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

</section>"""));
}