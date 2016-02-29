// GENERATED, DO NOT EDIT!
library template_cache;

import 'package:angular/angular.dart';

primeTemplateCache(TemplateCache tc) {
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
          <input id="txtName" type="text" maxlength="{{MAX_NAME_LENGTH}}" ng-model="editedFirstName" placeholder="{{getLocalizedText('name')}}" class="form-control"  tabindex="1">
        </div>
      </div>
      <!-- Apellidos -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("lastname")}}</span></div>
        <div class="control-wrapper">
          <input id="txtLastName" type="text" maxlength="{{MAX_SURNAME_LENGTH}}"ng-model="editedLastName" placeholder="{{getLocalizedText('lastname')}}" class="form-control" tabindex="2">
        </div>
      </div>
      <!-- Nickname -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("username")}}</span></div>
        <div class="control-wrapper">
          <input id="txtNickName" type="text" maxlength="{{MAX_NICKNAME_LENGTH}}" ng-model="editedNickName" placeholder="{{getLocalizedText('username')}}" class="form-control" tabindex="3" autocapitalize="off">
        </div>
        <!-- Error de nickName -->
        <div id="nickNameErrorContainer" class="content-field-block errorDetected" ng-if="nicknameErrorText != ''">
          <div id="nickNameErrorLabel" class="err-text">{{nicknameErrorText}}</div>
        </div>
      </div>

      <!-- Correo Electrónico -->
      <div class="content-field">
        <div class="control-wrapper-bottom-space"><span id="lblPassword" class="text-label">{{getLocalizedText("mail")}}</span></div>
        <div class="control-wrapper">
          <input id="txtEmail" type="email" ng-model="editedEmail" placeholder="{{getLocalizedText('mail')}}" class="form-control" tabindex="4" autocapitalize="off">
        </div>
        <!-- Error de mail -->
        <div id="emailErrorContainer" class="content-field-block errorDetected" ng-if="emailErrorText != ''">
          <div id="emailErrorLabel" class="err-text">{{emailErrorText}}</div>
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
      <div id="passwordErrorContainer" class="content-field-block errorDetected" ng-if="passwordErrorText != ''">
        <div id="passwordErrorLabel" class="err-text">{{passwordErrorText}}</div>
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
    <!--div class="header">{{getLocalizedText("notifications")}}</div>
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

    </div-->

    <div class="save-changes-content">
      <div class="forms-wrapper-button">
        <button id="btnSubmit" class="action-button-save" ng-disabled="!canSave" type="submit">{{getLocalizedText("buttonsave")}}</button>
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

        <!-- Facebook stuff-->
        <div  class="user-form-field facebook-form-wrapper">
          <div class="form-description" ng-bind-html="getLocalizedText('facebookdescription')"></div>
          <div class="fb-button-wrapper">
            <div class="fb-login-button" data-size="xlarge" data-max-rows="1" 
                 data-scope="public_profile,email,user_friends"
                 data-show-faces="true" onlogin="jsLoginFB()" ng-show="!isFacebookConnected"></div>
            <div class="fb-login-button" data-size="xlarge"
                 data-scope="public_profile,email,user_friends"
                 onlogin="jsLoginFB()" ng-show="isFacebookConnected"></div>
          </div>
        </div>
        <!-- -->

        <form id="signupForm" class="form-horizontal" ng-submit="onAction('SUBMIT')" role="form" formAutofillFix>
          <div class="form-description" ng-bind-html="getLocalizedText('clasicsignupdescription')"></div>
          
          <!-- NICKNAME  -->
          <div class="user-form-field" id="mailAndNameFieldsWrapper">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText('nickrequires')}}</div>
            </div>
            <!-- Field Input -->
            <div id="nickNameInputGroup" class="form-group">
              <input id="nickName" name="NickName" type="text" ng-model="theNickName" placeholder="{{getLocalizedText('nick')}}" class="form-control" maxlength="{{MAX_NICKNAME_LENGTH}}" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="nickNameError" class="join-err-text">{{getLocalizedText("invalidnick")}}</div>
            </div>

          <!-- EMAIL -->
            <!-- Field Input -->
            <div id="emailInputGroup" class="form-group">
              <input id="email" name="Email" type="email" ng-model="theEmail" placeholder="{{getLocalizedText('email')}}" class="form-control" tabindex="2" autocapitalize="off">
            </div>
            <!-- Error label -->
            <div class="new-row">
              <div id="emailError" class="join-err-text">{{getLocalizedText("invalidemail")}}</div>
            </div>
          </div>

          <!-- PASSWORD -->
          <div  class="user-form-field" id="passAndRepassFieldsWrapper">
            <!-- Description -->
            <div class="new-row bottom-separation-10">
              <div class="small-text">{{getLocalizedText("passrequires")}}</div>
            </div>
            <!-- Field Input 1 -->
            <div id="passwordInputGroup" class="form-group  bottom-separation-10">
              <input id="password" name="Password" type="password" ng-model="thePassword" placeholder="{{getLocalizedText('pass')}}" class="form-control" data-minlength="MIN_PASSWORD_LENGTH" ng-minlength="MIN_PASSWORD_LENGTH"  tabindex="3" autocapitalize="off">
            </div>
            <!-- Field Input 2 -->
            <div id="rePasswordInputGroup" class="form-group">
              <input id="rePassword" name="RePassword" type="password" ng-model="theRePassword" placeholder="{{getLocalizedText('repass')}}" class="form-control" tabindex="4" autocapitalize="off">
            </div>
            <!-- Error de password -->
            <div class="new-row">
              <div id="passwordError" class="join-err-text">{{getLocalizedText("invalidpass")}}</div>
            </div>
            <div class="acceptTermsAndConditionsWrapper">
              <!--input id="acceptTermsAndConditions" name="acceptTermsAndConditions" type="checkbox" ng-model="theAcceptTnC" tabindex="5"-->
              <span class="termsAndConditionsText" ng-bind-html-unsafe="getLocalizedText('acceptTermsAndPrivacyPolicy')"></span>
            </div>
          </div>
            
          <!-- GOTO LOGIN -->
          <div class="user-form-field">
            <div class="small-text">{{getLocalizedText("registered")}} <span class="link-aspect" id="gotoLoginLink" ng-click="onAction('LOGIN', $event)"> {{getLocalizedText("loginhere")}}</span></div>
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

        </form>
      </div>
    </div>
  </div>
