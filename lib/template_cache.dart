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
              <img class="gold-icon" ng-src="{{item.captionImage}}">
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
              <img ng-src="{{getLocalizedText('mostpopularimagesource')}}" class="gold-item-popular" ng-if="item.isMostPopular">
            </div>            
          </div>
        </div>
    </div>
    
    <div class="energy-layout">
      <div class="energy-tiles-wrapper">
        <div class="tile">
          <div class="energy-items" ng-repeat="energyItem in energyProducts">
            <div class="energy-separator" ng-if="(energyItem.price != null || timeLeft != '') && $index > 0"></div>
            <div ng-class="{'no-purchasable': !energyItem.purchasable}" class="product" ng-if="energyItem.price != null || timeLeft != ''">
              <img class="energy-icon" ng-src="{{energyItem.captionImage}}">
              <div class="energy-description">{{energyItem.description}}</div>
              <div ng-switch="energyItem.purchasable">
                <div class="button-wrapper" ng-switch-when="true">
                  <button class="refill-button" ng-click="buyEnergy(energyItem.id)">
                    <span class="quantity">{{energyItem.price}}</span>
                  </button>
                </div>
                <span ng-switch-when="false" class="product-time-left">{{timeLeft}}</span>
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
    <img src="images/achievements/{{achiev.image}}" ng-if="achiev.image != ''">
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
          <label for="contestPremiere"><span class="icon"></span>{{getLocalizedText("premiere_league")}}</label>
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

  <div id="leaderboard-header-wrapper">

    <h1>{{getLocalizedText("title")}}</h1>
    <!--div class="rankings-wrapper">
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
    </div-->

  </div>

  <div class="clearfix"></div>


  <ul class="leaderboard-tabs" role="tablist">
    <li class="active"><a class="leaderboard-tab top-points-tab" role="tab" data-toggle="tab" ng-click="tabChange('top-points')">{{trueskillTabTitle}}</a></li>
    <li><a class="leaderboard-tab top-money-tab" role="tab" data-toggle="tab" ng-click="tabChange('top-money')">{{goldTabTitle}}</a></li>
    <li><a class="leaderboard-tab achivements-tab" role="tab" data-toggle="tab" ng-click="tabChange('achivements-content')">{{achievementsTabTitle}}</a></li>
  </ul>

  <div class="tabs">
    <div class="tab-content">

      <div class="tab-pane active" id="top-points">

        <leaderboard-table show-header="true" highlight-element="playerPointsInfo" table-elements="pointsUserList" rows="usersToShow" points-column-label="pointsColumnName" hint="playerPointsHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="top-money">

        <leaderboard-table show-header="true" highlight-element="playerMoneyInfo" table-elements="moneyUserList" rows="usersToShow" points-column-label="moneyColumnName" hint="playerMoneyHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="achivements-content">

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
  <div class="default-section-header">HELP</div>

  <!-- Nav tabs -->
  <ul class="help-info-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('how-works-content')">How it works</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('rules-scores-content')">Rules and scoring</a></li>
  </ul>

  <div class="tab-pane active" id="how-works-content">
    <div class="block-light">
      <div class="title">Choose a contest</div>
      <div class="description"><p>In the Lobby you can find several contests in which to participate, either with your friends or with other players.</p>Play as many contests as you like: new contests will be available EVERY week!<br> Use as many different lineups as you want, or keep the same starting 11: it is totally up to you. <br> Daily contests, no season long-term commitment.</div>
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
      <div class="description"><p>Next, choose your lineup. Pick 11 players and remember:</p> You can spend all your salary cap.<br>You can pick up to 4 players from the same team.</div>
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
          <p>It is very easy to play EPIC ELEVEN from any device, any place. You can keep track of your lineup's live stats from your computer, tablet or smartphone, with an optimized interface for each one.</p>
          <!--p>See how easy it is to participate in contests EPIC ELEVEN from wherever you want. You can follow live stats of your players from your computer, tablet or smartphone optimized for all devices,to improve usability.</p-->
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
        <label for="rule1">1. Legals</label>
        <div>
          <p>To play in Epic Eleven you must be at least 18 years older. For further information, please, see our<a ng-click="goTo('terminus_info')">Terms of Use</a>.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule2" class="toggle">
        <label for="rule2">2. Multiple Accounts</label>
        <div>
          <p>Any Player can only own a single user account of Epic Eleven. However, in special cases, Epic Eleven allows the creation of a second account. To do this, you must receive written consent of Epic Eleven before opening a second account, so is Epic Eleven’s final decision to let a User possess two user accounts. If this condition is not met, any penalty that Epic Eleven suits fit will be issued at Epic Eleven’s staff discretion and may involve the closure of all involved user accounts and the retention of cash within, if we determine that has been obtained fraudulently.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule3" class="toggle">

        <label for="rule3">3. Banned accounts</label>
        <div>
          <p>There are certain behaviors that are detrimental to Epic Eleven and the other players. These behaviors may imply the cancellation of some (or all) of the functions associated with a user account. As a result of the foregoing, users whose accounts have been canceled shall respect the disciplinary measures imposed. All communication pertaining to the restoration of a user account must be made through the email account <a href="mailto:support@epiceleven.com">support@epiceleven.com</a>.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule4" class="toggle">
        <label for="rule4">4. Nicknames</label>
        <div>
          <p>Epic Eleven holds the right to request the change of a user name where that is offensive or respond to commercial interests. Only Epic Eleven can determine the reasons for that request. If the User ignores the request, Epic Eleven will alter this username without being obliged to extend any further notice to the User.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule5" class="toggle">
        <label for="rule5">5. Empty contests</label>
        <div>
          <p>All open tournaments that take place in Epic Eleven have a certain prize and a number of specific participants. If at the start of the tournament this number of participants is not reached, it may be canceled. For example, a competition "One on One" without 2 competitors and a league of 10 people with only 9 participants can not be held. In every case, is up to Epic Eleven discretion to cancel a contest.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule6" class="toggle">
        <label for="rule6">6. Cancelled participation</label>
        <div>
          <p>Users can withdraw its participation in any contest by clicking the "Cancel Entry" button at the bottom left of the section in which you can edit your team. Once the tournament has started, the button "Cancel entry" will disappear from that section. Epic Eleven will not consider requests for cancellation of entries in competitions that are completed during the first 15 minutes of the start of the game. Epic Eleven has no obligation to attend requests for cancellation that are not received or that have been received after the deadlines listed above in this section, due to technical difficulties or other reasons. Also, Epic Eleven will not attend requests to cancel registrations in contests "One versus One".</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule7" class="toggle">
        <label for="rule7">7. Postponed games</label>
        <div>
          <p>The rules that specify the treatment of postponed games vary depending on the type of contest. Epic Eleven reserves the right to act in this regard depending on the particular circumstances.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule8" class="toggle">
        <label for="rule8">8. Suspended games</label>
        <div>
          <p>The rules that specify the treatment to suspended matches depend on the type of contest. It is considered that a match has been suspended when it is unfinished, but with prospects for completion in the future. Epic Eleven is committed to, at least, take into account the statistics collected before the end of the contest, for the sake of the game.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule9" class="toggle">
        <label for="rule9">9. Players in negotiation process</label>
        <div>
          <p>Any player involved in team transaction processes might affect current contests, may these players being in a team that is no longer his actual team. Our player lists are updated once a day (at 00:00), so keep in mind that contests might have been created several days before the transfer was made, which results in players being available for their old teams, not for their new teams. Also, in some cases, a player might not be available for a contest since he was transferred to a team that does not fit into that very contest, so unless the player selects an alternate player, the transferred player would be credited with zero points.</p>
          <p>When a transaction is under negotiation the player may still appear in the list of player of his former team. If he plays against his former team, he may still be awarded with points, as he plays in the same game, which usually will be included in the same contests. Points may not be accurately awarded, but will be reflected at the end of the game. Is worth noting that the settlement of the contest may be delayed in order to ensure maximum accuracy.</p>
          <p>In very rare cases, a player is transferred early enough in the day to play a game for his new team the same day. If it is transferred from a team that plays a game later in the evening to a team that will play a game earlier, you might be able to select the player for later game, knowing that the transfer was made de facto before the game. If this is the case, the transferred player would be credited with zero points.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule10" class="toggle">
        <label for="rule10">10. lineup restrictions</label>
        <div>
          <p>Lineup restrictions are limited to one rule: no more than 4 players from the same team. Any attempt to overcome this limitation will find an automatic refusal to proceed by the platform itself.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule11" class="toggle">
        <label for="rule11">11. score revisions</label>
        <div>
          <p>During the game we received the events from our supplier, OPTA. After the game, they provide us with a final document with full match statistics. Once received and confirmed, contests will begin to be settled. However, on rare occasions, our provider might review those documents, which may alter the final box score. If this were to happen, the player's score on Epic Eleven will not be updated. Note that this situation is not the same as a case where a correction must be made after closing due to a problem with the data source or the resolution process.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule12" class="toggle">
        <label for="rule12">12. Access associated issues</label>
        <div>
          <p>Although we do our best to guarantee the correct performance of Epic Eleven at any time, we may experience cuts or slow performance due to unexpected problems that may arise in Epic Eleven or in the support provided by third parties for the Portal. Sometimes, the user may experience problems while accessing the service, editing lineups or entering new contests.</p>
          <p>If you experience any problems accessing the service, please contact us vía <a href="mailto:support@epiceleven.com">support@epiceleven.com</a>. If there were periods during which users were unable to access our services, to edit lineups or to perform any action, Epic Eleven will provide instructions to cancel any contest by email before the game starts.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule13" class="toggle">
        <label for="rule13">13. Contest cancellation</label>
        <div>
          <p>Epic Eleven holds the right to cancel contests at discretion, without any restrictions. Usually this might be done in extreme situations, where an event might affect several contests in a negative way or even the real competitions, which in the end would affect Epic Eleven.</p>
        </div>
      </div>
    </div>
  </div>

</div>
"""));
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