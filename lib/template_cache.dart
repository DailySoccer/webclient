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
tc.put("packages/webclient/components/account/notifications_comp.html", new HttpResponse(200, r"""<div id="notificationsComp">

  <div class="default-section-header">{{getLocalizedText('name')}}</div>

  <div class="notification-list-wrapper">

    <!-- Notificaciones tipo logro -->
    <div class="notification"  ng-repeat="notification in notificationList" ng-class="{'uncommon': notification.type == 'ACHIEVEMENT_EARNED'}">

      <div class="main-info" ng-click="onAction(notification.id)">
        <div class="wrapper">
          <achievement ng-if="notification.type == 'ACHIEVEMENT_EARNED'" enabled="true" key="notification['info'].achievement"></achievement>
          <span class="name">{{notification.name}}</span>
          <span class="date">{{notification.date}}</span>
        </div>
      </div>

      <div class="additional-info">
        <div class="wrapper">
          <div class="description">{{notification.description}}</div>
          <div class="button-wrapper" ng-if="notification.link.name != ''"><button class="btn-primary" ng-click="goToLink(notification.link.url)">{{notification.link.name}}</button></div>
        </div>
      </div>

      <span class="close-button" ng-click="closeNotification(notificationList[0].id)"><img src="images/alertCloseButton.png"></span>

    </div>

  </div>

</div>"""));
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

  <div class="default-section-header">{{getLocalizedText('name')}}</div>
  
  <div class="content">
  
    <div class="money-layout">        
        <div class="money-tile-wrapper" ng-repeat="item in goldProducts">
          <div class="tile">
            <div class="header">
              <span class="title">{{item.description}}</span>
            </div>
            <div class="content">
              <img class="gold-icon" src="{{item.captionImage}}">
              <div class="content-info">
                <span class="gold-quantity">{{item.quantity}}</span>
                <div class="price-wrapper">
                  <div class="free-increment" ng-if="item.freeIncrement > 0">
                    <span class="free-increment-count">{{item.freeIncrement}}</span>
                    <span class="free-increment-desc">{{getLocalizedText('free')}}</span>
                  </div>
                  <div class="button-wrapper">
                    <button class="price" ng-click="buyGold(item.id)">{{item.price}}</button>
                  </div>
                </div>                
              </div>
              <img src="{{getLocalizedText('mostpopularimagesource')}}" class="gold-item-popular" ng-if="item.isMostPopular">
            </div>            
          </div>
        </div>
    </div>
    
    <div class="energy-layout">
      <div class="energy-tiles-wrapper">
        <div class="tile">
          <div class="energy-items" ng-repeat="energyItem in energyProducts">
            <div class="energy-separator" ng-if="$index > 0"></div>
            <div ng-class="{'no-purchasable': !energyItem.purchasable}" class="product">
              <img class="energy-icon" src="{{energyItem.captionImage}}">
              <div class="energy-description">{{energyItem.description}}</div>
              <div ng-switch="energyItem.purchasable">
                <div class="button-wrapper" ng-switch-when="true">
                  <button class="refill-button" ng-click="buyEnergy(energyItem.id)">
                    <span class="quantity">{{energyItem.price}}</span>
                  </button>
                </div>
                <div class="button-wrapper" ng-switch-when="false">
                  <span  class="product-time-left" ng-if="timeLeft != ''">{{timeLeft}}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div> """));
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
tc.put("packages/webclient/components/achievement_comp.html", new HttpResponse(200, r"""<div class="achievement {{achiev.style}}" ng-class="{'earned': earned}">
  <div class="achievement-icon">
    <img ng-src="images/achievements/{{achiev.image}}" ng-if="achiev.image != ''">
    <span class="achievement-level" ng-if="achiev.level != -1">{{achiev.level}}</span>
  </div>
  <div class="achievement-name">{{achiev.name}}</div>
  <div class="achievement-description">{{achiev.description}}</div>