</div>
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

        <!--Facebook stuff-->
        <div  class="user-form-field facebook-form-wrapper">
          <div class="form-description">{{GetLocalizedText('enterwithfacebook')}}</div>
          <div class="fb-button-wrapper">
            <div class="fb-login-button" data-size="xlarge" onlogin="jsLoginFB()"
                 data-scope="public_profile,email,user_friends"
                 ng-show="isFacebookConnected"></div>
            <div class="fb-login-button" data-size="xlarge" onlogin="jsLoginFB()"
                 data-scope="public_profile,email,user_friends"
                 data-show-faces="true" data-max-rows="1" ng-show="!isFacebookConnected"></div>
          </div>
        </div>
        <!-- -->
          
        <form id="loginForm" class="form-horizontal" ng-submit="onAction('SUBMIT')" role="form" formAutofillFix>
          <div class="form-description">{{GetLocalizedText('mailandpassword')}}</div>

          <!-- LOGIN FIELDS -->
          <div class="user-form-field" id="mailAndPassFieldsWrapper">
            <!-- MAIL -->
            <div class="form-group">
              <input id="login-mail" type="email" name="Email" placeholder="{{GetLocalizedText('email')}}" class="form-control" tabindex="1" autocapitalize="off" auto-focus>
            </div>
            <!-- PÂSSWORD -->
            <div class="form-group">
              <input id="login-password" type="password" name="password" placeholder="{{GetLocalizedText('pass')}}" class="form-control" tabindex="2" autocapitalize="off">
            </div>
            <!-- Error de login/pass -->
            <div id="loginErrorSection" class="new-row">
              <div id="loginErrorLabel" class="login-err-text">{{GetLocalizedText('loginerror')}}</div>
            </div>
          </div>

          <!-- REMEMBER PASS -->
          <div class="user-form-field-righted">
            <span id="rememberPasswordLink" class="link-aspect small-link-righted" ng-click="onAction('REMEMBER_PASSWORD', $event)">{{GetLocalizedText('forgotpass')}}</span>
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
              <div class="small-text">{{GetLocalizedText('unregistered')}} <span class="link-aspect" id="gotoRegisterLink" ng-click="onAction('JOIN', $event)"> {{GetLocalizedText('signuphere')}} </span></div>
            </div>
          </div>


        </form>
      </div>
    </div>
  </div>