</div>"""));
tc.put("packages/webclient/components/achievement_list_comp.html", new HttpResponse(200, r"""<div id="achievement-list-wrapper">
  <achievement ng-repeat="achiev in achievementList" enabled="achievementEarned(achiev.id)" key="achiev.id"></achievement>
  <div class="clearfix"></div>
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
              <!--li class="tab"><a data-toggle="tab" ng-click="tabChange('scoring')">{{getLocalizedText("scoringrules")}}</a></li-->
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
              <!--div class="tab-pane" id="scoring">
                  <div class="rules-description">
                    <scoring-rules></scoring-rules>
                  </div>
              </div-->

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
  <!--div class="info-section"></div>

  <p class="title">{{getLocalizedText("scoringrules").toUpperCase()}}</p>
  <div class="rules-description">
    <scoring-rules></scoring-rules>
  </div>
  <div class="clearfix"></div-->

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
tc.put("packages/webclient/components/create_contest_comp.html", new HttpResponse(200, r"""<div id="createContest">

  <div class="default-section-header dark">{{getLocalizedText("create_contest")}}</div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("name")}}</div>
      <div class="data-input-wrapper contest-name">
        <input id="contestNameInput" type="text" ng-model="contestName" placeholder="{{placeholderName}}" 
               class="form-control ng-binding ng-pristine ng-touched" tabindex="1">
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("contest_type")}}</div>
      <div class="data-input-wrapper contest-type">
        <span class="data-element">
          <input id="contestOficial" type="radio" value="oficial" ng-value="TYPE_OFICIAL" ng-model="contestType" name="contestType" checked>
          <label for="contestOficial"><span class="icon"></span>{{getLocalizedText("oficial")}}</label>
        </span>
        <span class="data-element">
          <input id="contestTraining" type="radio" value="training" ng-value="TYPE_TRAINING" ng-model="contestType" name="contestType">
          <label for="contestTraining"><span class="icon"></span>{{getLocalizedText("training")}}</label>
        </span>
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("competition")}}</div>
      <div class="data-input-wrapper competition">
        <span class="data-element">
          <input id="contestLeague" type="radio" value="LEAGUE_ES" name="competition"
                 ng-class="{'disabled-radio': templatesFilteredList[leagueES_val].length == 0 }"
                 ng-value="leagueES_val" ng-model="selectedCompetition"
                 ng-disabled="templatesFilteredList[leagueES_val].length == 0">
          <label for="contestLeague"><span class="icon"></span>{{getLocalizedText("spanish_league")}}</label>
        </span>
        <span class="data-element">
          <input id="contestPremiere" type="radio" value="LEAGUE_UK" name="competition"
                 ng-class="{'disabled-radio': templatesFilteredList[leagueUK_val].length == 0 }"
                 ng-value="leagueUK_val" ng-model="selectedCompetition"
                 ng-disabled="templatesFilteredList[leagueUK_val].length == 0">
          <label for="contestPremiere"><span class="icon"></span>{{getLocalizedText("premier_league")}}</label>
        </span>
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("event")}}</div>
      <div class="data-input-wrapper contest-template">
        <select ng-disabled="printableTemplateList.length == 0" name="contestTemplateSelector" id="contestTemplateSelector"
                class="form-control contest-template-selector dropdown-toggle" ng-model="selectedTemplate" >

          <option id="option-contest-select-contest" value="" ng-value="null" ng-bind="comboDefaultText"></option>

          <option ng-repeat="template in printableTemplateList" id="option-contest-template-{{template.templateContestId}}"
                  value="{{$index + 1}}" ng-value="template">{{template.name}}</option>
        </select>
      </div>
    </div>
  </div>

  <teams-panel id="teamsPanelComp" panel-open="true" template-contest="selectedTemplate" button-text="getLocalizedText('matches_title')"></teams-panel>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("rivals")}}</div>
      <div class="data-input-wrapper contest-style">
        <span class="data-element">
          <input id="contestHeadToHead" type="radio" value="headToHead" ng-value="STYLE_HEAD_TO_HEAD" ng-model="contestStyle" name="contestStyle" checked>
          <label for="contestHeadToHead"><span class="icon"></span>{{getLocalizedText("head_to_head")}}</label>
        </span>
        <span class="data-element">
          <input id="contestOpen" type="radio" value="league" ng-value="STYLE_LEAGUE" ng-model="contestStyle" name="contestStyle">
          <label for="contestOpen"><span class="icon"></span>{{getLocalizedText("league")}}
            <select name="contestLeagueCountSelector" id="contestLeagueCountSelector"
                    class="form-control contest-league-count-selector dropdown-toggle" ng-model="selectedLeaguePlayerCount">

              <option ng-repeat="count in leaguePlayerCountList" id="option-contest-count-{{count}}"
                      value="{{$index + 1}}" ng-value="count">{{count == -1? getLocalizedText("no_limit") : count}}</option>

            </select>
          </label>
        </span>
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("date")}}<span class="annotation" ng-if="contestType == TYPE_OFICIAL">{{getLocalizedText("fixed_hour_warning")}}</span></div>
      <div class="data-input-wrapper date">
        <week-calendar id="createContestCalendar" disabled="contestType == TYPE_OFICIAL" selected-date="selectedDate" on-day-selected="onSelectedDayChange(day)" dates="dayList"></week-calendar>

        <div class="contest-hour-selector-wrapper">
          <select ng-disabled="contestType == TYPE_OFICIAL" name="contestHourSelector" id="contestHourSelector"
                  class="form-control contest-hour-selector dropdown-toggle" ng-model="selectedHour">

            <option ng-repeat="hour in hourList" id="option-contest-hour-{{hour}}"
                    value="{{$index + 1}}" ng-value="hour">{{hour}}:{{selectedMinutesText}}</option>

          </select>
        </div>

      </div>
    </div>
  </div>
  <div class="create-contest-section-wrapper large">
    <div class="create-contest-section" ng-if="selectedTemplate != null">
      <div class="title">Premios</div>
      <div class="data-input-wrapper entry-fee">
        <span class="data-element">
          <div class="entry-fee-values-wrapper">
          <span class="entry-fee-value" ng-class="{'gold' :contestType == TYPE_OFICIAL, 'energy': contestType != TYPE_OFICIAL}">{{entryFee.toInt()}}</span> 
          por 
          <span class="entry-fee-value" ng-class="{'gold' :contestType == TYPE_OFICIAL, 'manager-points': contestType != TYPE_OFICIAL}">{{computedPrize}}</span>
          </div>
        </span>
        <div>
          <span>Repartición de premios: </span>
          <span>{{prizeType}}</span>
        </div>
        
        <!--span class="data-element">
          <input id="contestFee_1E_3MP" type="radio" value="1E_3MP" name="entry-fee">
          <label for="contestFee_1E_3MP"><span class="entry-fee-value energy">1</span> por <span class="entry-fee-value manager-points">3</span></label>
        </span>
        
        <span class="data-element">
          <input id="contestFee_1G_3G" type="radio" value="1G_3G" name="entry-fee">
          <label for="contestFee_1G_3G"><span class="entry-fee-value gold">1</span> por <span class="entry-fee-value gold">3</span></label>
        </span-->
      </div>
    </div>
  </div>


  <div class="create-contest-section-wrapper large">
    <div class="create-contest-section">
      <div class="data-input-wrapper confirm-button-wrapper">
        <button type="button" class="btn-confirm-contest"
                ng-click="createContest()"
                ng-disabled="!isComplete">{{getLocalizedText("create_contest_btt")}}</button>
      </div>
    </div>
  </div>

  <div class="clearfix"></div>
</div>"""));
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
                                 manager-level="playerManagerLevel"
                                 lineup-slots="lineupSlots"
                                 on-lineup-slot-selected="onLineupSlotSelected(slotIndex)"
                                 formation-id="formationId"
                                 lineup-formation="lineupFormation"></lineup-selector>
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
  <div class="lineup-formation-selector-wrapper collapsed" data-toggle="collapse" data-target="#formationsPanel">
    <span class="current-formation">{{getPrintableFormation()}}</span>
    <span class="formation-change-button">{{getLocalizedText('change')}}</span>
  </div>
  <div id="formationsPanelRoot" class="animate">
    <div class="formation-panel-wrapper" >
       
      <div id="formationsPanel" class="formations-container collapse">
        <span class="formation-element" id="formationElement{{key}}" ng-repeat="key in formationList">
          <input id="formation{{key}}" name="formation{{key}}" type="radio" value="{{key}}" ng-value="key" ng-model="formationId">
          <label for="formation{{key}}">{{formationToString(key)}}</label>
        </span>
      </div>
    </div>
  </div>

  <div class="lineup-selector-slot" ng-repeat="slot in lineupSlots" ng-click="onLineupSlotSelected({'slotIndex': $index})" ng-class="getSlotClassColor($index)">

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
    <div class="home-tile-content">
      <div class="tile">
        <div ng-bind-html="contestTileHTML"></div>
        <span class="tile-action"></span>
      </div>
    </div>
  </div>
  
  <div id="manageTile" class="vertical-layout-tilling">
    <div id="createContestTile" class="home-tile-wrapper" ng-click="onCreateContestClick()" ng-class="{'disabled': !isCreateContestTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('create_contest_title')}}</span>
          <span class="tile-info">{{CreateContestTileText}}</span>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
    <div id="scoutingTile" class="home-tile-wrapper" ng-click="onScoutingClick()" ng-class="{'disabled': !isScoutingTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('scouting_title')}}</span>
          <span class="tile-info ">{{getLocalizedText('scouting_info')}}</span>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
  </div>
  
  <div id="myContestsTile" class="vertical-layout-tilling">
    <div id="upcomingTile" class="home-tile-wrapper" ng-click="onUpcomingClick()" ng-class="{'disabled': !isUpcomingTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('upcoming_title')}}</span>
          <div class="tile-info">
            <span ng-if="!isUpcomingTileEnabled">{{getLocalizedText('mycontest_disabled_info')}}</span>
            <span ng-if="isUpcomingTileEnabled" class="num-contest-info">{{numUpcomingContests}}</span>
          </div>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
    <div id="liveTile" class="home-tile-wrapper" ng-click="onLiveClick()" ng-class="{'disabled': !isLiveTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('live_title')}}</span>
          <div class="tile-info">
            <span ng-if="!isLiveTileEnabled">{{getLocalizedText('mycontest_disabled_info')}}</span>
            <span ng-if="isLiveTileEnabled" class="num-contest-info">{{numLiveContests}}</span>
          </div>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
    <div id="historyTile" class="home-tile-wrapper" ng-click="onHistoryClick()" ng-class="{'disabled': !isHistoryTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('history_title')}}</span>
          <div class="tile-info">
            <span ng-if="!isHistoryTileEnabled">{{getLocalizedText('mycontest_disabled_info')}}</span>
            <span ng-if="isHistoryTileEnabled" class="num-contest-info virtual">{{numVirtualHistoryContests}}</span>
            <span ng-if="isHistoryTileEnabled" class="num-contest-info real">{{numRealHistoryContests}}</span>
          </div>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
  </div>
  
  
  <div id="helpTile" class="vertical-layout-tilling">
    <div id="blogTile" class="home-tile-wrapper enabled" ng-click="onBlogClick()" ng-class="{'disabled': !isBlogTileEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('blog_title')}}</span>
          <span class="tile-info">{{getLocalizedText('blog_info')}}</span>
          <span class="tile-blog-author">{{getLocalizedText('blog_author')}}</span>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
    <div id="howitworksTile" class="home-tile-wrapper" ng-click="onHowItWorksClick()" ng-class="{'disabled': !isHowItWorksEnabled}">
      <div class="home-tile-content">
        <div class="tile">
          <span class="tile-title">{{getLocalizedText('help_title')}}</span>
          <span class="tile-info">{{getLocalizedText('help_info')}}</span>
          <span class="tile-action"></span>
        </div>
      </div>
    </div>
  </div>
  
  <div class="clearfix"></div>