</div>"""));
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
      <div ng-class="{'clearfix': notification.type == 'ACHIEVEMENT_EARNED'}"></div>
      <!--social-share parameters-by-map="sharingInfo(notification)" show-like="false" inline ng-show="shareEnabled(notification)"></social-share-->
      
      <div class="additional-info">
        <div class="wrapper">
          <div class="description">{{notification.description}}</div>
          <div class="button-wrapper" ng-show="notification.link.name != '' || shareEnabled(notification)">
            <button class="btn-primary" ng-if="notification.link.name != ''" ng-click="goToLink(notification.link.url)">{{notification.link.name}}</button>
            <social-share parameters-by-map="sharingInfo(notification)" show-like="false" inline ng-if="shareEnabled(notification)"></social-share>
          </div>
        </div>
      </div>

      <span class="close-button" ng-click="closeNotification(notification.id)"></span>

    </div>
    
    <div class="notification-list-empty" ng-if="notificationList.length == 0">
      {{getLocalizedText('notification-list-empty')}}
    </div>

  </div>

</div>"""));
tc.put("packages/webclient/components/account/payment_response_comp.html", new HttpResponse(200, r"""<modal window-size="'md'">
  <div id="paymentResponse" class="main-box air">
    <div class="panel">

      <div class="panel-heading">
        <div class="panel-title paypal-success">{{titleText}}</div>
        <!--div class="panel-title paypal-cancel" login="">Pago cancelado</div-->
        <button type="button" class="close">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>
      <div class="panel-body">
        <p>{{descriptionText}}</p>
      </div>
    </div>
  </div>
  <!--h1>Payment Response: {{result}}</h1-->
</modal>
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
          <div class="form-description">{{getLocalizedText("confirm_part_1")}}<br><br><p class="email-detail">'{{email}}'</p>{{getLocalizedText("confirm_part_2")}}</div>
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
            <div class="small-text">{{getLocalizedText("unregistered")}}<span class="link-aspect" id="gotoRegisterLink" ng-click="navigateTo('join', {}, $event)"> {{getLocalizedText("signuphere")}} </span></div>
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
                <!--div class="free-increment" ng-if="item.freeIncrement > 0">
                  <span class="free-increment-count">{{item.freeIncrement}}</span>
                  <span class="free-increment-desc">{{getLocalizedText('free')}}</span>
                </div-->
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
          <div class="energy-item">
            <!--div class="energy-separator" ng-if="$index > 0"></div-->
            
            <div class="item-title">
              <span>RECARGA</span>
              <div><img class="energy-icon" src="images/icon-FullEnergy.png"></div>
              <span>ENERGÍA</span>
            </div>
            
            <div class="product" ng-repeat="energyItem in energyProducts">
              <div class="energy-description">{{energyItem.description}}</div>
              <img class="product-image" ng-src="{{energyItem.captionImage}}">
              <div ng-switch="energyItem.purchasable">
                <div class="button-wrapper" ng-switch-when="true">
                  <button class="refill-button" ng-class="{'disabled': !canBuyEnergy}" ng-click="buyEnergy(energyItem.id)">
                    <span class="quantity">{{energyItem.price}}</span>
                  </button>
                </div>
              </div>
            </div>
            
          </div>
          
          <!--div class="energy-refill-counter">
            <div class="product">
              <img class="energy-icon" src="images/iconEnergyLevelUp.png">
              <div class="energy-description">{{timeLeft != '' ? getLocalizedText("refillable") :  getLocalizedText("no-refillable")}}</div>
              <div>
                <div class="button-wrapper">
                  <span  class="product-time-left" ng-if="timeLeft != ''">{{timeLeft}}</span>
                </div>
              </div>
            </div>
          </div-->
        </div>
      </div>
    </div>
  </div>
</div> 

<ng-view></ng-view>"""));
tc.put("packages/webclient/components/account/user_profile_comp.html", new HttpResponse(200, r"""<div id="viewProfileContent">
  <div class="default-section-header">{{getLocalizedText('title')}}</div>
  <div class="profile-content">

    <div class="personal-data profile-section">
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
tc.put("packages/webclient/components/achievement_comp.html", new HttpResponse(200, r"""<div ng-bind-html="theHtml"></div>"""));
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

    <div class="player-position" ng-if="viewLive || viewHistory">
      <div class="condition-name"><span>{{getLocalizedText("position")}}</span></div>
      <div class="condition-amount"><span class="current-position">{{printableMyPosition()}}</span>/{{contest.numEntries}}</div>
    </div>

    <div class="entry-fee-box" ng-if="!(viewLive || viewHistory)">
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
  <social-share ng-if="userIsRegistered()" parameters-by-map="sharingInfo" inline></social-share>

  <div class="tournament-and-type-section">
    <span class="{{getSourceFlag()}}"></span>
    <span class="contest-type {{getContestTypeIcon()}}"></span>
    <div class="created-by-user" ng-if="isCustomContest(contest)"><img ng-src="{{authorImage()}}"></img></div>
  </div>

  <div class="close-contest" ng-switch="isInsideModal">
    <button type="button" ng-switch-when="true"  class="close" data-dismiss="modal">   <span class="glyphicon glyphicon-remove"></span></button>
    <button type="button" ng-switch-when="false" class="close" ng-click="goToParent()"><span class="glyphicon glyphicon-remove"></span></button>
  </div>

</div>


<teams-panel id="teamsPanelComp" contest="contest" contest-id="contest.contestId"  selected-option="matchFilter" as-filter="showFilter" ng-if="showMatches"></teams-panel>


<div class="clearfix"></div>
"""));
tc.put("packages/webclient/components/contest_info_comp.html", new HttpResponse(200, r"""<modal id="contestInfoModal" ng-if="isModal">

  <contest-header-f2p id="contestInfoHeader" contest="contest" contest-id="contestId"  modal="true" show-matches="false"></contest-header-f2p>

  <div class="modal-info-content">

      <div class="tabs-background">
        <!-- Nav tabs -->
        <div class="tabs-navigation">
          <ul class="contest-info-tabs " id="modalInfoContestTabs">
              <li class="tab active"><tab data-toggle="tab" ng-click="tabChange('matches')">{{getLocalizedText("matches")}}</tab></li>
              <li class="tab"><tab data-toggle="tab" ng-click="tabChange('prizes')">{{getLocalizedText("prizes")}}</tab></li>
              <li class="tab"><tab data-toggle="tab" ng-click="tabChange('contestants')">{{getLocalizedText("contenders")}}</tab></li>
              <!--li class="tab"><tab data-toggle="tab" ng-click="tabChange('scoring')">{{getLocalizedText("scoringrules")}}</a></li-->
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
    <div class="contestSlot" ng-class="{'special' : getContestMorfology(contest) == 'special', 'real': getContestTypeIcon(contest) == 'real', 'virtual': getContestTypeIcon(contest) != 'real'}" ng-click="onRow(contest)">

      <div class="special-image-section" ng-if="getContestMorfology(contest) == 'special'">
        <img ng-src="{{getContestImage(contest)}}"></img>
      </div>

      <div class="time-section">
        <div class="fake-time-column"></div>
        <div class="column-start-time">
          <div class="column-start-hour" ng-class="{'start-soon' : isSoon(contest.startDate)}" ng-bind-html="timeInfo(contest.startDate, !contest.isHistory)"></div>
          <div class="column-start-date" ng-if="showDate && !isSoon(contest.startDate)" ng-bind-html="dateInfo(contest.startDate, !contest.isHistory)"></div>
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
        <img class="ticket" ng-src="images/arrowBlack.png">
        <!--div class="button-wrapper" ng-if="contest.isLive">
          <button type="button" class="action-button" ng-click="onAction(contest, $event)">{{actionButtonTitle}}</button>
        </div-->
      </div>

      <div class="tournament-and-type-section">
        <div class="{{getSourceFlag(contest)}}"></div>
        <div class="contest-type {{getContestTypeIcon(contest)}}"></div>
        <div class="created-by-user" ng-if="isCustomContest(contest)"><img ng-src="{{authorImage()}}"></img></div>
        <div class="friends-in" ng-if="friendsCount(contest) > 0"><span class="count">{{friendsCount(contest)}}</span></div>
      </div>
      
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/create_contest_comp.html", new HttpResponse(200, r"""<div id="createContest">

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText('create_contest')}}</div>

  <div class="create-contest-section-wrapper name-section">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("name")}}</div>
      <div class="data-input-wrapper contest-name">
        <input id="contestNameInput" type="text" ng-model="contestName" tabindex="1"
               placeholder="{{placeholderName}}" maxlength="{{MAX_LENGTH_CONTEST_NAME}}"
               class="form-control ng-binding ng-pristine ng-touched">
        <span class="contest-name-length">{{MAX_LENGTH_CONTEST_NAME - contestName.length}}</span>
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("contest_type")}}</div>
      <div class="data-input-wrapper contest-type">
        <span class="data-element">
          <input id="contestOficial" type="radio" value="oficial" name="contestType" 
                 ng-value="TYPE_OFICIAL" ng-model="contestType"
                 ng-class="{'disabled-radio': templatesPerTypeList[TYPE_OFICIAL].isEmpty }"
                 ng-disabled="templatesPerTypeList[TYPE_OFICIAL].isEmpty">
          <label for="contestOficial"><span class="icon"></span>{{getLocalizedText("oficial")}}</label>
        </span>
        <span class="data-element">
          <input id="contestTraining" type="radio" value="training" name="contestType"
                 ng-value="TYPE_TRAINING" ng-model="contestType"
                 ng-class="{'disabled-radio': templatesPerTypeList[TYPE_TRAINING].isEmpty }"
                 ng-disabled="templatesPerTypeList[TYPE_TRAINING].isEmpty">
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
                 ng-value="LEAGUE_ES" ng-model="selectedCompetition"
                 ng-class="{'disabled-radio': templatesPerCompetitionList[LEAGUE_ES].isEmpty }"
                 ng-disabled="templatesPerCompetitionList[LEAGUE_ES].isEmpty">
          <label for="contestLeague"><span class="icon"></span>{{getLocalizedText("spanish_league")}}</label>
        </span>
        <span class="data-element">
          <input id="contestPremiere" type="radio" value="LEAGUE_UK" name="competition"
                 ng-class="{'disabled-radio': templatesPerCompetitionList[LEAGUE_UK].isEmpty }"
                 ng-value="LEAGUE_UK" ng-model="selectedCompetition"
                 ng-disabled="templatesPerCompetitionList[LEAGUE_UK].isEmpty">
          <label for="contestPremiere"><span class="icon"></span>{{getLocalizedText("premier_league")}}</label>
        </span>
      </div>
    </div>
  </div>

  <div class="create-contest-section-wrapper">
    <div class="create-contest-section">
      <div class="title">{{getLocalizedText("rivals")}}</div>
      <div class="data-input-wrapper contest-style">
        <span class="data-element">
          <input id="contestHeadToHead" type="radio" value="headToHead" name="contestStyle"
                 ng-value="STYLE_HEAD_TO_HEAD" ng-model="contestStyle"
                 ng-class="{'disabled-radio': templatesPerStyle[STYLE_HEAD_TO_HEAD].isEmpty }"
                 ng-disabled="templatesPerStyle[STYLE_HEAD_TO_HEAD].isEmpty">
          <label for="contestHeadToHead"><span class="icon"></span>{{getLocalizedText("head_to_head")}}</label>
        </span>
        <span class="data-element">
          <input id="contestOpen" type="radio" value="league" name="contestStyle"
                 ng-value="STYLE_LEAGUE" ng-model="contestStyle"
                 ng-class="{'disabled-radio': templatesPerStyle[STYLE_LEAGUE].isEmpty }"
                 ng-disabled="templatesPerStyle[STYLE_LEAGUE].isEmpty">
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
  
  <div class="create-contest-section-wrapper event-section">
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

  <div class="create-contest-section-wrapper date-section">
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

  <teams-panel id="teamsPanelComp" panel-open="true" template-contest="selectedTemplate" button-text="getLocalizedText('matches_title')"></teams-panel>
  
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

  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId" view-state="ACTIVE" show-matches="false"></contest-header-f2p>

  <friends-bar user-list="filteredFriendList" show-challenge="false"></friends-bar>

  <!-- Nav tabs -->
  <ul class="enter-contest-tabs" role="tablist">
    <li class="active"><tab role="tab" data-toggle="tab" ng-click="tabChange('lineup-tab-content')">{{getLocalizedText("tablineup")}}</tab></li>
    <li><tab role="tab" data-toggle="tab" ng-click="tabChange('contest-info-tab-content')">{{getLocalizedText("tabcontestinfo")}}</tab></li>
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
                                 contest="contest"
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

                <soccer-players-filter name-filter="nameFilter" field-pos-filter="fieldPosFilter" position-filters-enabled="scrDet.isNotXsScreen" 
                                       only-favorites="onlyFavorites" show-on-xs="true" show-favorites-button="userIsLoggedIn"></soccer-players-filter>

                <soccer-players-list soccer-players="allSoccerPlayers"
                                     lineup-filter="lineupSlots"
                                     manager-level="playerManagerLevel"
                                     contest="contest"
                                     favorites-list="favoritesPlayers" only-favorites="onlyFavorites"
                                     field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                                     on-row-click="onRowClick(soccerPlayerId)"
                                     on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-list>
              </div>
            </div>

            <div class="enter-contest-actions-wrapper conclude-actions-wrapper">
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

  <div class="lineup-selector-slot" ng-repeat="slot in lineupSlots" ng-mousedown="onLineupSlotSelected({'slotIndex': $index})" ng-class="getSlotClassColor($index)">

    <div ng-if="slot == null">
      <div class="column-fieldpos"></div>
      <div class="column-empty-slot">{{getSlotDescription($index)}}</div>
      <div class="column-action"><action class="iconButtonSelect"><span class="glyphicon glyphicon-chevron-right"></span></action></div>
    </div>

    <div ng-if="slot != null">
      <!--div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div-->
      <div class="column-primary-info">
        <span class="soccer-player-name">{{slot.fullName}}</span>
        <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
      </div>
      <div class="column-salary">${{getPrintableSalary(slot.salary)}}</div>
      <div class="column-gold-cost" ng-bind-html="getPrintableGoldCost(slot)"></div>
      <div class="column-action"><action class="iconButtonRemove"><span class="glyphicon glyphicon-remove"></span></action></div>
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
      <button class="btn btn-default button-filter-team" ng-bind-html="match.texto" id="match-{{match.id}}"
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
        <li id="seasonTab" class="active"><tab role="tab" data-toggle="tab" ng-click="tabChange('season-stats-tab-content')">{{getLocalizedText("seasondata")}}</tab></li>
        <li id="matchTab" ><tab role="tab" data-toggle="tab" ng-click="tabChange('match-by-match-stats-tab-content')">{{getLocalizedText("matchbymatch")}}</tab></li>
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
tc.put("packages/webclient/components/enter_contest/soccer_players_filter_comp.html", new HttpResponse(200, r"""<div class="soccer-players-filter" ng-class="{'position-filters-enabled': positionFiltersEnabled}">

  <div class="filter-by-position" ng-class="{'position-filters-enabled': positionFiltersEnabled}" ng-if="showFilterByPosition">
    <span ng-if="showTitle">{{getLocalizedText("players", group: "soccerplayerlist")}}</span>
    <button class="button-filter-position" ng-click="fieldPosFilter = fieldPos"
            ng-repeat="fieldPos in posFilterList" ng-bind-html="getTextForFieldPos(fieldPos)" 
            ng-class="{'active': isActiveFieldPos(fieldPos), 'all': fieldPos == null}"
            ng-show="positionFiltersEnabled"></button>
    <button class="button-filter-favorites" ng-click="switchFavorites()" ng-if="showFavorites"
            ng-class="{'active': onlyFavorites}"></button>
  </div>

  <input type="text" class="name-player-input-filter" ng-model="nameFilter" 
          placeholder="{{getLocalizedText('search-player', group: 'soccerplayerlist')}}"/>
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

  <div class="default-section-header">
    <div class="header-title">{{getLocalizedText('title')}}</div>
    <friend-info class="visited-user" user="userShown" max-width="290" show-challenge="false" show-manager-level="false" ng-if="!isLoggedPlayer" id-error="userShown != null && userId != userShown.userId"></friend-info>
    <!--div class="visited-user">{{visitedName}} <img ng-src="{{visitedPhoto}}"></img></div-->
  </div>

  <ul id="#leaderboardTabs" class="leaderboard-tabs" role="tablist">
    <li id="points-tab" class="active"><tab class="leaderboard-tab top-points-tab"   role="tab" data-toggle="tab" ng-click="gotoSection('points')">{{trueskillTabTitle}}</tab></li>
    <li id="money-tab">                <tab class="leaderboard-tab top-money-tab"    role="tab" data-toggle="tab" ng-click="gotoSection('money')">{{goldTabTitle}}</tab></li>
    <li id="achievements-tab">         <tab class="leaderboard-tab achievements-tab" role="tab" data-toggle="tab" ng-click="gotoSection('achievements')">{{achievementsTabTitle}}</tab></li>
  </ul>

  <div class="tabs">
    <div class="tab-content">

      <div class="tab-pane active" id="points-content">

        <leaderboard-table share-info="sharingInfoTrueSkill" show-header="true" highlight-element="playerPointsInfo" table-elements="pointsUserList" rows="USERS_TO_SHOW" points-column-label="pointsColumnName" hint="playerPointsHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="money-content">

        <leaderboard-table share-info="sharingInfoGold" show-header="true" highlight-element="playerMoneyInfo" table-elements="moneyUserList" rows="USERS_TO_SHOW" points-column-label="moneyColumnName" hint="playerMoneyHint" ng-show="!loadingService.isLoading"></leaderboard-table>

      </div>

      <div class="tab-pane" id="achievements-content">

        <achievement-list ng-show="!loadingService.isLoading" user="userShown"></achievement-list>

      </div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/leaderboard_table_comp.html", new HttpResponse(200, r"""<div class="leaderboard-table">
  <div class="leaderboard-table-header" ng-show="isHeaded">
    <div class="leaderboard-table-element">
      <span class="leaderboard-column leaderboard-table-position">{{getLocalizedText("abrevposition")}}</span>
      <div class="leaderboard-name-hint-wrapper">
        <span class="leaderboard-column leaderboard-table-name">{{getLocalizedText("name")}}</span>
        <span class="leaderboard-column leaderboard-table-hint empty"> </span>
      </div>
      <span class="leaderboard-column leaderboard-table-skillpoints">{{pointsColumnName}}</span>
    </div>
  </div>
  <div class="leaderboard-table-data">
    <div class="leaderboard-table-element {{isThePlayer(element['id'])? 'player-position' : ''}}" ng-repeat="element in shownElements">
      <span class="leaderboard-column leaderboard-table-position">{{element['position']}} </span>
      <div class="leaderboard-name-hint-wrapper">
        <span class="leaderboard-column leaderboard-table-name">{{element['name']}} </span>
        <span class="leaderboard-column leaderboard-table-hint" ng-class="{'empty': !isThePlayer(element['id'])}">
          <social-share parameters-by-map="sharingInfo" show-like="false" inline ng-if="isThePlayer(element['id']) && sharingInfo != null"></social-share>
        </span>
      </div>
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
<ng-view></ng-view>
"""));
tc.put("packages/webclient/components/legalese_and_help/how_it_works_comp.html", new HttpResponse(200, r"""<div id="helpInfo">
  <div class="block-light" id="help-info-1">
    <div class="title" ng-bind-html="getLocalizedText('point1title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point1content')"></div>
    <div class="img-wrapper">
      <img src="images/help/help01-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help/help01.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-dark" id="help-info-2">
    <div class="title" ng-bind-html="getLocalizedText('point2title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point2content')"></div>
    <div class="img-wrapper">
      <img src="images/help/help03-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help/help03.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-light" id="help-info-3">
    <div class="title" ng-bind-html="getLocalizedText('point3title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point3content')"></div>
    <div class="img-wrapper">
      <img src="images/help/help04-xs.jpg" ng-if="scrDet.isXsScreen">
      <img src="images/help/help04.png" ng-if="!scrDet.isXsScreen">
    </div>
    <div class="description" ng-bind-html="getLocalizedText('point3content2')"></div>
  </div>
  
  <!-- div class="block-light" id="help-info-4">
    <div class="title" ng-bind-html="getLocalizedText('point4title')"></div>
    <div class="block-last">
      <div class="img-wrapper-left">
        <img src="images/help/help06.jpg">
      </div>
      <div class="description-right">
        <p ng-bind-html="getLocalizedText('point4description')"></p>
        <button type="button" class="button-play" ng-click="goTo('lobby')">{{getLocalizedText("button-play")}}</button>
      </div>
    </div>
  </div-->
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/how_to_create_contest_comp.html", new HttpResponse(200, r"""<div id="helpInfo">
  <div class="block-light" id="help-info-1">
    <div class="title" ng-bind-html="getLocalizedText('point1title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point1content')"></div>
    <div class="img-wrapper">
      <img src="images/help/helpCrearTorneos1XS.png" ng-if="scrDet.isXsScreen">
      <img src="images/help/helpCrearTorneos1.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-dark" id="help-info-2">
    <div class="title" ng-bind-html="getLocalizedText('point2title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point2content')"></div>
    <div class="img-wrapper">
      <img src="images/help/helpCrearTorneos2XS.png" ng-if="scrDet.isXsScreen">
      <img src="images/help/helpCrearTorneos2.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
  <div class="block-light" id="help-info-3">
    <div class="title" ng-bind-html="getLocalizedText('point3title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point3content')"></div>
    <div class="img-wrapper">
      <img src="images/help/helpCrearTorneos3XS.png" ng-if="scrDet.isXsScreen">
      <img src="images/help/helpCrearTorneos3.png" ng-if="!scrDet.isXsScreen">
    </div>
  </div>
  
   <div class="block-dark" id="help-info-4">
    <div class="title" ng-bind-html="getLocalizedText('point4title')"></div>
    <div class="description" ng-bind-html="getLocalizedText('point4content')"></div>
    <div class="img-wrapper">
      <img src="images/help/helpCrearTorneos4XS.png" ng-if="scrDet.isXsScreen">
      <img src="images/help/helpCrearTorneos4.png" ng-if="!scrDet.isXsScreen">
    </div>
    <div class="button-wrapper">
      <button type="button" class="button-back" ng-click="goToPage('help_info')">{{getLocalizedText("button-back")}}</button>
    </div>
  </div>
  
  
  
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/legal_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">
  <!-- header title -->
  <div class="default-section-header">LEGALS</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
  
    <h1>{{getLocalizedText('point-1-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-1-content')"></div>
    
    <h1>{{getLocalizedText('point-2-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-2-content')"></div>
    
    <h1>{{getLocalizedText('point-3-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-3-content')"></div>
    
    <h1>{{getLocalizedText('point-4-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-4-content')"></div>
    
    <h1>{{getLocalizedText('point-5-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-5-content')"></div>
    
    <h1>{{getLocalizedText('point-6-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-6-content')"></div>
    
    <h1>{{getLocalizedText('point-7-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-7-content')"></div>
    
    <h1>{{getLocalizedText('point-8-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-8-content')"></div>
    
    <h1>{{getLocalizedText('point-9-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-9-content')"></div>
    
    <h1>{{getLocalizedText('point-10-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-10-content')"></div>
    
  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/policy_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText('title')}}</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
  
    <h1>{{getLocalizedText('point-0-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-0-content')"></div>
      
    <h1>{{getLocalizedText('point-1-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-1-content')"></div>
    
    <h1>{{getLocalizedText('point-2-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-2-content')"></div>
    
    <h1>{{getLocalizedText('point-3-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-3-content')"></div>
    
    <h1>{{getLocalizedText('point-4-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-4-content')"></div>
    
    <h1>{{getLocalizedText('point-5-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-5-content')"></div>
    
    <h1>{{getLocalizedText('point-6-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-6-content')"></div>
    
    <h1>{{getLocalizedText('point-7-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-7-content')"></div>
      
    <h1>{{getLocalizedText('point-8-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-8-content')"></div>
      
    <h1>{{getLocalizedText('point-9-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-9-content')"></div>
      
    <h1>{{getLocalizedText('point-10-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-10-content')"></div>
      
    <h1>{{getLocalizedText('point-11-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-11-content')"></div> 
      
    <h1>{{getLocalizedText('point-12-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-12-content')"></div> 
      
    <h1>{{getLocalizedText('point-13-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-13-content')"></div>  
      
    <h1>{{getLocalizedText('point-14-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-14-content')"></div> 
      
    <h1>{{getLocalizedText('point-15-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-15-content')"></div> 
      
    <h1>{{getLocalizedText('point-16-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-16-content')"></div> 
      
    <h1>{{getLocalizedText('point-17-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-17-content')"></div> 
      
    <h1>{{getLocalizedText('point-18-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-18-content')"></div> 
      
    <h1>{{getLocalizedText('point-19-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-19-content')"></div> 
      
    <h1>{{getLocalizedText('point-20-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-20-content')"></div>  
      
    <h1>{{getLocalizedText('point-21-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-21-content')"></div>  
      
    <h1>{{getLocalizedText('point-22-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-22-content')"></div>  
      
    <h1>{{getLocalizedText('point-23-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-23-content')"></div>  
    
  </div>

</div>

"""));
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
  <div class="default-section-header">TÉRMINOS DE USO</div>
  <div class="blue-separator"></div>

  <div class="info-wrapper">
      
    <h1>{{getLocalizedText('point-0-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-0-content')"></div>
    
    <h1>{{getLocalizedText('point-1-title')}}</h1>
    <h2>{{getLocalizedText('point-1-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-1-content')"></div>
        
    <h1>{{getLocalizedText('point-2-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-2-content')"></div>
    
    <h2>{{getLocalizedText('point-3-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-3-content')"></div>
    
    <h1>{{getLocalizedText('point-4-title')}}</h1>
    <h2>{{getLocalizedText('point-4-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-4-content')"></div>
            
    <h2>{{getLocalizedText('point-5-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-5-content')"></div>
      
    <h2>{{getLocalizedText('point-6-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-6-content')"></div>
           
    <h2>{{getLocalizedText('point-7-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-7-content')"></div>  
         
    <h1>{{getLocalizedText('point-8-title')}}</h1>
    <h2>{{getLocalizedText('point-8-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-8-content')"></div> 
          
    <h2>{{getLocalizedText('point-9-subtitle')}}</h2>
    <h3>{{getLocalizedText('point-9-3title')}}</h3>
    <div ng-bind-html-unsafe="getLocalizedText('point-9-content')"></div> 
        
    <h3>{{getLocalizedText('point-10-3title')}}</h3>
    <div ng-bind-html-unsafe="getLocalizedText('point-10-content')"></div>  
           
    <h2>{{getLocalizedText('point-11-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-11-content')"></div>   
      
    <h2>{{getLocalizedText('point-12-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-12-content')"></div>   
     
    <h1>{{getLocalizedText('point-13-title')}}</h1>
    <h2>{{getLocalizedText('point-13-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-13-content')"></div>  
      
    <h2>{{getLocalizedText('point-14-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-14-content')"></div>    
    
    <h1>{{getLocalizedText('point-15-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-15-content')"></div>  
      
    <h1>{{getLocalizedText('point-15b-title')}}</h1>
    <h2>{{getLocalizedText('point-15b-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-15b-content')"></div>
      
    <h2>{{getLocalizedText('point-15c-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-15c-content')"></div>
      
    <h2>{{getLocalizedText('point-15d-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-15d-content')"></div>
      
    <h2>{{getLocalizedText('point-15e-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-15e-content')"></div>
        
    <h1>{{getLocalizedText('point-16-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-16-content')"></div>  
  
    <h1>{{getLocalizedText('point-17-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-17-content')"></div>  
        
    <h1>{{getLocalizedText('point-18-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-18-content')"></div>   
  
    <h1>{{getLocalizedText('point-19-title')}}</h1>
    <div ng-bind-html-unsafe="getLocalizedText('point-19-content')"></div>   
    
    <h1>{{getLocalizedText('point-20-title')}}</h1>
    <h2>{{getLocalizedText('point-20-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-20-content')"></div>  
      
    <h2>{{getLocalizedText('point-21-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-21-content')"></div>  
        
    <h2>{{getLocalizedText('point-22-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-22-content')"></div>   
  
    <h2>{{getLocalizedText('point-23-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-23-content')"></div>
      
    <h2>{{getLocalizedText('point-24-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-24-content')"></div>  
        
    <h2>{{getLocalizedText('point-25-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-25-content')"></div>   
  
    <h2>{{getLocalizedText('point-26-subtitle')}}</h2>
    <div ng-bind-html-unsafe="getLocalizedText('point-26-content')"></div>
        
         
  
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
    <button type="button" class="button-go-tutorial" ng-click="goToPage('howtocreatecontest')">{{getLocalizedText("go-to-help")}}</button>
  </div>
</div>"""));
tc.put("packages/webclient/components/lobby_f2p_comp.html", new HttpResponse(200, r"""<div id="lobbyf2pRoot">
  
  <div class="challenge-your-friends" ng-if="showCreateContest">
    <span class="text">{{getStaticLocalizedText("challengeyourfriendstext")}}</span>
    <button ng-click="onCreateContestClick()">{{getStaticLocalizedText("challengeyourfriendsbutton")}}</button>
  </div>
  <!-- Header de Promociones -->
  <simple-promo-f2p id="promosComponent" ng-show="scrDet.isNotXsScreen"></simple-promo-f2p>

  <!-- Temporalmente pongo la imagen del calendario (maquetar mas adelante). -->
  <!--week-calendar on-day-selected="onSelectedDayChange(day)" dates="dayList"></week-calendar-->

  <!-- Lista de concursos -->
  <contests-list-f2p  id="activeContestList"
                      contests-list="currentContestList"
                      on-action-click='onActionClick(contest)'
                      on-row-click="onRowClick(contest)"
                      action-button-title="'>'"
                      show-date="true">
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
  <ul id="myContestMenuTabs" class="my-contest-tabs" role="tablist">
    <li id="live-contest-tab" class="active"><tab role="tab" data-toggle="tab" ng-click="gotoSection('live')"> {{getLocalizedText("tablive")}} <span class="contest-count" ng-if="numLiveContests > 0">{{numLiveContests}}</span></tab></li>
    <li id="waiting-contest-tab"><tab role="tab" data-toggle="tab" ng-click="gotoSection('upcoming')">{{getLocalizedText("tabupcoming")}}</tab></li>
    <li id="history-contest-tab"><tab role="tab" data-toggle="tab" ng-click="gotoSection('history')">{{getLocalizedText ("tabhistory")}}</tab></li>
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
tc.put("packages/webclient/components/scouting/scouting_comp.html", new HttpResponse(200, r"""<div id="enter-contest-wrapper" class="favorites-wrapper" >

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText("title")}}</div>

  <!-- Nav tabs -->
  <ul class="enter-contest-tabs" role="tablist">
    <li class="active"><tab role="tab" data-toggle="tab" ng-click="tabChange('spanish-league')">{{getLocalizedText("spanish-league")}}</tab></li>
    <li><tab role="tab" data-toggle="tab" ng-click="tabChange('premier-league')">{{getLocalizedText("premier-league")}}</tab></li>
  </ul>

  <div id="enterContest">
    <div class="tabs">
      <div class="tab-content">

        <!-- Tab del contenido normal de seleccion de lineup -->
        <div class="tab-pane active" id="spanish-league">
            <scouting-league team-list="teamListES" soccer-player-list="allSoccerPlayersES" 
                             on-action-button="onFavoritesChange(soccerPlayer)" id-sufix="'ES'"
                             favorites-player-list="favoritesPlayers"></scouting-league>
        </div>
        
        <!-- El otro tab, el del contest-info  -->
        <div class="tab-pane" id="premier-league">
            <scouting-league team-list="teamListUK" soccer-player-list="allSoccerPlayersUK" 
                             on-action-button="onFavoritesChange(soccerPlayer)" id-sufix="'UK'"
                             favorites-player-list="favoritesPlayers"></scouting-league>
        </div>

      </div>
    </div>
  </div>

</div>

<ng-view></ng-view>"""));
tc.put("packages/webclient/components/scouting/scouting_league_comp.html", new HttpResponse(200, r"""<!-- Este sera el selector de partidos en "grande", con botones-->
<teams-filter team-list="teamList" selected-option="teamFilter" id-sufix="idSufix"></teams-filter>

<div class="enter-contest-soccer-players-wrapper">
  <div class="enter-contest-soccer-players">

    <soccer-players-filter show-on-xs="true" name-filter="nameFilter" field-pos-filter="fieldPosFilter" only-favorites="onlyFavorites"></soccer-players-filter>
    <soccer-players-list soccer-players="allSoccerPlayers"
                         lineup-filter="favoritesPlayers" manager-level="10" 
                         favorites-list="favoritesPlayers" only-favorites="onlyFavorites"
                         field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="teamFilter"
                         on-row-click="onRowClick(soccerPlayerId)"
                         on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-list>
  </div>
</div>"""));
tc.put("packages/webclient/components/scouting/teams_filter_comp.html", new HttpResponse(200, r"""<div class="teams-toggler-wrapper">
  <div id="teamsToggler" type="button" class="teams-toggler"  ng-click="toggleTeamsPanel()" 
       ng-class="{'toggleOff': !isTeamsPanelOpen, 'toggleOn': isTeamsPanelOpen }"  data-toggle="collapse" 
       data-target="#teamsFilterWrapper{{idSufix}}">{{buttonText}}</div>
</div>
<div id="teamsFilterWrapper{{idSufix}}" class="teams-filter-wrapper collapse">
  <div id="teamsFilterButtons" class="teams-filter-buttons">
    <div class="teams-filter-wrapper" ng-repeat="team in teamList" >
      <button class="btn btn-default button-filter-team" ng-bind-html="teamHTML(team)" id="team-{{team.id}}"
              ng-click="optionsSelectorValue = team.id" ng-class="{'active': optionsSelectorValue == team.id}">
      </button>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/social/facebook_share_comp.html", new HttpResponse(200, r"""<div class="facebook-share-wrapper">
  <div class="facebook-share-button" ng-click="shareOnFB()">
    <img src="images/iconFacebook.png"/> Compartir
  </div>
  <div class="facebook-like"  ng-show="showLike">
    <fb:like class="facebook-like-xfbml" href="https://www.facebook.com/epicelevenfantasy" layout="button_count" action="like" />
  </div>
</div>"""));
tc.put("packages/webclient/components/social/friend_info_comp.html", new HttpResponse(200, r"""<div class="friend-element-wrapper">
  <img class="friend-picture" ng-src="{{profileImage == ''? 'images/icon-userProfile.png' : profileImage}}">
  <span class="friend-name" max-text-width="{width: nameWidth, text: nickname}"></span>
  <span class="friend-manager-level" ng-if="showManagerLevel"><span class="amount">{{managerLevel}}</span></span>
  <button class="challenge-friend" ng-click="onChallenge({'user': fbUser})" ng-if="showChallenge">{{challengeText}}</button>
</div>"""));
tc.put("packages/webclient/components/social/friends_bar_comp.html", new HttpResponse(200, r"""<div class="friends-bar-wrapper">
  <friend-info ng-repeat="fbuser in fbUsers" user="fbuser" on-challenge="onChallenge({'user': fbuser})" show-challenge="showChallenge"></friend-info>
</div>"""));
tc.put("packages/webclient/components/social/social_share_comp.html", new HttpResponse(200, r"""<div class="social-share-wrapper" id="{{wraperId}}">
  <facebook-share parameters-by-map="sharingInfo" show-like="showLike"></facebook-share>
  <twitter-share parameters-by-map="sharingInfo" show-like="showLike"></twitter-share>
</div>"""));
tc.put("packages/webclient/components/social/twitter_share_comp.html", new HttpResponse(200, r"""<div class="twitter-share-wrapper">
  <a class="twitter-share-button-wrapper" target="_blank" ng-href="https://twitter.com/intent/tweet?{{intentTweetParams}}" ng-click="onTweet()">
    <span class="twitter-share-button"><img src="images/twitterTransparentBG.png">Tweet</span>
  </a>
  <a class="twitter-share-button-wrapper" target="_blank" ng-href="https://twitter.com/intent/follow?screen_name=epiceleven" ng-click="onFollow()" ng-if="showLike">
    <span class="twitter-share-button"><img src="images/twitterTransparentBG.png">Follow</span>
  </a>
  <!--div id="twitterShareButton" class="twitter-share-button-wrapper"></div-->
  <!--div id="twitterFollowButton" class="twitter-follow-button-wrapper" ng-if="showLike"></div-->
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
    <div ng-if="changingSoccerId == null">
    
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
      <div class="user-nickname" max-text-width="{width: nameWidth, text: userNickname}" ng-class="{'nickname-view-contest-entry-mode': isViewContestEntryMode}"></div>
      <div class="changes-box" ng-if="showChanges">
        <span class="title"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span>{{numChanges}}</span>
        <span class="content">{{getLocalizedText("availablechanges")}}</span>
      </div>
      
      <div class="close-team" ng-click="onCloseButtonClick()" ng-show="showCloseButton">
        <!--span class="title">{{getLocalizedText("close")}}</span-->
        <span class="glyphicon glyphicon-remove"></span>
      </div>
    
    </div>
    
    <div ng-if="changingSoccerId != null">
    
      <div class="total-salary-box" ng-if="!isViewContestEntryMode">
        <span class="total-salary-text">{{getLocalizedText("remainsalary")}}:</span>
        <span class="total-salary-money" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableAvailableSalary)}}</span>
      </div>
  
      <div class="user-picture"></div>
      <div class="change-ordinal">{{changeOrdinalText}}</div>
      
    </div>
    
  </div>
  <div class="total-remaining-matches-time" ng-if="isLive">{{getLocalizedText("remainingtime")}} {{remainingTime}}</div>
  
  
  <div class="fantasy-team-list">
    <div class="fantasy-team-slot" ng-repeat="slot in slots" ng-class="{'not-selected': changingSoccerId != null && slot['id'] != changingSoccerId, 'selected': changingSoccerId != null && slot['id'] == changingSoccerId}">
      <div class="soccer-player-row" data-toggle="collapse" data-target="#statistic_{{owner}}_{{$index}}" data-id="{{slot['id']}}">
        <div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div>
        <div class="column-primary-info">
          <span class="soccer-player-name">{{slot.fullName}}</span>
          <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
          <span class="remaining-match-time" ng-if="!isViewContestEntryMode">{{slot.percentOfUsersThatOwn}}% {{getLocalizedText("owned")}}</span>
        </div>
        <div class="column-score" ng-if="!isViewContestEntryMode">
          <span>{{slot.score}}</span>
          <button class="change-btt" ng-if="playerIsChangeable(slot)" ng-disabled="changingSoccerId != null && slot['id'] != changingSoccerId" ng-click="requestChange(slot)"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span></button>
        </div>
        <div class="column-salary" ng-if="isViewContestEntryMode">${{slot.salary}}</div>
      </div>
      <div id="statistic_{{owner}}_{{$index}}" class="soccer-player-statistics collapse" ng-if="!isViewContestEntryMode" ng-show="changingSoccerId == null">
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

  <div class="teams-comp-bar">

    <div id="teamsPanel" class="teams-container collapse" ng-class="{'in': isTeamsPanelOpen }">
      <div class="top-border"></div>
      <div class="teams-box" ng-repeat="match in matchEventsSorted" ng-show="!useAsFilter">
        <div class="teams-info" ng-bind-html="getMatchAndPeriodInfo($index)"></div>
      </div>
      <matches-filter contest="contest" selected-option="matchFilter" ng-if="useAsFilter"></matches-filter>
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

  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId" match-filter="matchFilter" show-filter="isMakingChange"></contest-header-f2p>

  <div id="viewContestRoot" ng-switch="scrDet.isXsScreen" ng-class="{ 'making-change-state': isMakingChange }">
    <div ng-switch-when="true">
     <!-- Tabs de la versión XS -->
      <ul class="view-contest-tabs" id="liveContestTab" >
        <li class="active"> <tab id="userFantasyTeamTab" ng-click="tabChange('userFantasyTeam')">{{getLocalizedText("yourlineup")}}</tab></li>
        <li>                <tab id="usersListTab" ng-click="tabChange('usersList')">{{getLocalizedText("users")}}</tab></li>
        <li ng-disabled="!isOpponentSelected"><tab id="opponentFantasyTeamTab" ng-click="tabChange('opponentFantasyTeam')">{{lastOpponentSelected}}</tab></li>
      </ul>

      <div class="tab-content" id="liveContestTabContent">
      
      
        <div class="tab-pane active" id="userFantasyTeam">
          <fantasy-team contest-entry="mainPlayer" watch="updatedDate" is-opponent="false" show-changes="showChanges" num-changes="numAvailableChanges"
                        on-request-change="onRequestChange(instanceSoccerPlayer)" changing-soccer-id="changingPlayerId" available-salary="remainingSalaryChangingPlayer"></fantasy-team>
          
          
          <button type="button" class="btn-cancel-player-selection" ng-click="closePlayerChanges()" ng-if="isMakingChange">{{getLocalizedText("buttoncancel")}}</button>
          <div class="soccer-player-changes-list" ng-show="isMakingChange">
            <soccer-players-filter show-on-xs="true"  position-filters-enabled="false" name-filter="nameFilter" 
                                   field-pos-filter="fieldPosFilter" only-favorites="onlyFavorites"></soccer-players-filter>
            <soccer-players-list soccer-players="allSoccerPlayers" contest="contest"
                                 lineup-filter="lineupSlots" manager-level="userManagerLevel"
                                 favorites-list="favoritesPlayers" only-favorites="onlyFavorites"
                                 field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                                 on-row-click="onRowClick(soccerPlayerId)" hide-lineup-players="true"
                                 on-action-click="onSoccerPlayerActionButton(soccerPlayer)"
                                 additional-gold-price="changePrice"></soccer-players-list>
          </div>
          <button type="button" class="btn-cancel-player-selection" ng-click="closePlayerChanges()" ng-if="isMakingChange">{{getLocalizedText("buttoncancel")}}</button>
        </div>
        
        <users-list class="tab-pane" id="usersList" contest-entries="contestEntries" on-row-click="onUserClick(contestEntry)" watch="updatedDate"></users-list>
        
        
        <fantasy-team class="tab-pane" is-opponent="true" id="opponentFantasyTeam" parent="ctrl" contest-entry="selectedOpponent" watch="updatedDate"></fantasy-team>
        
        
      </div>
    </div>
    
    <div ng-switch-when="false">
      <fantasy-team id="userFantasyTeam" contest-entry="mainPlayer" watch="updatedDate" is-opponent="false" show-changes="showChanges" num-changes="numAvailableChanges"
                    on-request-change="onRequestChange(instanceSoccerPlayer)" changing-soccer-id="changingPlayerId" available-salary="remainingSalaryChangingPlayer"></fantasy-team>
      <users-list id="usersList" ng-show="selectedOpponent == null && !isMakingChange" contest-entries="contestEntries" on-row-click="onUserClick(contestEntry)" watch="updatedDate"></users-list>
      <fantasy-team id="opponentFantasyTeam" contest-entry="selectedOpponent" is-opponent="true" ng-show="selectedOpponent != null && !isMakingChange"
                    show-close-button="true" on-close="selectedOpponent=null" watch="updatedDate"></fantasy-team>
      <div class="soccer-player-changes-list" ng-show="isMakingChange">
        <soccer-players-filter show-on-xs="true"  position-filters-enabled="false" name-filter="nameFilter" 
                               field-pos-filter="fieldPosFilter" only-favorites="onlyFavorites"></soccer-players-filter>
        <soccer-players-list soccer-players="allSoccerPlayers" contest="contest"
                             lineup-filter="lineupSlots" manager-level="userManagerLevel"
                             favorites-list="favoritesPlayers" only-favorites="onlyFavorites"
                             field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                             on-row-click="onRowClick(soccerPlayerId)" hide-lineup-players="true"
                             on-action-click="onSoccerPlayerActionButton(soccerPlayer)"
                             additional-gold-price="changePrice"></soccer-players-list>
      </div>
    </div>
    <div class="contest-id-bar">
      <!--div class="contest-id">CHANGES AVAILABLE: {{numAvailableChanges}} || SALARY: {{remainingSalary}} ({{lineupCost}}/{{maxSalary}}) || PLAYER: {{changingSalaryPlayer}} || ID: {{contest.contestId.toUpperCase()}}</div-->
      <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
    </div>
    <div class="clear-fix-bottom"></div>
  </div>

</section>

<ng-view></ng-view>
"""));
tc.put("packages/webclient/components/view_contest/view_contest_entry_comp.html", new HttpResponse(200, r"""<section ng-show="!loadingService.isLoading">
  <contest-header-f2p id="contestHeader" contest="contest" contest-id="contestId"></contest-header-f2p>
  
  <!--<div class="separator-bar"></div>-->
  <div class="info-complete-bar" ng-if="!isModeViewing">
    <p class="important-info" ng-if="isModeCreated">{{getLocalizedText("created")}}</p>
    <p class="important-info" ng-if="isModeEdited">{{getLocalizedText("edited")}}</p>
    <p class="important-info" ng-if="isModeSwapped">{{getLocalizedText("swapped")}}</p>
    <h2 ng-if="showInviteButton" ng-click="onInviteFriends()" class="invite-friends">{{getLocalizedText("invite_text")}}</h2>
    <p class="complementary-info">{{getLocalizedText("tip")}}</p>
  </div>
  
  
  <friends-bar user-list="filteredFriendList" on-challenge="onChallenge(user)"></friends-bar>
  
  
  <div id="viewContestEntry" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
      <!-- Tabs de la versión XS -->
      <ul class="view-contest-entry-tabs" id="viewContestEntryTab" >
        <li class="active"><tab ng-click="tabChange('userFantasyTeam')" data-toggle="tab">{{getLocalizedText("yourlineup")}}</tab></li>
        <li><tab ng-click="tabChange('usersList')" data-toggle="tab">{{getLocalizedText("users")}}</tab></li>
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
  
  <div class="share-methods-modal-content" id="shareMethodsContent">
    <div class="share-method">
      <p>Puedes compartir el enlace del torneo en tu perfil de Facebook</p>
      <social-share parameters-by-map="sharingInfo" inline></social-share>
    </div>
    <div class="share-method">
      <p>o enviarlo por mail a los amigos que quieras.</p>
      <p class="important">Copia y envia este enlace a tus amigos</p>
      <input class="share-url" type="text" ng-if="contest != null" rows="1" 
             ng-keyup="onShareTextareaFocus($event)" ng-keydown="onShareTextareaFocus($event)" 
             ng-mouseup="onShareTextareaFocus($event)" ng-click="onShareTextareaFocus($event)"
             ng-focus="onShareTextareaFocus($event)" ng-model="inviteUrl" readonly autofocus>
    </div>
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