</div>"""));
tc.put("packages/webclient/components/leaderboard_comp.html", new HttpResponse(200, r"""<div id="leaderboard-wrapper">

  <div class="default-section-header">{{getLocalizedText('title')}}</div>

  <ul id="#leaderboardTabs" class="leaderboard-tabs" role="tablist">
    <li id="points-tab" class="active"><a class="leaderboard-tab top-points-tab"   role="tab" data-toggle="tab" ng-click="gotoSection('points')">{{trueskillTabTitle}}</a></li>
    <li id="money-tab">                <a class="leaderboard-tab top-money-tab"    role="tab" data-toggle="tab" ng-click="gotoSection('money')">{{goldTabTitle}}</a></li>
    <li id="achievements-tab">         <a class="leaderboard-tab achievements-tab" role="tab" data-toggle="tab" ng-click="gotoSection('achievements')">{{achievementsTabTitle}}</a></li>
  </ul>

  <div class="tabs">
    <div class="tab-content">

      <div class="tab-pane active" id="points-content">

        <leaderboard-table show-header="true" highlight-element="playerPointsInfo" table-elements="pointsUserList" rows="USERS_TO_SHOW" points-column-label="pointsColumnName" hint="playerPointsHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="money-content">

        <leaderboard-table show-header="true" highlight-element="playerMoneyInfo" table-elements="moneyUserList" rows="USERS_TO_SHOW" points-column-label="moneyColumnName" hint="playerMoneyHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="achievements-content">

        <achievement-list ng-show="!loadingService.isLoading"></achievement-list>

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
tc.put("packages/webclient/components/legalese_and_help/help_info_comp.html", new HttpResponse(200, r"""<div id="helpInfo">

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText('title')}}</div>

  <!-- Nav tabs -->
  <ul class="help-info-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('tutorial-content')">{{getLocalizedText('tutorials')}}</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('how-works-content')">{{getLocalizedText('how-it-works')}}</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('rules-scores-content')">{{getLocalizedText('rules')}}</a></li>
  </ul>

  <div class="tab-pane active" id="tutorial-content">
    <div class="block-light">
      <tutorials-comp></tutorials-comp>
    </div>
  </div>

  <div class="tab-pane" id="how-works-content">
    <how-it-works></how-it-works>
  </div>
  <div class="tab-pane" id="rules-scores-content">
    <!--div class="block-dark">
      <div class="title">SCORING AND RULES</div>
      <div class="scores-wrapper">
        <scoring-rules></scoring-rules>
      </div>
    </div-->
    <rules-comp></rules-comp>
  </div>

</div>
"""));
tc.put("packages/webclient/components/legalese_and_help/how_it_works_comp.html", new HttpResponse(200, r"""<div id="helpInfo">
  <div class="block-light" id="help-info-1">
    <div class="title" ng-bind-html="getLocalizedText('point1title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point1content')"></div>
    <div class="img-wrapper">
      <img src="images/help01-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help01.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-dark" id="help-info-2">
    <div class="title" ng-bind-html="getLocalizedText('point2title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point2content')"></div>
    <div class="img-wrapper">
      <img src="images/help03-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help03.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-light" id="help-info-3">
    <div class="title" ng-bind-html="getLocalizedText('point3title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point3content')"></div>
    <div class="img-wrapper">
      <img src="images/help04-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help04.png" ng-if="!scrDet.isXsScreen">
    </div>
    <div class="description" ng-bind-html="getLocalizedText('point3content2')"></div>
  </div>
  
  <div class="block-light" id="help-info-4">
    <div class="title" ng-bind-html="getLocalizedText('point4title')"></div>
    <div class="block-last">
      <div class="img-wrapper-left">
        <img src="images/help06.jpg">
      </div>
      <div class="description-right">
        <p ng-bind-html="getLocalizedText('point4description')"></p>
        <button type="button" class="button-play" ng-click="goTo('lobby')">{{getLocalizedText("button-play")}}</button>
      </div>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/rules_comp.html", new HttpResponse(200, r"""<div class="block-light">
  <div class="title">{{getLocalizedText('rules-title')}}</div>
  <div class="rules-wrapper">
    <div class="toogle-block" ng-repeat="title in titleList" >
      <input type="checkbox" id="rule{{$index}}" class="toggle">
      <label for="rule{{$index}}">{{title}}</label>
      <div ng-bind-html-unsafe="sectionList[title]"></div>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/terminus_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">

  <!-- header title -->
  <div class="default-section-header">TERMS AND CONDITIONS</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
    <h1>
        1. GENERAL Terms
    </h1>
    <p>
        1.1 The present Terms and Conditions of Use (onwards “Terms and Conditions”) regulate the use and access to our Platform, being expressly and completely accepted by the mere fact of entering the Platform and/or by the visualization of its contents or use of the included content. In the case that this conditions are not accepted or any of the particular conditions, the user should refrain from enter our Platform as well as using its services and products.
    </p>
    <p>
        1.2 Epic Eleven holds the right to modify this Terms and Conditions whenever considers its due, without assuming any responsibility for it, binding the user by the Terms and Conditions in force at that time, by the mere fact of accessing our Portal or signing up in that specific moment.
    </p>
    <p>
        1.3 Our Portal is oriented to citizens of any nationality or residency, but always to legally adults according to local regulations, therefore denying the inscription to under-ages. Epic Eleven prohibits expressly the under-ages, according to local regulations, to sign up. Moreover, every user can only have one single account in Epic Eleven. Epic Eleven holds the right to cancel the account of users who commit fraud, like duplicates of a certain account or falsify personal data with the goal of gaining more points or contests. Users agree that there is a process to validate any data they introduce in the Portal, such as validation of the phone number or a request of documentation that allows Epic Eleven to check if a user is a legal adult.
    </p>
    <p>
        1.4 The Portal is oriented to citizens of any nationality or residency, as long as the current regulations allows them to perform activity in the Portal, with a purely promotional, free-to-play end, which is the main end of the Portal. According to our Terms and Conditions, Epic Eleven expressly prohibits its use to individuals whose legislation, according to their nationality or residency, does not allow them to participate in our Portal. Also, to those who sign up and participate in it albeit being forbidden, Epic Eleven declines any responsibility.
    </p>
    <p>
        1.5 Any person who signs up in our Portal acquires the condition of “User” (onwards known as “User” or “the User”), being able to access all the services offered within the Portal. The user must identify every time, in order to guarantee the security of the process, the fulfillment of this Terms and Conditions and moreover, the transaction of money to a certain user wherever it is fit. To sign up or log in (once a user has already sign up for the first time), the user must use a valid e-mail address. Accessing as a “visitor” (onwards known as “Visitor” of “the Visitor”) to Epic Eleven will not require any personal info until the visitor tries to introduce a line up in a contest, independently if that contest is free or requires an entry fee. In case the visitor wants to subscribe to any of Epic Eleven newsletter, an email would be required, being that a personal e-mail, not a public one.
    </p>
    <p>
        1.6 Both the User and the Visitor are aware that the access and use of the Portal is being made under its own responsibility. In this regard, the User will be asked to choose a user name and a password. The User is responsible for keeping the password hidden from a third person, as well as to not allow a third person to access the account on its behalf or to let a third person manipulate the account in a way that presents a danger to the security of the account and its rightful owner.
    </p>
    <p>
        1.7 The user must establish the necessary security measures in order to avoid unwanted actions on the personal systems and computers that the User uses to access Internet and, specially, our Portal.
    </p>
    <h1>
        2. User’s Rights and obligations
    </h1>
    <p>
        The user will be able to:
    </p>
    <p>
        2.1 Access for free to our Portal’s available contents without previous authorization, without taking harm to any special technical conditions or the need of a previous sign up in services and specific contents of a third partner, as are specified in this conditions. Nonetheless, the User will be held responsible for the payment of any Internet service regarding the connection and navigation through the web, from its own computer to any device the User uses, that providers charge in those concepts, attending to its own deals with those providers.
    </p>
    <p>
        2.2 Make use of the available services and contents for its particular use, without taking harm about what was explicitly disposed in the conditions that regulates the use of a specific service and/or content. The User commits to use the Portal for its rightful use, and not for commercial use without the specific written consent of Epic Eleven or without having agreed to specific terms and conditions for that commercial use with Epic Eleven.
    </p>
    <p>
        2.3 Make a good and legal use of the Portal; in agree with this Terms and Conditions, the actual legislation, moral grounds and good faith.
    </p>
    <p>
        2.4 Particularly, to what its due to CHEATING OR HACKING, the User makes a commitment by agreeing to this Terms and Conditions, to not perform any of the follow actions:
    </p>
    <ul>
        <li>
            To design, activate, sell or help to create any unauthorized software which end purpose interferes with the Portal, with any of its services or contents, or other users.
        </li>
        <li>
            To modify any file or software that belongs to the Portal, without previous explicit and written consent from Epic Eleven.
        </li>
        <li>
          To harm, overload or contribute in any way to interfere with the good performance of any piece of hardware related in some way to give assistance to the Portal or to help anyone to enjoy all services and contents that the Portal has to offer.
        </li>
        <li>
            To impulse, contribute or take part in any kind of attack, including, e.g. distributing a virus via e-mail, unwanted e-mails, spam… or any other attempts to do harm to the Portal, its use or enjoyment of the Portal by a third party.
        </li>
        <li>
            To try to access the Portal through an unauthorized way, through other user’s accounts or through any hardware related to the computers, servers or networks that belongs to Epic Eleven or any other third party.
        </li>
    </ul>
    <p>
        Also, regarding to OFFENSIVE CONTENTS, the User commits not to perform any of the following actions:
    </p>
    <ul>
        <li>
            To publish any information that can be abusive, threatening, obscene, defamatory or offensive from a racial, sexual or religious point of view.
        </li>
        <li>
            To publish any information that contains sexual material, excessive violence or offensive topics, or that contains a link to any of this topics.
        </li>
        <li>
            To bully, abuse, offend or, in short, to mistreat any other User, groups of people, or any of the employees and collaborators of Epic Eleven.
        </li>
        <li>
            To use the Portal, including any use of links, to make accessible any material or information that infringes any copyright, commercial brand, patent, industrial or commercial secret, privacy right, commercial right or any right of any physical or legal person, or to impersonate anyone, e.g. any Epic Eleven’s employee or collaborator.
        </li>
        <li>
            To use inappropriately Epic Eleven’s customer service, which includes sending false reports of any kind of abuse or the use of an inadequate, obscene or abusive language in any communication.
        </li>
    </ul>
    <p>
        Generally, the User will never be allowed to:
    </p>
    <ul>
        <li>
            To access or use the services and contents of the Portal with illicit, harmful ends that infringe rights and freedom of a third party, or that may harm or impede by any mean the access to those services and contents to Epic Eleven or a third party.
        </li>
        <li>
            To use the services that Epic Eleven provides to, complete or partially, promote, sell, hire, market or divulge you own or third party’s information.
        </li>
        <li>
            To include links in its own particular or commercial site to this Portal, breaking the Terms and Conditions provided for. Also, to use the services or contents offered through the Portal in a way that it Terms and Conditions does not allow, or inflicting harm on any of the rights that the rest of the users or Epic Eleven itself holds.
        </li>
        <li>
            To perform any action that impedes or difficult the access to the Portal to other Users, as well as to the links to other services or contents offered by Epic Eleven or a third party via the Portal; To use the Portal as a medium to commit any felony or act against the actual legislation, moral grounds and good faith.
        </li>
        <li>
            To use any kind of virus, code, software or hardware that might result in any harm or unauthorized alteration in the Portal, its contents or any system accessible via the Portal or the hardware and software of any User.
        </li>
        <li>
            To erase or modify in any way any medium the Portal uses to protect and identify its Users, the contents stored in the Portal or any symbol that Epic Eleven or any other third party uploads into the Portal. Those contents will be protected by the inherent copyrights that those Users incorporate to their creations.
        </li>
        <li>
            To include in any web site of its own responsibility or property “metatags” of any brand, commercial name o any distinctive symbol property of Epic Eleven or any other related third party.
        </li>
        <li>
            To reproduce total or partially the Portal in any other web site without fulfilling the expected conditions for that matter.
        </li>
        <li>
            To get frames of the Portal, or any web site accessible through the Portal, that hide or modify –with delimitative intention, but not restrictive- contents, commercial spaces and brands of Epic Eleven or any other related third party, independently of this action being one considered as unfair competition or to create confusion.
        </li>
        <li>
            To create frames inside any web site of its own responsibility or property that reproduces the main page or the Portal or any of the accessible pages through it without the explicit consent of Epic Eleven.
        </li>
        <li>
            To ask or try to obtain through any mean personal information about other Users of the Portal; collect, publish or obtain by any mean personal information of other Users of Epic Eleven, without the explicit consent of Epic Eleven.
        </li>
    </ul>

    <h1>
        3. epic eleven’s rights
    </h1>
    <p>
        Epic Eleven holds the following rights:
    </p>
    <p>
        3.1 To modify the present Terms and Conditions, as the conditions, technical or not, to access the Portal unilaterally and without previous notice to the Users, without detriment of anything set in the particular conditions that regulate the use of a certain service or content within this Portal.
    </p>
    <p>
        3.2 To establish a certain condition or instead a price in order to access particular features or services within the Portal.
    </p>
    <p>
        3.3 To limit, exclude, suspend, cancel, modify or influence the access to the Portal, without previous notice to the Users, when those Users do not respect the previous guarantees for a safety and correct use of the Portal. In those cases, Epic Eleven might cancel the username and passwords, any points, benefits, gifts or winnings associated to a certain user account, without being obliged to extend any compensation.
    </p>
    <p>
        3.4 To terminate, suspend, modify or influence, without previous notification to the Users, the service provided or the supply of content without being obliged to compensate in any way, when the said service turns out to be used by the User in a way that attacks the legality or the present Terms and Conditions that regulates any service or content within the Portal. In those cases, Epic Eleven may cancel the username, passwords, any point, benefit or gift associated to a certain account, without being obliged to extend any compensation.
    </p>
    <p>
        3.5 To modify unilaterally and without previous notice, anytime Epic Eleven sees fit, the structure and design of the Portal, as well as to update, modify or suppress all or part of the contents, services or access and use conditions of the Portal, and may even restrict or prohibit the access to that specific information.
    </p>
    <p>
        3.6 To deny at any time and without previous notice the access to the Portal to those Users or Visitors that break this Terms and Conditions. In those cases, Epic Eleven may even cancel the username, passwords any point, benefits or gift associated to a certain account, without being obliged to extend any compensation to the User or Visitor.
    </p>
    <p>
        3.7 To undertake any legal action that sees fit for the protection of Epic Eleven’s rights, and any third party that gives service or contents through the Portal, anytime.
    </p>
    <p>
        3.8 To demand compensation that may sees fit from improper or illegal use of all or part of the services and contents provided through the Portal.
    </p>
    <h1>
        4. Operations within the portal
    </h1>
    <p>
        4.1 Any adult physical person, being an ‘adult’ what the law of this person’s nationality considers so, that signs up as User and provides the necessary truthful information would be considered as a “Player” (onwards “Player” or “the Player”).
    </p>
    <p>
        4.2 By the mere fact of filling the sign up form, the Player accepts irrevocably this Terms and Conditions.
    </p>
    <p>
        4.3 A User can only own one account and can only play on Epic Eleven with this very one account. Epic Eleven holds the right to impede this User to participate in the case that this rule is not met.
    </p>
    <p>
        4.4 The Player will have a balance of Epic Eleven Points (or “Epic Points”), displayed within the Portal. Those Epic Points will vary according to the rules displayed in the Portal.
    </p>
    <p>
        4.5 Epic Eleven might change the rules of the Epic Points unilaterally without previous notice to the Users and at any time if considered necessary.
    </p>
    <p>
        4.6 Additionally, this balance might be increase by promotions, such as share-with-friends promotions, commercial promotions or special occasions that Epic Eleven sees fit. This additional means to increase Epic Points will be regulated by the conditions exposed by Epic Eleven at the Portal.
    </p>
    <p>
        4.7 The balance will diminish naturally when the User uses Epic Points to enter any contests that allows this as a mean to participate.
    </p>
    <p>
        4.8 The Epic Points in any account and the account itself could be cancelled by Epic Eleven at any point, unilaterally and without being obliged to extend any compensation, if there is no movement in the account for a consecutive period of twelve months.
    </p>
    <p>
        4.9 Epic Points are personal and not transferable, and therefore can’t be loaned, transferred, sold or used in any other way than its primary purpose explained in the Rules. Also, Epic Points cannot be transferred between accounts even if the Player attests to be the owner of both accounts, which would be also a violation of this Terms and Conditions, as it was explained in section 4.3 of this Terms and Conditions.
    </p>
    <p>
        4.10 Epic Eleven advises to act within the limits of the local law every time. Epic Eleven does not know the applicable local laws, and therefore will not assume any responsibility derived of the misuse of the Portal, which includes taxations. If any User requires information about taxation and/or any legal inquiry, Epic Eleven advises to appeal to the relevant consultant agents on its own jurisdiction.
    </p>
    <p>
        4.11 Epic Eleven holds the right to terminate the condition of “Player” of any User and every derived right of that condition, at any time and without being obliged to extend any compensation, as a consequence of a Player breaking any of this obligations according to the Terms and Conditions, Force Majeure, suspension or cancellation of any service offered by Epic Eleven. This is valid as well for a situation where the Portal is about to stop, extinct or dissolve its activity. In the case of cessation of activity of the User in its condition as Player in the Portal, Epic Eleven won’t have any responsibility or obligation towards the User if cancels the account and revoke the points, although Epic Eleven will be able to take any action it considers necessary according to the Law in order to demand accountability in case the User does not meet the Terms and Conditions or the applicable law at any point.
    </p>
    <h1>
        5. EXEMPTIONS and limitation of liability of epic eleven
    </h1>
    <p>
        Epic Eleven is exempt from any liability for damages of any nature in the following cases:
    </p>
    <p>
        5.1 Due to the impossibility or difficulties in connecting to the communications network through which this Portal is accessible regardless of the type of connection used by the user.
    </p>
    <p>
        5.2 Due to the interruption, suspension or cancellation of the Portal, as well as the availability and continuity of the Website or the services and/or contents therein, when this one is due to causes beyond the control of Epic Eleven.
    </p>
    <p>
        5.3 Epic Eleven assumes no responsibility for the services and contents, nor for the availability and conditions, technical or otherwise, to access to those services and contents, which are offered by third party service providers, especially regarding those providers specially dedicated to offer this access.
    </p>
    <p>
        5.4 Epic Eleven, at any time, does not accept liability for damages that may cause the information, content, products and services, communicated, hosted, transmitted, displayed or offered by third parties outside Epic Eleven, including service providers. That includes anything that can be accessed through a link on this website posted by these third parties or any other User.
    </p>
    <p>
        5.5 Treatment and subsequent use of personal data by third parties outside Epic Eleven, and the relevance of the information requested by them.
    </p>
    <p>
        5.6 Quality and speed of access to the Portal and technical conditions to be met by the User to gain access to the Portal and its services and/or content.
    </p>
    <p>
        5.7 Epic Eleven will not be responsible for delays or faults produced in access and/or operation of services and/or contents of the Portal, due to Force Majeure.
    </p>
    <p>
        5.8 The User will be personally liable for damages of any kind caused to Epic Eleven, directly or indirectly, for breach of any of the obligations under these Terms and Conditions or other rules governing the use of the Portal.
    </p>
    <h1>
        6. Intellectual and industrial property
    </h1>
    <p>
        6.1 User acknowledges that the contents and services offered through the Site, -including text, graphics, images, animations, musical creations, videos, sounds, drawings, photographs, all comments, exhibitions, applications, databases and html code same without this list being limited- are protected by intellectual property laws. Copyright and economic exploitation of this Site is for Epic Eleven. As for the contents included in the Portal, copyright and economic exploitation are the property of Epic Eleven or where appropriate, from third parties, and where is applicable, intellectual property laws protects both cases: Epic Eleven and third parties.
    </p>
    <p>
        6.2 The trademarks, trade names or logos appearing on the Site are owned by Epic Eleven, and are protected by applicable intellectual property laws.
    </p>
    <p>
        6.3 The provision of services and publication of content through the Portal does not imply any assignment, surrender or transfer all or part of the ownership of the corresponding intellectual and industrial property.
    </p>
    <p>
        6.4 No part of this Website may be reproduced, distributed, transmitted, copied, publicly communicated, transformed, in whole or in part by any system or manual, electronic or mechanical means (including photocopying, recording or any retrieval system and storage) through any media now known or invented in the future, without the consent of Epic Eleven. The use, in any form, all or part of the content of the Website is subject to the need for prior authorization of Epic Eleven, and acceptance of the license, if any, except for the provisions on the rights and granted to the User in these Terms and Conditions or what is thus determined by the particular conditions that Epic Eleven may establish to regulate the use of a particular service and/or content offered through the Portal.
    </p>
    <p>
        6.5 Under no circumstances, the user may make an application or use of services and content on the page that is not exclusively personal, safe from the exceptions identified in the present conditions of use of this Portal or the particular conditions that Epic Eleven may establish to regulate the use of a particular service and/or content offered through the Portal.
    </p>
    <p>
        6.6 If the act or omission fault or negligence directly or indirectly attributable to User Portal arising from the infringement of the rights of intellectual property of Epic Eleven or third parties, whether or not benefit to the same, fells into Epic Eleven damages, losses, joint obligations, expenses of any kind, sanctions, coercive measures, fines and other amounts arising or resulting from any claim, demand, action, suit or proceeding, whether civil, criminal or administrative, Epic Eleven is entitled to bring proceedings against the User by all legal means at its disposal and to claim any compensation, including, but not limited to, moral and image damages, consequential damages and loss of earnings, advertising costs or any other that might be for repair, sanction or convictions, that of the default interest, court costs and the total cost of the defense in any process that could arise due to the aforementioned causes for damages incurred by reason of his act or omission, without Subject to exercise any other remedies available to him accordingly to the law.
    </p>
    <h1>
        7. Links and hyperlinks
    </h1>
    <p>
        7.1 Individuals or entities who wish to create a hyperlink from a web page from another internet portal to any pages of Epic Eleven’s Portal must abide by the following conditions:
    </p>

    <ul class="latin-list">
      <li>
        The total or partial reproduction of any services or content offered is not allowed.
      </li>
      <li>
        No deep-links, or frames with the pages of the Portal would be established without the express permission of Epic Eleven.
      </li>
      <li>
        No false, inaccurate or incorrect demonstration will be included on the pages of the Portal or any of its services or contents.
      </li>
      <li>
        Except for those signs that are part of the "hyperlink", the website where the links directs the User will not contain any trademark, trade name, label, name, logo, slogan or other distinctive signs belonging to Epic Eleven, unless previous authorization.
      </li>
      <li>
        The establishment of "hyperlink" does not imply the existence of any relationship between Epic Eleven and the owner of the website or portal from which it is made.
      </li>
      <li>
        Epic Eleven is not responsible for the contents or services made available to the public on the website or portal from which the "hyperlink" or the information and statements included therein.
      </li>
      <li>
        Any "hyperlink" to Portal Epic Eleven will be to the homepage or main pages of the sections it contains.
      </li>
    </ul>

    <p>
        7.2 Eleven Epic disclaims any responsibility for information contained in third party websites connected by links to the Portal of Epic Eleven or to those links that are not directly managed by our website administrator. The function of the links on this website is for information and in no way a suggestion, invitation or recommendation to visit the places of destination. When a Player wishes to use some of the Portal services, it must provide first some certain personal data to Epic Eleven. Epic Eleven treat such data for the purposes and under the conditions defined in this Privacy Policy.
    </p>
    <h1>
        8. FINALS
    </h1>
    <p>
        8.1 Disputes. For the resolution of any disputes arising from the interpretation and/or enforcement of these Terms and Conditions, Users, both Players and Visitors, expressly waiving any other jurisdiction that may apply to the Courts, they consent to undergo to the courts of the city of Madrid.
    </p>
    <p>
        8.2 Applicable law. These Terms and Conditions are governed by the common Spanish legislation and construed in accordance with the same.
    </p>
    <p>
        8.3 Invalid clauses. If any provision of these Terms and Conditions shall be deemed or may be illegal, invalid or unenforceable, these Terms and Conditions shall be deemed severable and inoperative in relation to that clause and to where it is deemed unlawful, void or unenforceable; and, by making reference to any other aspect of these Terms and Conditions will remain in full force and full effect; provided, however, that any provision of these Terms and Conditions shall be deemed or may be illegal, invalid or unenforceable, Epic Eleven will automatically include a clause as close as possible to the illegal, invalid or unenforceable to make it legal, valid and enforceable provision.
    </p>
    <p>
        8.4 Headings. The headings of the clauses of these Terms and Conditions are made only for reference purposes and in no way affect or limit the meaning and content thereof.
    </p>
    <p>
        8.5 Claims. To make any claims about the services provided through the portal, the User can send an email to support@epiceleven.com indicating their data, exposing the facts underlying the claim or complaint and specifying his claim. If you prefer, we also have complaint forms available to those requesting it at the address stated in the Legal Notice.
    </p>
    <h1>
        Identification data
    </h1>
    <p>
        You are visiting the website <a href="http://www.epiceleven.com" target="_blank">www.epiceleven.com</a>, ownership of SPORTS FANTASY GAMES, SL (hereinafter EPIC ELEVEN). The same is domiciled in Avenida Brasil, 23, Officinal 5-A, 28020, Madrid, and its e- mail address: info@epiceleven.com identified with C.I.F. B-87028445.
    </p>
    <h1>
        User Agreement
    </h1>
    <p>
        This Legal Notice governs the access and use of the website <a href="http://www.epiceleven.com" target="_blank">www.epiceleven.com</a> (hereinafter the "Portal") that EPIC ELEVEN makes available to Internet users. Access to it implies unreserved acceptance of this Legal Notice. Also, EPIC ELEVEN can offer through the Portal services that may be subject to some own conditions on which the User will be informed in each case.
    </p>
    <h1>
        ACCESs to the WEB and passwords
    </h1>
    <p>
        By accessing the website, the User declares to have enough capacity to navigate EPIC ELEVEN, ie: be eighteen years old and not be incapacitated. In turn, generally no subscription or registration as a user is required to access and use of the Portal, without prejudice to the use of certain services or content of such where a subscription or registration is required. The obtained data from Users through the subscription or registration to this website are protected by passwords chosen by themselves. The User agrees to keep that password secret and protect it from unauthorized use by third parties. The User shall immediately notify EPIC ELEVEN any non-consensual use of the account or any violation security-related of any service within the Portal of which he was aware. EPIC ELEVEN adopts the technical and organizational measures to ensure the protection of personal data and avoid its alteration, loss, treatment and/or unauthorized access, given the state of the art, the nature of the stored data and the risks they are exposed, all in accordance with the provisions of the Spanish legislation Protection of Personal Data. EPIC ELEVEN is not made liable to the Users for the disclosure of personal data to third parties other than due to causes directly attributable to EPIC ELEVEN, nor for the use made of such data to third parties that are not part of EPIC ELEVEN.
    </p>
    <h1>
        Correct use of the web
    </h1>
    <p>
        The User agrees to use the Portal, content and services in accordance with the law, this Legal Notice, morals and public order. Similarly, the User agrees not to use the Portal or the services provided through it for illegal purposes or contrary to the contents of this Legal Notice, detrimental to the interests or rights of others, or in any way could damage, disable or impair the website or its services or impede normal enjoyment of the website by other users. Without limiting the foregoing, EPIC ELEVEN can offer through the web additional services that have their own additional regulation. In these cases, the Users will be properly informed in each specific case. Also, the User expressly agrees not to destroy, alter, disable or otherwise, damage data, programs or documents that are on the Portal. The User agrees not to hinder access of other users to access service through the mass consumption of computing resources through which EPIC ELEVEN serves, as well as actions that may damage, interrupt or generate errors in these systems. The User agrees not to introduce programs, viruses, macros, applets, ActiveX controls or any other logical device or character sequence that cause or may cause any type of alteration in EPIC ELEVEN or third parties computer systems.
    </p>
    <h1>
        Links to third parties
    </h1>
    <p>
        This legal notice relates only to the Portal and content of EPIC ELEVEN, and does not apply to the links or the websites of third parties accessible through the Portal. The webs of these links are not under the control of EPIC ELEVEN, and the same is not responsible for the content of any of the Web pages destination of a link, or any link contained in a Web page that is reached from the EPIC web ELEVEN, or any changes or updates to such sites. These links are provided solely to inform the user about the existence of other sources of information about a particular topic, and the inclusion of any link does not imply endorsement of the linked website by EPIC ELEVEN.
    </p>
    <h1>
        Intellectual property
    </h1>
    <p>
        ELEVEN EPIC warns that intellectual property rights of the Portal, its source, design, navigation structure, databases and different elements contained in this code are exclusively owned by EPIC ELEVEN, who has the exclusive rights to exploit them in any way desired according to the law, and in particular, by way of example but not limited to, rights of reproduction, copying, distribution, processing, marketing, and public communication. The reproduction, copying, distribution, processing, marketing, and partial or total public communication of the information contained in this website is strictly prohibited without the express written permission of EPIC ELEVEN, and constitutes an infringement of intellectual property rights and industrial.
    </p>
    <h1>
        Forums, Blogs and Images
    </h1>
    <p>
        EPIC ELEVEN gives Users the ability to enter comments and/or submit photographs for inclusion in the appropriate sections. The publication of comments and/or photographs is subject to this Legal Notice. The person identified in each case as the one who has made comments and/or sent photographs, is responsible for them. Comments and / or photographs do not reflect the opinions of EPIC ELEVEN, and EPIC ELEVEN will not made any statement in this regard. EPIC ELEVEN will not be liable, unless those extremes that would force the law, for any errors, inaccuracies or irregularities that may contain the comments and/or photographs, as well as any damages that may result by inserting those comments and/or photos on the Forum or on other sections of the Web that allow this kind of services. The User which supplies texts and/or photographs yields to EPIC ELEVEN his rights to reproduce, use, distribution, public communication in electronic form as part of the activities for this website. And, especially, the User grants such rights to the location of text and / or photos on the Web, so that other users of the website can access them. The supplier User declares to be the owner of the rights to the texts or pictures or, where appropriate, ensures to have the necessary rights and authorizations of the author or owner of the text and/or photographs, for use by EPIC ELEVEN to through the Web. EPIC ELEVEN will not be liable, except in those extremes to which compels the Law, of the damages that could be caused by the use, reproduction, distribution or public communication or any type of activity carried on texts and/or photographs are protected by intellectual property rights belonging to third parties without the User having previously obtained from the owners needed to carry out the use made or intended release. EPIC ELEVEN also reserves the right to withdraw unilaterally comments and/or photographs housed in any other section of the Web, when EPIC ELEVEN deems appropriate. EPIC ELEVEN will not responsible for the information sent by the user when they have actual knowledge that the information stored is unlawful or harms property or rights of a third party liable for compensation. At the moment EPIC ELEVEN realizes that is housing data as referred to above, the User agrees to act expeditiously to remove or block all access to them. In any case, any claim relating to or inserted in forum sections similar content, you can do so by going to the following email address: <a href="mailto:support@epiceleven.com">support@epiceleven.com</a>.
    </p>
    <h1>
        CHANGES TO THE TERMS OF USE
    </h1>
    <p>
        ELEVEN EPIC reserves the right to modify, develop or update at any time and without notice the Terms and Conditions of this Portal. The User will be automatically bound by the conditions of use that are in effect at the time they access the web, so you should periodically read the Terms and Conditions.
    </p>
    <h1>
        LIABILITY REGIME
    </h1>
    <p>
        The use of the website is the sole responsibility of each User, so it will be the User responsibility if any breach or any harm resulting from the use of this page gets into the Portal. EPIC ELEVEN, its partners, collaborators, employees and other representatives or third parties are therefore exempt from any liability that may involve the actions of the User. EPIC ELEVEN puts all its capacity into providing constantly updated information via their website, but that does not guarantee the absence of errors or inaccuracies in any of the contents, even whenever the reasons are not attributable directly to EPIC ELEVEN. Therefore, the User shall be solely liable against any claims or legal proceedings against EPIC ELEVEN based on the use of the website or its contents by the User, provided such use has been made illegally, violating rights of third parties or causing any damage, thereby assuming all costs, expenses or damages that may be incurred in EPIC ELEVEN.
    </p>
    <h1>
        APPLICABLE LAW AND JURISDICTION
    </h1>
    <p>
        This website is governed by Spanish law. EPIC ELEVEN and the user, expressly waiving their own jurisdiction, if they will have it, will submit to the jurisdiction of the courts of the city of Madrid (Spain). This provided this is not an end user, being the forum that the law provides the defendant's domicile.
    </p>
  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/tutorials_comp.html", new HttpResponse(200, r"""<div class="tutorial-row">
  <div class="tutorial-tile">
    <h1 class="tutorial-title">{{getLocalizedText("learn-to-play")}}</h1>
    <!--p class="tutorial-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p-->
    <button type="button" class="button-go-tutorial" ng-click="goTutorial(tutorialIniciacionName)">{{getLocalizedText("go-tutorial")}}</button>
  </div>
  <div class="tutorial-tile">
    <h1 class="tutorial-title">{{getLocalizedText("rankings")}}</h1>
    <!--p class="tutorial-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p-->
    <span class="incoming">{{getLocalizedText("incoming")}}</span>
  </div>
  <div class="tutorial-tile">
    <h1 class="tutorial-title">{{getLocalizedText("how-to-create-contest")}}</h1>
    <!--p class="tutorial-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p-->
    <span class="incoming">{{getLocalizedText("incoming")}}.</span>
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
        </div>
      </div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/teams_panel_comp.html", new HttpResponse(200, r"""<div class="teams-toggler-wrapper">
  <div id="teamsToggler" type="button" class="teams-toggler"  ng-class="{'toggleOff': !isTeamsPanelOpen, 'toggleOn': isTeamsPanelOpen }" ng-click="toggleTeamsPanel()"  data-toggle="collapse" data-target="#teamsPanel">{{buttonText}}</div>
</div>
<div id="teamsPanelRoot" ng-show="isShown" class="animate">

  <div class="teams-comp-bar" >

    <div id="teamsPanel" class="teams-container collapse" ng-class="{'in': isTeamsPanelOpen }">
      <div class="top-border"></div>
      <div class="teams-box" ng-repeat="match in matchEventsSorted">
        <div class="teams-info" ng-bind-html="getMatchAndPeriodInfo($index)"></div>
      </div>
      <div class="bottom-border"></div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/users_list_comp.html", new HttpResponse(200, r"""<div id="usersListRoot" >

  <div ng-class="{'users-header-next': isViewContestEntryMode, 'users-header' : !isViewContestEntryMode, 'invite-friends-wrapper' : showInvite}">
    <h1>{{getLocalizedText("title")}}</h1>
    <h2 ng-if="!isViewContestEntryMode">{{getLocalizedText("desc")}}:</h2>
    <h2 ng-if="showInvite" ng-click="onInviteFriends()" class="invite-friends">{{getLocalizedText("invite_text")}}</h2>
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
      <users-list show-invite="showInviteButton" on-invite-friends="onInviteFriends()" id="usersList" ng-show="selectedOpponent == null" contest-entries="contestEntries" watch="updatedDate"></users-list>
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
    <li class="week-day {{$index==0? 'today':''}} {{isCurrentSelected(day['date'], $index)? 'active':''}}{{(!day['enabled'])? ' disabled':''}}"  
        ng-click="selectDay($event, day)" ng-repeat="day in dayList">
      <div class="day-info">
        <span class="week-day-name">{{getLocalizedText(day["weekday"])}}</span>
        <span class="day-number">   {{day["monthday"]}}</span>
      </div>
    </li>
  </ul>
</div>"""));
}