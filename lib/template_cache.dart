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
tc.put("packages/webclient/components/account/edit_personal_data_comp.html", new HttpResponse(200, r"""<form id="editPersonalDataForm" class="edit-form" ng-submit="saveChanges()" role="form" autocomplete="off" ng-show="!loadingService.isLoading">
  <div class="content">

    <!-- Nickname -->
    <div class="content-field">
      <span id="lblPassword" class="text-label">{{getLocalizedText("username")}}</span>      
      <input id="txtNickName" class="text-input" type="text" maxlength="{{MAX_NICKNAME_LENGTH}}" ng-model="editedNickName" placeholder="{{getLocalizedText('username')}}" class="form-control" tabindex="3" autocapitalize="off">
      <!-- Error de nickName -->
      <div id="nickNameErrorContainer" class="content-field-block errorDetected" ng-if="nicknameErrorText != ''">
        <div id="nickNameErrorLabel" class="err-text">{{nicknameErrorText}}</div>
      </div>
    </div>
      
    <!-- Nombre -- >
    <div class="content-field">
      <span id="lblPassword" class="text-label">{{getLocalizedText("name")}}</span>
      <input id="txtName" class="text-input" type="text" maxlength="{{MAX_NAME_LENGTH}}" ng-model="editedFirstName" placeholder="{{getLocalizedText('name')}}" class="form-control"  tabindex="1">
    </div>
    
    <! -- Apellidos -- >
    <div class="content-field">      
      <span id="lblPassword" class="text-label">{{getLocalizedText("lastname")}}</span>
      <input id="txtLastName" class="text-input" type="text" maxlength="{{MAX_SURNAME_LENGTH}}"ng-model="editedLastName" placeholder="{{getLocalizedText('lastname')}}" class="form-control" tabindex="2">
    </div>
    


    <! -- Correo Electrónico -- >
    <div class="content-field" ng-if="userData.canChangeEmail">
      <span id="lblPassword" class="text-label">{{getLocalizedText("mail")}}</span>      
      <input id="txtEmail" class="text-input" type="email" ng-model="editedEmail" placeholder="{{getLocalizedText('mail')}}" class="form-control" tabindex="4" autocapitalize="off">
      <! -- Error de mail -- >
      <div id="emailErrorContainer" class="content-field-block errorDetected" ng-if="emailErrorText != ''">
        <div id="emailErrorLabel" class="err-text">{{emailErrorText}}</div>
      </div>
    </div>

    <! -- Label Contraseña -- >
    <div class="content-field" ng-if="userData.canChangePassword">
      <span id="lblPassword" class="text-label">{{getLocalizedText("passrequires")}}</span>
      <input id="txtPassword" class="text-input" type="password" ng-model="editedPassword" placeholder="{{getLocalizedText('pass')}}" class="form-control" tabindex="5" autocapitalize="off">
      <input id="txtRepeatPassword" class="text-input" type="password" ng-model="editedRepeatPassword" placeholder="{{getLocalizedText('repass')}}" class="form-control" tabindex="6" autocapitalize="off">
      <! -- Error de contraseñas -- >
      <div id="passwordErrorContainer" class="errorDetected" ng-if="passwordErrorText != ''">
        <div id="passwordErrorLabel" class="err-text">{{passwordErrorText}}</div>
      </div>
    </div -->
    
  </div>

  <div class="content-field">
    <button id="btnSubmit" class="action-button-save" ng-disabled="!canSave" type="submit">{{getLocalizedText("buttonsave")}}</button>
  </div>

</form>"""));
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
            <!--div class="fb-login-button" data-size="xlarge" data-max-rows="1" 
                 data-scope="public_profile,email,user_friends"
                 data-show-faces="true" onlogin="jsLoginFB()" ng-show="!isFacebookConnected"></div>
            <div class="fb-login-button" data-size="xlarge"
                 data-scope="public_profile,email,user_friends"
                 onlogin="jsLoginFB()" ng-show="isFacebookConnected"></div-->
            <button class="fb-login-button-smartphone" ng-click="makeFacebookSignUp()"> <img src="images/FB-f-Logo__white_29.png" class="fb-brand">{{getLocalizedText('buttonsignupfb')}}</button>
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
              <p class="termsAndConditionsText">
                {{getLocalizedText('acceptTermsAndPrivacyPolicy0')}}
                <span class="link-aspect" externaldest='http://www.futbolcuatro.com/terminos-de-uso/'>{{getLocalizedText('acceptTermsAndPrivacyPolicy1')}}</span> 
                {{getLocalizedText('acceptTermsAndPrivacyPolicy2')}}
                <span class="link-aspect" externaldest='http://www.futbolcuatro.com/politica-de-privacidad/'>{{getLocalizedText('acceptTermsAndPrivacyPolicy3')}}</span>.
              </p>
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
            <!--div class="fb-login-button" data-size="xlarge" onlogin="jsLoginFB()"
                 data-scope="public_profile,email,user_friends"
                 ng-show="isFacebookConnected"></div>
            <div class="fb-login-button" data-size="xlarge" onlogin="jsLoginFB()"
                 data-scope="public_profile,email,user_friends"
                 data-show-faces="true" data-max-rows="1" ng-show="!isFacebookConnected"></div-->
            <button class="fb-login-button-smartphone" ng-click="makeFacebookLogin()"> <img src="images/FB-f-Logo__white_29.png" class="fb-brand">{{GetLocalizedText('buttonloginfb')}}</button>
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
tc.put("packages/webclient/components/account/notifications_comp.html", new HttpResponse(200, r"""<!-- Notificaciones tipo logro -->
<div class="notification-wrapper">
 
  <div class="notification-slot"  ng-repeat="notification in notificationList" ng-class="{'uncommon': notification.type == 'ACHIEVEMENT_EARNED'}">
    <div class="notification-icon-wrapper">
      <img ng-src="{{getNotificationIcon(notification.type)}}">
    </div>  
    <div class="notification-info-wrapper" ng-click="onAction(notification.id)">
      <div class="notification-title">{{notification.name}}</div>
      <div class="notification-description" ng-bind-html-unsafe="notification.description"></div>
      <div class="notification-actions-wrapper">
        <div class="notification-main-action" ng-if="notification.link.name != ''" ng-click="goToLink(notification.link.url)">{{notification.link.name}}</div>
        <div class="notification-dismiss-action" ng-click="closeNotification($event, notification.id)"><i class="material-icons">&#xE872;</i></div>
      </div>
    </div>
  </div>
  
  <div class="notification-list-empty" ng-if="notificationList.length == 0">
    {{getLocalizedText('notification-list-empty')}}
  </div>
  
</div>

<div class="notification-clear-section" ng-if="notificationList.length > 0" ng-click="cleanNiotifications()"><span>BORRAR TODAS</span><i class="material-icons">&#xE0B8;</i></div>"""));
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
tc.put("packages/webclient/components/account/shop_comp.html", new HttpResponse(200, r"""<div class="money-slot" ng-repeat="item in goldProducts">
  <img class="gold-icon" ng-src="{{item.captionImage}}">
  <img ng-src="{{getLocalizedText('mostpopularimagesource')}}" class="gold-item-popular" ng-if="item.isMostPopular">
  <div class="description">
    <div class="name">{{item.description}}</div>
    <div class="coins-count">{{item.quantity}}</div>
  </div>
  <div class="price">
    <!--div class="free-increment" ng-if="item.freeIncrement > 0">
      <span class="free-increment-count">{{item.freeIncrement}}</span>
      <span class="free-increment-desc">{{getLocalizedText('free')}}</span>
    </div-->
    <div class="buy-button" ng-click="buyGold(item.id)">{{item.price}}</div>
  </div>
</div>

<ng-view></ng-view>"""));
tc.put("packages/webclient/components/account/user_profile_comp.html", new HttpResponse(200, r"""
<!-- INFORMACION PERSONAL -->
<div class="personal-data profile-section">
  <div class="profile-data-content">
    <!--div class="profile-data-row">
      <span class="profile-data-key">{{getLocalizedText("fullname")}}: </span><span class="profile-data-value">{{userData.firstName + ' ' + userData.lastName}}</span>
    </div-->
    <div class="profile-data-row">
      <span class="profile-data-key">{{getLocalizedText("nick")}}: </span>
      <span class="profile-data-value">{{userData.nickName}}</span>
    </div>
    <!--div class="profile-data-row" ng-if="userData.canChangeEmail">
      <span class="profile-data-key">{{getLocalizedText("email")}}: </span><span class="profile-data-value">{{userData.email}}</span>
    </div-->
    <!--div class="profile-data-row" ng-if="userData.canChangePassword">
      <span class="profile-data-key">{{getLocalizedText("pass")}}: </span><span class="profile-data-value">********</span>
    </div-->
  </div>
  <div class="profile-data-action">
    <button class="action-button" ng-click="editPersonalData()">Editar</button>
  </div>
</div>

<!-- ORO -->
<div class="pocket-data profile-section">
  <div class="profile-data-content">
    <div class="profile-data-row">
      <span class="profile-data-key">Oro:</span>
      <span class="profile-data-value">{{userData.balance}}<img class="coin-icon" src="images/topBar/icon_coin_big.png"></span> 
    </div>
  </div>
  <div class="profile-data-action">
    <button class="action-button" ng-click="goBuyGold()">Comprar</button>
  </div>
</div>

<!-- CLASIFICACIONES -->
<div class="ranking-data profile-section">
  <div class="profile-data-content">
    <div class="profile-data-row single-ranking-info">
      <span class="profile-data-key">Ranking<br>de habilidad</span>
      <span class="profile-data-value profile-data-ranking-position" ng-show="!loadingService.isLoading">{{rankingPointsPosition}}º</span>
      <span class="profile-data-value profile-data-ranking-points" ng-show="!loadingService.isLoading">{{rankingPoints}} Ptos.</span>
    </div>
    <div class="profile-data-row single-ranking-info">
      <span class="profile-data-key">Ranking<br>de ganancias</span>
      <span class="profile-data-value profile-data-ranking-position" ng-show="!loadingService.isLoading">{{rankingMoneyPosition}}º</span>
      <span class="profile-data-value profile-data-ranking-points" ng-show="!loadingService.isLoading">{{rankingMoney}} Mon.</span>
    </div>
  </div>
  <div class="profile-data-action">
    <button class="action-button" ng-click="goLeaderboard()">Ver rankings</button>
  </div>
</div>

<!-- ACHIEVEMENTS -->
<div class="achievements-data profile-section">
  <div class="profile-data-content">
    <div class="profile-data-row">
      <span class="profile-data-key">Logros</span>
      <div class="profile-data-value"><span class="profile-data-earned-achivements">{{achievementsEarned}}</span><span class="profile-data-total-achivements">de {{achievementList.length.toString()}}</span></div>
    </div>
  </div>
  <div class="profile-data-action">
    <button class="action-button" ng-click="goAchievements()">Ver logros</button>
  </div>
</div>

<ng-view></ng-view>"""));
tc.put("packages/webclient/components/contest_header_comp.html", new HttpResponse(200, r"""<div class="name-section">
  <div class="contest-name">{{contest.name}}</div>
  <div class="contest-description">{{contest.description}}</div>
</div>
<div class="more-info" ng-show="showInfoButton" ng-click="onInfoClick()"><i class="material-icons">&#xE88F;</i></div>

<!-- precio -->
<div class="prize-section" ng-show="!showInfoButton">
  <div class="prize-count" ng-class="{'prize-coin':getContestCoinIcon(getPrizeToShow()) == 'gold', 'prize-managerpoints':getContestCoinIcon(getPrizeToShow()) == 'manager'}">{{getPrizeToShow()}}</div>
  <div class="prize-description">{{getLocalizedText("prize")}}</div>
</div>

<!-- premio -->
<div class="price-section" ng-show="!showInfoButton" ng-if="!(contest.isLive || contest.isHistory)">
  <span class="price-count" ng-class="{'entry-fee-coin': getContestCoinIcon(contest.entryFee) == 'gold', 'entry-fee-energy':getContestCoinIcon(contest.entryFee) == 'energy'}">{{contest.entryFee}}</span>
  <span class="price-description">{{getLocalizedText("entryfee")}}</span>
</div>"""));
tc.put("packages/webclient/components/contest_info_comp.html", new HttpResponse(200, r"""<div id="contestInfoTabbed" ng-show="contest != null">
  
  <!-- cabecera con precio y premio -->
  <div class="info-header">
    <!-- precio -->
    <div class="prize-section">
      <div class="prize-count" ng-class="{'prize-coin':getContestCoinIcon(getPrizeToShow(contest)) == 'gold', 'prize-managerpoints':getContestCoinIcon(getPrizeToShow(contest)) == 'manager'}">{{getPrizeToShow(contest)}}</div>
      <div class="prize-description">{{getLocalizedText("prize")}}</div>
    </div>
    <!-- premio -->
    <div class="price-section" ng-if="!(contest.isLive || contest.isHistory)">
      <div class="price-count" ng-class="{'entry-fee-coin': getContestCoinIcon(contest.entryFee) == 'gold', 'entry-fee-energy':getContestCoinIcon(contest.entryFee) == 'energy'}">{{contest.entryFee}}</div>
      <div class="price-description">{{getLocalizedText("entryfee")}}</div>
    </div>
  </div>
  
  <!--Cartel "partidos"-->
  <div class="header-section">{{getLocalizedText("matches")}}</div>
  
  <!--Partidos dentro del concurso-->
  <div class="matches-involved">
      <div class="match" ng-repeat="match in currentInfoData['matchesInvolved']">
          <div class="team">{{match.soccerTeamA.name}}</div>
          <div class="date" ng-if="match.isStarted">{{(match.soccerTeamA.score < 0) ? 0 : match.soccerTeamA.score}} - {{(match.soccerTeamB.score < 0) ? 0 : match.soccerTeamB.score}}</div>
          <div class="date" ng-if="!match.isStarted">{{formatMatchDate(match.startDate)}}</div>
          <div class="team">{{match.soccerTeamB.name}}</div>
      </div>
  </div>
  
  <!--Cartel "jugadores"-->
  <div class="header-section">{{getLocalizedText("players")}}</div>
  <!--Jugadores dentro del concurso-->
  <div class="contestant-list">
    <div class="contestant-element">
      <div class="name">{{getLocalizedText("name")}}</div>
      <div class="level">{{getLocalizedText("level")}}</div>
    </div>    
    <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
      <div class="name">{{contestant.name}}</div>
      <div class="level">{{contestant.trueSkill}}</div>
    </div>
  </div>  
  <div ng-if="!loadingService.isLoading && currentInfoData['contestants'].isEmpty" class="default-info-text" ng-bind-html="getLocalizedText('nocontenders')"></div>
  
</div>

"""));
tc.put("packages/webclient/components/contests_list_comp.html", new HttpResponse(200, r"""

<div class="contest-list-item-wrapper" ng-repeat="contest in currentContestList.elements track by contest.contesId">
    <!-- Separador de fecha -->
    <div class="contestDateSeparator" ng-if="idDifferentDate($index) && showDate">
      <span>{{dateSeparatorText(contest.startDate)}}</span>
    </div>
    <!-- Slot de Concurso -->
    <div class="contestSlot" ng-class="{'special': getContestMorfology(contest) == 'special', 'real': getContestTypeIcon(contest) == 'real', 'virtual': getContestTypeIcon(contest) != 'real'}" ng-click="onRow(contest)" ng-style="{'background-image':'url({{getContestImage(contest)}})'}">
      <div class="contest-content">
        <!-- nombre y descripción -->
        <div class="name-section">
          <div class="contest-data-item-value column-start-hour" ng-if="hourIsShow(contest)">{{timeInfo(contest.startDate, !contest.isHistory)}}</div>
          <div class="contest-data-item-value column-substitutions" ng-if="substitutionsIsShow(contest)">{{substitutionCount(contest)}}<i class="material-icons">&#xE8D5;</i></div>
          <div class="contest-data-item-value column-name">{{contest.name}}</div>
        </div>
        <div class="contest-data-section">
          <div class="contest-data-item entries-section" ng-if="entriesIsShow(contest)">
            <div class="contest-data-item-value">{{entriesColumn(contest)}}<i class="material-icons">&#xE7FB;</i></div>
            <div class="contest-data-item-key">Jugadores</div>
          </div>
          <div class="contest-data-item position-section" ng-if="positionIsShow(contest)">
            <div class="contest-data-item-value position-value">{{printableMyPosition(contest)}}º<span> / {{contest.numEntries}}</span></div>
            <div class="contest-data-item-key">Posición</div>
          </div>
          <!-- bandera y Hora -->
          <div class="contest-data-item prize-distribution-section" ng-if="prizeDistributionIsShow(contest)">
            <div class="contest-data-item-value">{{prizeDistribution(contest)}}</div>
            <div class="contest-data-item-key">Premiados</div>
          </div>
          <!-- puntos -->
          <div class="contest-data-item points-section" ng-if="pointsSectionIsShow(contest)">
            <div class="contest-data-item-value price-count">{{pointsOfUser(contest)}}</div>
            <div class="contest-data-item-key price-description">Puntos</div>
          </div>
          <!-- bote -->
          <div class="contest-data-item prize-pool-section" ng-if="prizePoolSectionIsShow(contest)">
            <div class="contest-data-item-value prize-count">{{getPrizePool(contest)}}<i class="material-icons">&#xE3FA;</i></div>
            <div class="contest-data-item-key prize-description">Bote</div>
          </div>
          <!-- premio -->
          <div class="contest-data-item user-prize-section" ng-if="userPrizeSectionIsShow(contest)">
            <div class="contest-data-item-value prize-count">{{getPrizeToShow(contest)}}<i class="material-icons">&#xE3FA;</i></div>
            <div class="contest-data-item-key prize-description">Premio</div>
          </div>
          <!-- precio -->
          <div class="contest-data-item price-section" ng-if="priceSectionIsShow(contest)">
            <div class="contest-data-item-value price-count">{{contest.entryFee.amount == 0? "Gratis" : contest.entryFee}}<i class="material-icons" ng-if="contest.entryFee.amount != 0">&#xE3FA;</i></div>
            <div class="contest-data-item-key price-description">Entrada</div>
          </div>
        </div>
      </div>
      <!-- Flechita call to action --->
      <div class="contest-action" ng-click="onAction(contest, $event)">
        <i class="material-icons">&#xE5CC;</i>
      </div>
    </div> 
</div>

<div class="loading-row" ng-if="!currentContestList.isFullList">
  <div id="loadingRowSpinner"><div class="spinner" role="progressbar"><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-0-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(0deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-1-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(27deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-2-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(55deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-3-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(83deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-4-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(110deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-5-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(138deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-6-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(166deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-7-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(193deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-8-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(221deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-9-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(249deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-10-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(276deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-11-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(304deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div><div style="position: absolute; top: -1px; opacity: 0.25; animation: opacity-60-25-12-13 1s linear infinite;"><div style="position: absolute; width: 8px; height: 2px; box-shadow: rgba(0, 0, 0, 0.0980392) 0px 0px 1px; transform-origin: left 50% 0px; transform: rotate(332deg) translate(7px, 0px); border-radius: 1px; background: rgb(0, 0, 0);"></div></div></div></div>
</div>
"""));
tc.put("packages/webclient/components/create_contest_comp.html", new HttpResponse(200, r"""

<div class="create-contest-section-wrapper name-section">
  <!-- NOMBRE DEL TORNEO -->  
  <div class="create-contest-title-wrapper">
    <div class="title-num">1</div>
    <div class="title-name">ELIGE EL NOMBRE DEL TORNEO</div>
  </div>
  <div class="create-contest-section">
    <div class="title">{{getLocalizedText("name")}}</div>
    <div class="data-input-wrapper contest-name">
      <input id="contestNameInput" type="text" ng-model="contestName" tabindex="1"
             placeholder="{{placeholderName}}" maxlength="{{MAX_LENGTH_CONTEST_NAME}}"
             class="form-control ng-binding ng-pristine ng-touched">
      <span class="contest-name-length">{{MAX_LENGTH_CONTEST_NAME - contestName.length}}</span>
    </div>
  </div>
  
  <!-- RIVALES -->
  <div class="create-contest-title-wrapper">
    <div class="title-num">2</div>
    <div class="title-name">SELECCIONA EL NÚMERO DE RIVALES</div>
  </div>
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
        <label for="contestOpen">
          <span class="icon"></span>
          <span class="label">{{getLocalizedText("league")}}</span>
          <select name="contestLeagueCountSelector" id="contestLeagueCountSelector" class="form-control contest-league-count-selector dropdown-toggle" ng-model="selectedLeaguePlayerCount">
            <option ng-repeat="count in leaguePlayerCountList" id="option-contest-count-{{count}}" value="{{$index + 1}}" ng-value="count">{{count == -1? getLocalizedText("no_limit") : count}}</option>
          </select>
        </label>
      </span>
    </div>
  </div>
  
</div>
<!-- BOTON ACEPTAR -->
<button type="button" class="btn-confirm-contest" ng-click="createContest()" ng-disabled="!isComplete">ACEPTAR</button>

<!--div class="create-contest-section-wrapper">
  <div class="create-contest-section">
    <div class="data-input-wrapper confirm-button-wrapper">
    </div>      
  </div>
</div-->

<!-- TIPO DEL TORNEO -->
<!--div class="create-contest-section-wrapper">
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
</div-->

<!-- COMPETICION -->
<!--div class="create-contest-section-wrapper">
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
</div-->

<!-- EVENTO -->
<!--div class="create-contest-section-wrapper event-section">
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
</div-->

<!-- FECHA -->
<!--div class="create-contest-section-wrapper date-section">
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
</div-->

<!-- PARTIDOS -->
<!--teams-panel id="teamsPanelComp" panel-open="true" template-contest="selectedTemplate" button-text="getLocalizedText('matches_title')"></teams-panel-->

<!-- PREMIOS -->
<!--div class="create-contest-section-wrapper">
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
      
      <!- -span class="data-element">
        <input id="contestFee_1E_3MP" type="radio" value="1E_3MP" name="entry-fee">
        <label for="contestFee_1E_3MP"><span class="entry-fee-value energy">1</span> por <span class="entry-fee-value manager-points">3</span></label>
      </span>
      
      <span class="data-element">
        <input id="contestFee_1G_3G" type="radio" value="1G_3G" name="entry-fee">
        <label for="contestFee_1G_3G"><span class="entry-fee-value gold">1</span> por <span class="entry-fee-value gold">3</span></label>
      </span- ->
    </div>
  </div>
</div-->



"""));
tc.put("packages/webclient/components/enter_contest/enter_contest_comp.html", new HttpResponse(200, r"""
<!-- LINEUP FIELD -->
<section class="lineup-selector-section" ng-show="isLineupFieldSelectorActive" >
  <div class="lineup-actions-wrapper">  
    <div class="lineup-clean-btn-wrapper">
      <button type="button" class="btn-clean-lineup-list" ng-click="resetLineup()">Limpiar alineación</button>
    </div>
    <div class="lineup-clean-btn-wrapper">
      <button type="button" class="btn-automatic-lineup" ng-click="generateAutomaticLineup()">Alineación automática</button>
    </div>
  </div>
  <lineup-field-selector lineup-slots="lineupSlots"
                         lineup-formation="lineupFormation"
                         on-lineup-slot-selected="onLineupSlotSelected(slotIndex)"
                         formation-id="formationId"></lineup-field-selector>
  <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
  <button class="confirm-btn" ng-show="!isThereAnyLineupConfigError" ng-click="createFantasyTeam()" ng-disabled="!isLineupFilled">Confirmar</button>
  <div class="lineup-config-error" ng-show="isThereAnyLineupConfigError">
    <span class="lineup-config-error-title">{{getLocalizedText('alert-invalid-lineup')}}</span>
    {{lineupConfigErrorText}}
  </div>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableCurrentSalary)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>

<!-- SOCCER PLAYER LIST -->
<section class="soccer-player-list-section" ng-if="isSelectingSoccerPlayerActive">
  <soccer-players-scalinglist soccer-players="allSoccerPlayers"
                              lineup-filter="lineupSlots"
                              manager-level="playerManagerLevel"
                              contest="contest"
                              favorites-list="favoritesPlayers" only-favorites="onlyFavorites"
                              field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                              on-info-click="onSoccerPlayerInfoClick(soccerPlayerId)"
                              on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-scalinglist>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableCurrentSalary)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>

<!-- SOCCER PLAYER STATS -->
<section class="soccer-player-list-section" ng-show="isSoccerPlayerStatsActive">
  <soccer-player-stats instance-soccer-player-id="instanceSoccerPlayerDisplayInfo"
                       contest-id="contest.contestId"
                       selectable-player="isCurrentSelectedAdded"
                       on-action-click="onSoccerPlayerActionButtonFromStats(playerId)">
  </soccer-player-stats>
</section>

<!-- CONTEST INFO -->
<section class="contest-info-section" ng-show="isContestInfoActive">
  <contest-info the-contest="contest" ng-if="contest != null"></contest-info>
</section>

<!-- LINEUP FINISHED -->
<modal-window class="lineup-finished-modal small" show-header="false" show-window="isLineupFinished">
  <div class="lineup-finished-title">¡Enhorabuena!<br>Has completado tu alineación con éxito</div>
  <button class="lineup-finished-invite-friends" ng-click="inviteFriends()">Invita a tus amigos <i class="material-icons">&#xE7F0;</i></button>
  <div class="lineup-finished-text">Recuerda que puedes modificar la alineación tantas veces como quieras hasta que el torneo comience</div>
  <div class="lineup-finished-actions-wrapper">
    <button class="lineup-finished-back-lobby" ng-click="cancelCreateLineup()">Volver a torneos</button>
    <button class="lineup-finished-view-lineup" ng-click="goUpcomingContest()">Ver alineación</button>
  </div>
</modal-window>

<!-- ERROR JOINING -->
<modal-window class="error-joining-modal small" show-header="false" show-window="joiningErrorText != ''">
  <div class="error-joining-title">Lo sentimos...</div>
  <div class="error-joining-text">Ha ocurrido un error: <br>{{joiningErrorText}}</div>
  <div class="error-joining-actions-wrapper">
    <button class="error-joining-back-lobby" ng-click="cancelCreateLineup()">Volver a torneos</button>
  </div>
</modal-window>
"""));
tc.put("packages/webclient/components/enter_contest/lineup_field_selector_comp.html", new HttpResponse(200, r"""<div class="lineup-field-selector" ng-class="getLineupClassname()">
  <div class="lineup-formation-selector-wrapper" ng-if="formationIsModifiable">
    <span class="lineup-formation-label">{{getLocalizedText('formation')}}</span>
    <select name="lineup-formation-dropdown" id="lineup-formation-dropdown" ng-model="formationId" class="lineup-formation-dropdown">
      <option ng-repeat="key in formationList" ng-value="key" >{{formationToString(key)}}</option>
    </select>
    <label for="lineup-formation-dropdown" class="lineup-formation-dropdown-caret"><i class="material-icons">&#xE5C5;</i></label>
  </div>
  
  <div class="lineup-selector-wrapper" ng-class="{'changing-mode': highlightChangeables}">
    <div class="lineup-selector-slot" ng-repeat="slot in lineupSlots" ng-click="onLineupSlotSelected({'slotIndex': $index})" ng-class="getSlotClassColor($index)">
      <div ng-if="slot == null">
        <img ng-src="{{getImgPerSlotPosition($index)}}" class="team-shirt-image">
        <action class="iconButtonSelect"><i class="material-icons">&#xE145;</i></action>
      </div>

      <div ng-if="slot != null" class="lineup-selector-slot-info" ng-class="{'playing': slot.isPlaying, 'not-played': slot.hasNotPlayed}">
        <!--div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div-->
        <img src="images/team-shirts/_glow.png" class="team-shirt-glow">
        <img ng-src="{{getImgPerSoccerTeam(slot)}}" class="team-shirt-image">
        <span class="soccer-player-name">{{slot.fullName}}</span>
        <!--div class="column-primary-info">
          <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
        </div-->
        
        <div class="column-salary" ng-show="showSalary && (slot.hasNotPlayed || slot.isPlaying)"><div>{{getPrintableSalary(slot.salary)}}</div></div>
        
        <div class="column-dfp" ng-if="!isLive"><div>{{slot.printableFantasyPoints}}</div></div>
        <div class="column-dfp" ng-if="showLivePoints(slot)"><div>{{slot.livePoints}}</div></div>
        
        <!--div class="column-gold-cost" ng-bind-html="getPrintableGoldCost(slot)"></div-->
        <!--action class="iconButtonRemove"><i class="material-icons">&#xE15B;</i></action-->
      </div>
    </div>
  </div>
  
  <!--div class="alert alert-danger alert-dismissible alert-red-numbers" ng-class="{'active':alertNotEnoughResources}" role="alert" ng-bind-html="getLocalizedText('not-enough-resources')"></div>
  <div class="alert alert-danger alert-dismissible alert-red-numbers" ng-class="{'active':alertNegativeBalance}" role="alert" ng-bind-html="getLocalizedText('wastedsalarycap')"></div>
  <div class="alert alert-danger alert-max-players-same-team" ng-class="{'active':alertMaxPlayersSameTeamExceed}" role="alert" ng-bind-html="getLocalizedText('maxplayersteam')"></div-->
  
</div>"""));
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
      <div class="column-action"><action class="iconButtonSelect"><span class="glyphicon glyphicon-chevron-right"></span></action></div>
    </div>

    <div ng-if="slot != null">
      <!--div class="column-fieldpos">{{slot.fieldPos.abrevName}}</div-->
      <div class="column-primary-info">
        <span class="soccer-player-name">{{slot.fullName}}</span>
        <span class="match-event-name" ng-bind-html="slot.matchEventNameHTML"></span>
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
tc.put("packages/webclient/components/enter_contest/soccer_player_stats_comp.html", new HttpResponse(200, r"""<!-- Extra info en la cabecera -->
<div class="soccer-player-stats-header">
  <div class="soccer-player-stats-header-tshirt"><img ng-src="{{imgSoccerTeam}}"></div>
  <div class="soccer-player-stats-header-data">
    <div class="soccer-player-stats-header-description">
      <div class="soccer-player-name-team">
        <div class="soccer-player-pos-team">{{currentInfoData['fieldPos']}} | {{currentInfoData['team']}}</div>
        <div class="soccer-player-name">{{currentInfoData['name']}}</div>
      </div>
      <div class="soccer-player-stats-header-button-add-wrapper">
        <button class="soccer-player-stats-header-button-add" ng-click="onAddClick()" ng-if="isSelectionMode">{{selectablePlayer ? "AÑADIR" : "QUITAR"}}</button>
        <i class="material-icons" ng-click="onAddFavClick()" ng-class="[selectablePlayer ? 'addFav' : 'removeFav']" ng-if="isFavoriteMode" alt="Favorito">
          {{!selectablePlayer ? '&#xE83A;' : '&#xE838;'}}
        </i>
      </div>
    </div>
    <div class="soccer-player-stats-info">
      <div class="soccer-player-stat-resume-item soccer-player-fantasy-points-wrapper">
      <div class="soccer-player-stat-resume-item soccer-player-fantasy-points-label">PUNTOS</div>
        <div class="soccer-player-stat-resume-item soccer-player-fantasy-points">{{currentInfoData['fantasyPoints']}}</div>
      </div>
      <div class="soccer-player-stat-resume-item soccer-player-matches-wrapper">
        <div class="soccer-player-stat-resume-item soccer-player-matches-label">PARTIDOS</div>
        <div class="soccer-player-stat-resume-item soccer-player-matches">{{currentInfoData['matchesCount']}}</div>
        </div>
      <div class="soccer-player-stat-resume-item soccer-player-salary-wrapper">
        <div class="soccer-player-stat-resume-item soccer-player-salary-label">SALARIO</div>
        <div class="soccer-player-stat-resume-item soccer-player-salary">{{printableSalary}}</div>
      </div>
    </div>
  </div>
</div>

<div class="soccer-player-stats-content">
  <!-- Nav tabs -->
  <div class="soccer-player-stats-tabs">
    <input id="soccerPlayerStatsTabSeason" type="radio" name="soccerPlayerStatsTabs" value="season-stats-tab-content" ng-model="currentTab" checked>
    <label for="soccerPlayerStatsTabSeason">{{getLocalizedText("seasondata")}}</label>
    
    <input id="soccerPlayerStatsTabPerMatch" type="radio" name="soccerPlayerStatsTabs" value="match-by-match-stats-tab-content" ng-model="currentTab">
    <label for="soccerPlayerStatsTabPerMatch">{{getLocalizedText("matchbymatch")}}</label>
    
    <!--tab ng-click="tabChange('season-stats-tab-content')">{{getLocalizedText("seasondata")}}</tab>
    <tab ng-click="tabChange('match-by-match-stats-tab-content')">{{getLocalizedText("matchbymatch")}}</tab-->
  </div>
  <!-- START BY-SEASON-STATS -->
  <div class="soccer-player-stats-tab-pane" id="season-stats-tab-content" ng-class="{'active': currentTab =='season-stats-tab-content'}">
    <!--div class="next-match" ng-bind-html="currentInfoData['nextMatchEvent']"></div>
    <div class="season-header" ng-bind-html="getLocalizedText('seasonstats')"></div-->
    <!-- MEDIAS -->
    <div class="season-stats">
        <div class="season-stats-row" ng-repeat="stat in seasonResumeStats" title="{{stat['helpInfo']}}">
            <div class="season-stats-header">{{stat['nombre']}}</div>
            <div class="season-stats-value">{{stat['valor']}}</div>
        </div>
        <!--div class="season-stats-row" ng-if="seasonResumeStats.length % 2 != 0" title="">
            <div class="season-stats-header"></div>
            <div class="season-stats-value"></div>
        </div-->
    </div>
  </div>
  <!-- END BY-SEASON-STATS -->
  
  <!-- START BY-MATCH-STATS-->
  <div class="soccer-player-stats-tab-pane" id="match-by-match-stats-tab-content" ng-class="{'active': currentTab =='match-by-match-stats-tab-content'}">
    <div class="noMatchesPlayed" ng-if="!hasPlayedMatches">
        <span>{{getLocalizedText("noseasonstats")}}</span>
    </div>
    
    <div class="match-stats-table-wrapper" ng-if="hasPlayedMatches">
      
      <div class="per-match-stats-headers-table-wrapper">
        <table class="table table-striped per-match-stats-headers-table">
            <tr class="per-match-stats-table-years-row">
              <th class="per-match-stats-row-header">&nbsp;</th>
            </tr>
            <tr ng-repeat="item in seasonTableHeaders" class="per-match-stats-table-data-row">
              <th class="per-match-stats-row-header">{{item.substring(0,3)}}</th>
            </tr>
        </table>
      </div>
      <div class="per-match-stats-table-wrapper">
        <table class="table table-striped per-match-stats-table">
            <tr class="per-match-stats-table-years-row">
              <!--th class="per-match-stats-row-header"></th-->
              <td ng-repeat="season in seasonsList" colspan="{{season['stats'].length}}" class="start-year-column">{{season['year']}}</td>
            </tr>
            <tr ng-repeat="item in seasonTableHeaders" class="per-match-stats-table-data-row">
              <!--th class="per-match-stats-row-header">{{item.substring(0,3)}}</th-->
              <td ng-repeat="cell in perStatTypeData[$index]" class="per-match-stats-row-cell" ng-class="{'start-year-column': cell['isNewYear']}">
                {{cell['data']}}
              </td>
            </tr>
        </table>
      </div>
    </div>
  </div>
  <!--END BY-MATCH-->
</div>
<!--div class="actions-footer-xs">
  <button class="button-cancel" data-dismiss="modal">{{getLocalizedText("buttoncancel")}}</button>
  <button class="button-add" ng-click="onAddClicked()" ng-disabled="!selectablePlayer">{{getLocalizedText("buttonadd")}}</button>
</div-->

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
tc.put("packages/webclient/components/enter_contest/soccer_players_scalinglist_comp.html", new HttpResponse(200, r"""<div class="soccer-player-table-header">
  <div class="column-header column-info"   ><i class="material-icons">&#xE164;</i></div>
  <div class="column-header column-tshirt" ></div>
  <div class="column-header column-primary-info"   ng-click="sortListByField('Name')">{{getLocalizedText('name')}}</div>
  <div class="column-header column-dfp"    ng-click="sortListByField('DFP')">{{getLocalizedText('dfp')}}</div>
  <div class="column-header column-salary" ng-click="sortListByField('Salary')">{{getLocalizedText('salary')}}</div>
  <div class="column-header column-addbtn" ></div>
</div>

<div class="soccer-player-table-body">
  <div ng-id="'soccerPlayer' + soccerPlayer.id" ng-repeat="soccerPlayer in currentSoccerPlayerList.elements track by soccerPlayer.id" class="soccer-players-list-slot" ng-class="[POS_CLASS_NAMES[soccerPlayer.fieldPos.abrevName], !soccerPlayerIsAvailable(soccerPlayer) ? 'not-available': '', isAddAction(soccerPlayer) ? 'soccer-player-add':'soccer-player-remove']">
    <div class="column-data column-info" ng-click="onInfoClick({'soccerPlayerId': soccerPlayer.id})"><i class="material-icons">&#xE88F;</i></div>
    <div class="column-data column-tshirt" ng-click="onInfoClick({'soccerPlayerId': soccerPlayer.id})">
      <i class="material-icons" ng-if="isFavorite(soccerPlayer)">&#xE838;</i>
      <img ng-src="{{getImgPerSoccerTeam(soccerPlayer)}}" class="team-shirt-image">
    </div>
    <div class="column-data column-primary-info" ng-click="onInfoClick({'soccerPlayerId': soccerPlayer.id})">
      <span class="soccer-player-name">{{soccerPlayer.fullName}}</span>
      <span class="match-event-name" ng-bind-html-unsafe="soccerPlayer.matchEventNameHTML"></span>
    </div>
    <div class="column-data column-dfp">{{soccerPlayer.printableFantasyPoints}}</div>
    <!--div class="column-data column-played">{{soccerPlayer.playedMatches}}</div-->
    <div class="column-data column-salary">{{parseSalary(soccerPlayer)}}</div>
    <!--div class="column-data column-manager-level"><span class="manager-level-needed">{{soccerPlayer.level}}</span></div-->
    
    <div class="column-data column-addbtn" ng-class="[isAddAction(soccerPlayer) ? 'add' : 'remove']" 
         ng-id="'soccerPlayerAction' + soccerPlayer.id" ng-click="onActionClick({'soccerPlayer': soccerPlayer})" ng-if="!isScoutingList">
      <i class="material-icons">{{isAddAction(soccerPlayer) ? '&#xE145;' : '&#xE15B;'}}</i>
    </div>
    
    <div class="column-data column-addbtn" ng-class="[isAddAction(soccerPlayer) ? 'addFav' : 'removeFav']" 
         ng-id="'soccerPlayerAction' + soccerPlayer.id" ng-click="onActionClick({'soccerPlayer': soccerPlayer})" ng-if="isScoutingList">
      <i class="material-icons">{{isAddAction(soccerPlayer) ? '&#xE83A;' : '&#xE838;'}}</i>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/home_comp.html", new HttpResponse(200, r"""<div class="main-info-wrapper">
  <div class="info-columns-wrapper">
    <div class="info-column gold" ng-click="goShop()">
      <div class="label">ORO</div>
      <div  class="icon"><img src="images/home/oro.png"></div>
      <div class=amount>{{user.goldBalance}}</div>
    </div>
    <div class="info-column level" ng-click="goRanking()">
      <div class="label">NIVEL</div>
      <div  class="icon"><img ng-src="images/home/{{skillLevelImage}}"></div>
      <div class=amount>{{skillLevelName}}</div>
    </div>
    <div class="info-column achievements" ng-click="goAchievements()">
      <div class="label">LOGROS</div>
      <div  class="icon"><img src="images/home/logros.png"></div>
      <div class=amount>{{achievementsEarned}} / {{achievementList.length.toString()}}</div>
    </div>
  </div>
  <div class="next-contest-wrapper">
    <div class="next-contest-label" ng-bind-html-unsafe="infoBarText"></div>
    <button class="goto-next-contest-button" ng-click="goNextContest()">JUGAR</button>
  </div>
</div>

<div class="action-buttons-wrapper">
  <div class="button-scout" ng-click="goScouting()">
    <i class="material-icons">&#xE8A3;</i>
    <div class="button-label">OJEADOR</div>
  </div>
  <div class="button-shop" ng-click="goShop()">
    <i class="material-icons">&#xE54C;</i>
    <div class="button-label">TIENDA</div>
  </div>
  <div class="button-history" ng-click="goHistory()">
    <i class="material-icons">&#xE889;</i>
    <div class="button-label">HISTÓRICO</div>
  </div>
</div>

<!-- div id="homeRoot">
  <! --
  Torneos
  Tutorial
  Blog
  Crear Torneos
  Torneos en directo
  Scouting??
  -- >
  
  <!--div id="contestTile" class="home-tile-wrapper enabled" ng-click="onContestsClick()">
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
</div-->"""));
tc.put("packages/webclient/components/leaderboards/achievement_comp.html", new HttpResponse(200, r"""<div ng-bind-html="theHtml"></div>"""));
tc.put("packages/webclient/components/leaderboards/achievement_list_comp.html", new HttpResponse(200, r"""<div class="achievement-count"> {{earneds}} de {{achievementList.length.toString()}} LOGROS CONSEGUIDOS</div>
<achievement ng-repeat="achiev in achievementList" owned="achievementEarned(achiev.id)" key="achiev"></achievement>
"""));
tc.put("packages/webclient/components/leaderboards/leaderboard_comp.html", new HttpResponse(200, r"""<ranking  ranking-points-data="pointsUserList" ranking-money-data="moneyUserList"
          on-show-ranking-points="showPointsRanking()" on-show-ranking-money="showMoneyRanking()" 
          ng-if="!loadingService.isLoading && isMainRankingPlayersActive">
</ranking>
 
<leaderboard-table  share-info="sharingInfoTrueSkill" show-header="true" highlight-element="playerPointsInfo" 
                    table-elements="pointsUserList" rows="USERS_TO_SHOW" points-column-label="pointsColumnName" 
                    hint="playerPointsHint" ng-if="!loadingService.isLoading && isRankingBestPlayersActive">
</leaderboard-table>

<leaderboard-table  share-info="sharingInfoGold" show-header="true" highlight-element="playerMoneyInfo" 
                    table-elements="moneyUserList" rows="USERS_TO_SHOW" points-column-label="moneyColumnName" 
                    hint="playerMoneyHint" ng-if="!loadingService.isLoading && isRankingMostRichActive">
</leaderboard-table>"""));
tc.put("packages/webclient/components/leaderboards/leaderboard_table_comp.html", new HttpResponse(200, r"""<div class="leaderboard-table-header" ng-show="isHeaded">
    <div class="leaderboard-column-position">{{getLocalizedText("abrevposition")}}</div>
    <div class="leaderboard-column-name">{{getLocalizedText("name")}}</div>
    <span class="leaderboard-column-score">{{pointsColumnName}}</span>
</div>

<div class="leaderboard-data-wrapper">
  <div class="leaderboard-table-data" ng-class="{'player-position':isThePlayer(element['id'])}" ng-repeat="element in shownElements">
      <div class="leaderboard-column-position">{{element['position']}}º</div>    
      <div class="leaderboard-column-name">
        {{element['id'] == profileService.user.userId ? 'TÚ' : element['name']}}
        <!--social-share parameters-by-map="sharingInfo" show-like="false" inline ng-if="isThePlayer(element['id']) && sharingInfo != null"></social-share-->
      </div>
      <div class="leaderboard-column-score">{{element['points']}}</div>
  </div>
</div>"""));
tc.put("packages/webclient/components/leaderboards/ranking_comp.html", new HttpResponse(200, r"""<div class="ranking-wrapper">
  <div class="ranking-title ranking-points-title">
    <img class="ranking-logo" src="images/ranking/rankingPointsLogo.png" alt="logo ranking jugones">
    <span>RANKING<br>DE HABILIDAD</span>
  </div>
  <div class="user-data user-points-data">
    <div class="user-position">{{myPointsData['position']}}º</div>
    <div class="user-name">{{profileService.user.nickName}}</div>
    <div class="user-points">{{myPointsData['points']}}</div>
  </div>
  <leaderboard-table minimized show-header="false" table-elements="pointsUserList" rows="3"></leaderboard-table>
  <button class="ranking-button" ng-click="showFullPointsRanking()"> VER COMPLETO</button>
</div>

<div class="ranking-wrapper">
  <div class="ranking-title ranking-money-title">
    <img class="ranking-logo" src="images/ranking/rankingMoneyLogo.png" alt="logo ranking forrados">
    <span>RANKING<br>DE GANANCIAS</span>
  </div>
  <div class="user-data user-money-data">
    <div class="user-position">{{myMoneyData['position']}}º</div>
    <div class="user-name">{{profileService.user.nickName}}</div>
    <div class="user-points">{{myMoneyData['points']}}</div>
  </div>
  <leaderboard-table minimized show-header="false" table-elements="moneyUserList" rows="3"></leaderboard-table>
  <button class="ranking-button" ng-click="showFullMoneyRanking()"> VER COMPLETO</button>
</div>

"""));
tc.put("packages/webclient/components/legalese_and_help/help_info_comp.html", new HttpResponse(200, r"""<div id="helpInfo">

  <!-- header title -->
  <div class="default-section-header">{{getLocalizedText('title')}}</div>

  <!-- Nav tabs -->
  <!--ul class="help-info-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('tutorial-content')">{{getLocalizedText('tutorials')}}</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('how-works-content')">{{getLocalizedText('how-it-works')}}</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('rules-scores-content')">{{getLocalizedText('rules')}}</a></li>
  </ul-->

  <div class="tab-pane active" id="tutorial-content">
    <div class="block-light">
      <tutorials-comp></tutorials-comp>
    </div>
  </div>

  <!--div class="tab-pane" id="how-works-content">
    <how-it-works></how-it-works>
  </div-->
  
  <!--div class="tab-pane" id="rules-scores-content">
    <!--div class="block-dark">
      <div class="title">SCORING AND RULES</div>
      <div class="scores-wrapper">
        <scoring-rules></scoring-rules>
      </div>
    </div-->
    <!--rules-comp></rules-comp>
  </div-->

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
  <!--div class="tutorial-tile">
    <h1 class="tutorial-title">{{getLocalizedText("rankings")}}</h1>
    <span class="incoming">{{getLocalizedText("incoming")}}</span>
  </div-->
  <div class="tutorial-tile">
    <h1 class="tutorial-title">{{getLocalizedText("how-to-play")}}</h1>
    <!--p class="tutorial-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p-->
    <button type="button" class="button-go-tutorial" ng-click="goToHowToPlay()">{{getLocalizedText("go-to-help")}}</button>
  </div>
</div>"""));
tc.put("packages/webclient/components/lobby_comp.html", new HttpResponse(200, r"""<!-- Lista de concursos -->
<section class="contest-list-wrapper">
    <contests-list  id="activeContestList"
                  contests-list="currentContestList"
                  on-action-click='onActionClick(contest)'
                  on-row-click="onRowClick(contest)"
                  action-button-title="'>'"
                  show-date="true"
                  ng-show="!isContestListEmpty">
    </contests-list>
    <div class="no-contests-wrapper" ng-show="isContestListEmpty">
      <img class="no-contests-icon" src="images/icon-lobby-vacio.png">
      <div class="no-contests-title">Todos los torneos están llenos<br>Disculpa las molestias</div>
      <div class="no-contests-subtitle">Puedes crear tu propio torneo retando a tus amigos</div>
    </div>
</section>

<!-- Descomentar cuando hablitemos la funcionalidad de crear torneos -->
<button class="create-custom-contest-button" ng-click="onCreateContestClick()">{{getStaticLocalizedText("challengeyourfriendsbutton")}}</button>

<!-- Punto de insercion de nuestra ruta hija contest-info (modal)
<ng-view  ng-show="!loadingService.isLoading"></ng-view> -->
"""));
tc.put("packages/webclient/components/modal_comp.html", new HttpResponse(200, r"""<div id="modalRoot" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-{{modalSize}}">
    <div class="modal-content">
      <content></content>
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/my_contests_comp.html", new HttpResponse(200, r"""
<!-- LIVE CONTESTS -->
<section class="contest-list-section" id="live-contest-content"  ng-if="tabIsLive">
  <!-- Barra de resumen de actividad -->
  <div class="resume-bar">
    <div class="information-no-contest">{{liveContestsMessage}}</div>
  </div>

  <div ng-switch="hasLiveContests" class="contest-list-wrapper">
    <!-- lista vacía -->
    <div class="no-contests-wrapper" ng-switch-when="false">
        <img class="no-contests-icon" src="images/icon-torneo-vivo-vacio.png">
        <div class="no-contests-title">No estás jugando ningún torneo en este momento</div>
        <div class="no-contests-subtitle">Échale un vistazo a los próximos torneos<br>para ver cuando empiezan</div>
        <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
    </div>
    <!-- lista de concursos -->
    <div class="list-container" ng-switch-when="true">
      <contests-list id="liveContests" contests-list="contestsService.liveContests" show-date="false" 
                     sorting="liveSortType" on-action-click='onLiveActionClick(contest)' on-row-click='onLiveActionClick(contest)'>
      </contests-list>
    </div>
  </div>
</section>

<!-- WAITING CONTESTS -->
<section class="contest-list-section" id="waiting-contest-content" ng-if="tabIsWaiting">
  <div class="resume-bar">
    <div class="information-no-contest">{{waitingContestsMessage}}</div>
  </div>
 
  <div ng-switch="hasWaitingContests" class="contest-list-wrapper">
    <!-- lista vacía -->
    <div class="no-contests-wrapper" ng-switch-when="false">
        <img class="no-contests-icon" src="images/icon-torneo-proximo-vacio.png">
        <div class="no-contests-title">NO ESTÁS PARTICIPANDO EN NINGÚN TORNEO</div>
        <div class="no-contests-subtitle">Ve a la lista de torneos, elije uno y empieza a jugar</div>
        <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
    </div>
    <!-- lista de concursos -->
    <div class="list-container" ng-switch-when="true">
      <contests-list id="waitingContests" contests-list='contestsService.waitingContests' show-date="true"
                     sorting="waitingSortType" on-action-click='onWaitingActionClick(contest)' on-row-click='onWaitingActionClick(contest)'>
      </contests-list>
    </div>
  </div>
</section>

<!-- HISTORY CONTESTS -->
<section class="contest-list-section" id="history-contest-content" ng-if="tabIsHistory">
  <div class="resume-bar">
    <div class="information-no-contest">{{historyContestsMessage}}</div>
  </div>

  <div ng-switch="hasHistoryContests" class="contest-list-wrapper">
    <!-- lista vacía -->
    <div class="no-contests-wrapper" ng-switch-when="false">
        <img class="no-contests-icon" src="images/icon-torneo-historico-vacio.png">
        <div class="no-contests-title">aún no has jugado ningún torneo<br>¿A qué esperas para empezar a ganar?</div>
        <div class="no-contests-subtitle">Ve a lista de torneos, elije uno y empieza a jugar</div>
        <button class="btn-go-to-contest" ng-click="gotoLobby()">{{getLocalizedText("tocontest")}}</button>
    </div>
    <!-- lista de concursos -->
    <div class="list-container" ng-switch-when="true">
      <contests-list id="historyContests" contests-list="contestsService.historyContests" show-date="true"
                     sorting="historySortType" on-action-click='onHistoryActionClick(contest)' on-row-click='onHistoryActionClick(contest)'>
      </contests-list>
    </div>
  </div>
</section>
"""));
tc.put("packages/webclient/components/navigation/deprecated_version_screen_comp.html", new HttpResponse(200, r"""<div class="deprecated-version-screen-wrapper" ng-if="show">
  <div class="deprecated-version-screen">
    <img src="images/logoE11.png"></img>
    <h1>{{getLocalizedText("title")}}</h1>
    <!--p>{{getLocalizedText("body")}}</p-->
    <button ng-click="goShop()">{{getLocalizedText("button")}}</button>
  </div>
</div>"""));
tc.put("packages/webclient/components/navigation/secondary_tab_bar_comp.html", new HttpResponse(200, r"""<div class="secondary-tab-bar-wrapper" ng-if="tabs != null && tabs.length > 0">
    <div ng-repeat="tab in tabs" class="secondary-tabbar-tab" ng-class="[nTabsClass, (tab.isActive() ? 'active' : '')]" ng-click="tab.action()" ng-bind-html-unsafe="tab.text"> 
    </div>
</div>"""));
tc.put("packages/webclient/components/navigation/tab_bar_comp.html", new HttpResponse(200, r"""<div class="tab-bar-wrapper" ng-if="isShown">
  
  <div class="tab-bar-item" ng-click="homeTab.goLocation()" ng-class="{'active': homeTab.isActive}">
    <img ng-src="{{homeTab.iconImage}}">
    <span class="tab-bar-item-name">{{homeTab.name}}</span>
  </div>
 
  <div class="tab-bar-item" ng-click="myContest.goLocation()" ng-class="{'active': myContest.isActive}">
    <img ng-src="{{myContest.iconImage}}">
    <span class="tab-bar-item-name">{{myContest.name}}</span>
    <span class="tab-bar-item-badge" ng-class="{'has-notifications': myContest.notificationsCount > 0}">{{myContest.notificationsCount}}</span>
  </div>
  
  <div class="tab-bar-item" ng-click="contestsTab.goLocation()" ng-class="{'active': contestsTab.isActive}">
    <img ng-src="{{contestsTab.iconImage}}">
    <span class="tab-bar-item-name">{{contestsTab.name}}</span>
    <span class="tab-bar-item-badge" ng-class="{'has-notifications': contestsTab.notificationsCount > 0}">{{contestsTab.notificationsCount}}</span>
  </div>
  
  <div class="tab-bar-item" ng-click="liveContestTab.goLocation()" ng-class="{'active': liveContestTab.isActive}">
    <img ng-src="{{liveContestTab.iconImage}}">
    <span class="tab-bar-item-name">{{liveContestTab.name}}</span>
    <span class="tab-bar-item-badge" ng-class="{'has-notifications': liveContestTab.notificationsCount > 0}">{{liveContestTab.notificationsCount}}</span>
  </div>
 
  <div class="tab-bar-item" ng-click="leaderTab.goLocation()" ng-class="{'active': leaderTab.isActive}">
    <img ng-src="{{leaderTab.iconImage}}">
    <span class="tab-bar-item-name">{{leaderTab.name}}</span>
    <span class="tab-bar-item-badge" ng-class="{'has-notifications': leaderTab.notificationsCount > 0}">{{leaderTab.notificationsCount}}</span>
  </div>
  
</div>"""));
tc.put("packages/webclient/components/navigation/top_bar_comp.html", new HttpResponse(200, r"""<div class="columns-layout" ng-class="[layoutCssClass, specialLayoutClass]">
  <div class="left-column" ng-bind-html-unsafe="leftColumnHTML" ng-click="onLeftColumnClick()" ></div>
  <div class="main-column" ng-if="!currentState.isSearching" ng-bind-html-unsafe="centerColumnHTML" ng-click="onCenterColumnClick()"></div>
  <div class="main-column search-mode" ng-if="currentState.isSearching">
    <input id="topBarSearchField" type="text" class="search-field" ng-model="searchValue" placeholder="Buscar" autofocus>
  </div>
  <div class="right-column" ng-bind-html-unsafe="rightColumnHTML" ng-click="onRightColumnClick()"></div>
</div>

<modal-window title="'Mensajes de futbolcuatro'" show-window="notificationsActive" ng-class="{'small' : !hasNotification}">
  <notifications ng-if="notificationsActive"></notifications>
</modal-window>

<modal-window show-header="false" show-window="changeNameWindowShow" class="small first-nickname-change">
  <span class="first-nickname-label">Elige tu nombre</span>      
  <input class="first-nickname-input" type="text" maxlength="{{MAX_NICKNAME_LENGTH}}" ng-model="editedNickName" 
         placeholder="nombre de usuario" class="form-control" autocapitalize="off" autofocus>
  <!-- Error de nickName -->
  <div class="nickname-error-container">
    <div class="nickname-error-text">{{nicknameErrorText}}</div>
  </div>
  <div class="nickname-change-actions-wrapper">
    <button class="nickname-change-confirm" ng-click="saveChanges()" ng-disabled="editedNickName.length < MIN_NICKNAME_LENGTH">Confirmar</button>
  </div>
</modal-window>

<pages-tutorial-initial></pages-tutorial-initial>"""));
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
tc.put("packages/webclient/components/scouting/scouting_comp.html", new HttpResponse(200, r"""<section class="favorites-wrapper" ng-show="isSoccerPlayerListActive" >

            <scouting-league team-list="teamListES" 
                             soccer-player-list="allSoccerPlayersES" 
                             on-action-button="onFavoritesChange(soccerPlayer)"
                             on-info-button = "onSoccerPlayerInfo(soccerPlayer)"
                             id-sufix="'ES'"
                             favorites-player-list="favoritesPlayers"
                             filter-pos="fieldPosFilter"
                             only-favorites="onlyFavorites"
                             name-filter="nameFilter"></scouting-league>
            <!--scouting-league team-list="teamListUK" 
                             soccer-player-list="allSoccerPlayersUK" 
                             on-action-button="onFavoritesChange(soccerPlayer)"
                             on-info-button = "onSoccerPlayerInfo(soccerPlayer)"
                             id-sufix="'UK'"
                             favorites-player-list="favoritesPlayers"
                             filter-pos="fieldPosFilter"
                             only-favorites="onlyFavorites"></scouting-league-->
</section>

<!-- SOCCER PLAYER STATS -->
<section class="soccer-player-list-section" ng-if="isSoccerPlayerStatsActive">
  <soccer-player-stats action-mode="statsMode" instance-soccer-player-id="selectedPlayerId" selectable-player="isCurrentSelectedFavorite" on-action-click="addToFavorites(playerId)"></soccer-player-stats>
</section>"""));
tc.put("packages/webclient/components/scouting/scouting_league_comp.html", new HttpResponse(200, r""" <soccer-players-scalinglist  soccer-players="allSoccerPlayers"
                              lineup-filter="favoritesPlayers"
                              manager-level="10"
                              favorites-list="favoritesPlayers" 
                              only-favorites="onlyFavorites"
                              field-pos-filter="fieldPosFilter" 
                              name-filter="nameFilter" 
                              match-filter="teamFilter"
                              on-info-click="onRowClick(soccerPlayerId)"
                              on-action-click="onSoccerPlayerActionButton(soccerPlayer)"
                              is-scouting-list="true"></soccer-players-scalinglist>"""));
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
  <!--div class="facebook-like"  ng-show="showLike">
    <fb:like class="facebook-like-xfbml" href="https://www.facebook.com/Futbolcuatro" layout="button_count" action="like" />
  </div-->
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
  <twitter-button class="twitter-share-button-wrapper" ng-click="onTweet()">
    <span class="twitter-share-button"><img src="images/twitterTransparentBG.png">Tweet</span>
  </twitter-button>
  <twitter-button class="twitter-share-button-wrapper" ng-click="onFollow()" ng-if="showLike">
    <span class="twitter-share-button"><img src="images/twitterTransparentBG.png">Follow</span>
  </twitter-button>
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
          <button class="change-btt" ng-if="playerIsChangeable(slot) || playerIsChanging(slot)" ng-disabled="changingSoccerId != null && slot['id'] != changingSoccerId" ng-click="requestChange(slot)"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span></button>
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
tc.put("packages/webclient/components/view_contest/user_shortinfo_bar_comp.html", new HttpResponse(200, r"""<div class="user-shortinfo-name-column">
  <div class="user-shortinfo-header">
    Tiempo Restante: {{percentLeft}}
  </div>
  <div class="user-shortinfo-data">
    {{name}}
  </div>
</div>

<div class="user-shortinfo-rank-column">
  <div class="user-shortinfo-header">
    Clas.
  </div>
  <div class="user-shortinfo-data">
    {{clasification}}º
  </div>
</div>

<div class="user-shortinfo-points-column">
  <div class="user-shortinfo-header">
    Puntos
  </div>
  <div class="user-shortinfo-data">
    {{points}}
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
tc.put("packages/webclient/components/view_contest/view_contest_comp.html", new HttpResponse(200, r"""
<!-- USER LINEUP SECTION -->
<section class="view-contest-section" ng-show="isLineupFieldContestEntryActive">
  <user-shortinfo-bar user="mainPlayer"></user-shortinfo-bar>
  
  <lineup-field-selector lineup-slots="lineupSlots"
                         on-lineup-slot-selected="onLineupSlotSelected(slotIndex)"
                         formation-id="formationId"
                         lineup-formation="lineupFormation"
                         formation-is-modifiable="false"
                         show-salary="displayChangeablePlayers"
                         is-live="true"
                         highlight-changeables="displayChangeablePlayers"></lineup-field-selector>
                         
  <button ng-if="isLive" ng-disabled="numAvailableChanges <= 0 || substituiblePlayersInLineup() == 0" class="make-change-btn" ng-click="switchDisplayChangeablePlayers()">{{changesButtonText()}} <i class="material-icons">&#xE8D5;</i></button>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableCurrentSalary)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>

<!-- CONTEST INFO SECTION -->
<section class="contest-info-section" ng-show="isContestInfoActive">
  <contest-info the-contest="contest" ng-if="contest != null"></contest-info>
</section>

<!-- RIVALS SECTION -->
<section class="rivals-list-section" ng-if="isRivalsListActive">
  <div class="rivals-list-table-header">
    <div class="rivals-list-column-position">Pos.</div>
    <div class="rivals-list-column-name">Nombre</div>
    <div class="rivals-list-column-timeleft">T.R.</div>
    <div class="rivals-list-column-points">Puntos</div>
  </div>
  <div class="rivals-list-table-body">
    <div class="rivals-list-table-row" ng-repeat="rival in rivalList" ng-class="{'current-user-row': isMainPlayer(rival)}" ng-click="onUserClick(rival)">
      <div class="rivals-list-column-position">{{ $index + 1 }}</div>
      <div class="rivals-list-column-name">{{name(rival)}}</div>
      <div class="rivals-list-column-timeleft">{{percentLeft(rival)}}</div>
      <div class="rivals-list-column-points">{{points(rival)}}</div>
    </div>
  </div>
</section>

<!-- COMPARE LINEUPS SECTION -->
<section class="view-comparative-section" ng-show="isComparativeActive">
  <user-shortinfo-bar user="selectedOpponent"></user-shortinfo-bar>
  
  <lineup-field-selector lineup-slots="opponentLineupSlots"
                         on-lineup-slot-selected="onOpponentLineupSlotSelected(slotIndex)"
                         formation-id="opponentFormationId"
                         lineup-formation="opponentLineupFormation"
                         formation-is-modifiable="false"
                         show-salary="false"
                         is-live="true"></lineup-field-selector>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount">{{formatCurrency(printableOpponentSalary)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>

<!-- SOCCER PLAYER LIST -->
<section class="soccer-player-list-section" ng-if="isSelectingSoccerPlayerActive">
  <soccer-players-scalinglist soccer-players="allSoccerPlayers"
                              lineup-filter="lineupSlots"
                              manager-level="playerManagerLevel"
                              contest="contest"
                              favorites-list="favoritesPlayers"
                              only-favorites="onlyFavorites"
                              field-pos-filter="fieldPosFilter"
                              name-filter="nameFilter"
                              match-filter="matchFilter"
                              on-info-click="onSoccerPlayerInfoClick(soccerPlayerId)"
                              on-action-click="onSoccerPlayerActionButton(soccerPlayer)"></soccer-players-scalinglist>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableSalaryForChange)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>


<!-- SOCCER PLAYER STATS -->
<section class="soccer-player-list-section" ng-show="isSoccerPlayerStatsActive">
  <soccer-player-stats contest-id="contest.contestId" instance-soccer-player-id="instanceSoccerPlayerDisplayInfo" selectable-player="false"></soccer-player-stats>
</section>


<modal-window class="soccer-player-gameplays small" show-header="true" title="'Puntos de jugador'" show-window="isGameplaysModalOn">
  <div class="soccer-player-gameplays-name">
    <div class="gameplays-label">{{gameplaysPlayer.name}}</div>
    <div class="gameplays-data">{{gameplaysPlayer.livePoints}}</div>
  </div>
  <div class="soccer-player-gameplays-data" ng-repeat="gameplay in soccerPlayerGameplays">
    <div class="gameplays-label">{{gameplay['name']}}</div>
    <div class="gameplays-data">{{gameplay['points']}}</div>
  </div>
</modal-window>

<modal-window class="change-soccer-player-confirm-modal small" show-header="false" show-window="isConfirmModalOn">
  <div class="change-soccer-player-confirm-content">
    <p class="change-soccer-player-confirm-question">{{getLocalizedText('change-player-modal')}}</p>
    <div class="change-soccer-player-changing-players">
      <div class="change-soccer-player-changing-labels">
        <span class='change-soccer-player player-old' ng-if="changingPlayer != null">sale</span>
        <span class='change-soccer-player player-new' ng-if="newSoccerPlayer != null">entra</span>
      </div>
      <div class="change-soccer-player-changing-data">
        <span class='change-soccer-player player-old' ng-if="changingPlayer != null">{{changingPlayer.soccerPlayer.name}}</span>
        <i class="material-icons">&#xE8D5;</i>
        <span class='change-soccer-player player-new' ng-if="newSoccerPlayer != null">{{newSoccerPlayer.soccerPlayer.name}}</span>
      </div>
    </div>
  </div>
  <div class="change-soccer-player-actions-wrapper">
    <button class="change-soccer-player-cancel" ng-click="hideConfirmModal()">Cancelar</button>
    <button class="change-soccer-player-confirm" ng-click="makeSoccerPlayerSubstitution()">Realizar Sustitución</button>
  </div>
</modal-window>

<!--section>

  <contest-header id="contestHeader" contest="contest" contest-id="contestId" match-filter="matchFilter" show-filter="isMakingChange"></contest-header>

  <div id="viewContestRoot" ng-switch="scrDet.isXsScreen" ng-class="{ 'making-change-state': isMakingChange }">
    <div ng-switch-when="true">
     <!-- Tabs de la versión XS ->
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
      <!--div class="contest-id">CHANGES AVAILABLE: {{numAvailableChanges}} || SALARY: {{remainingSalary}} ({{lineupCost}}/{{maxSalary}}) || PLAYER: {{changingSalaryPlayer}} || ID: {{contest.contestId.toUpperCase()}}</div->
      <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
    </div>
    <div class="clear-fix-bottom"></div>
  </div>

</section>

<ng-view></ng-view-->
"""));
tc.put("packages/webclient/components/view_contest/view_contest_entry_comp.html", new HttpResponse(200, r"""<!--section ng-show="!loadingService.isLoading"-->

<section class="contest-entry-section" ng-show="isLineupFieldContestEntryActive">
  <div class="edit-contest-entry-tip">
    {{getLocalizedText("tip")}}
    <button class="view-contest-entry-invite-friends" ng-click="inviteFriends()">Invita a tus amigos <i class="material-icons">&#xE7F0;</i></button>
  </div>
  <!--button class="confirm-btn" ng-click="createFantasyTeam()">Modificar</button-->
  <lineup-field-selector lineup-slots="lineupSlots"
                         on-lineup-slot-selected="onLineupSlotSelected(slotIndex)"
                         formation-id="formationId"
                         lineup-formation="lineupFormation"
                         formation-is-modifiable="false"></lineup-field-selector>
                         
  <button class="confirm-btn" ng-click="editTeam()">Modificar</button>
  <div class="salary-info-wrapper">
    <div class="current-salary"><span class="current-salary-label">Presupuesto </span><span class="current-salary-amount" ng-class="{'red-numbers': availableSalary < 0 }">{{formatCurrency(printableCurrentSalary)}}</span></div>
    <div class="limit-salary"><span class="limit-salary-label">Límite </span><span class="limit-salary-amount">{{formatCurrency(printableSalaryCap)}}</span></div>
  </div>
</section>

<section class="contest-info-section" ng-show="isContestInfoActive">
  <contest-info the-contest="contest" ng-if="contest != null"></contest-info>
</section>
  <!--contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header-->
  
  <!--<div class="separator-bar"></div>-->
  <!--div class="info-complete-bar" ng-if="!isModeViewing">
    <p class="important-info" ng-if="isModeCreated">{{getLocalizedText("created")}}</p>
    <p class="important-info" ng-if="isModeEdited">{{getLocalizedText("edited")}}</p>
    <p class="important-info" ng-if="isModeSwapped">{{getLocalizedText("swapped")}}</p>
    <h2 ng-if="showInviteButton" ng-click="onInviteFriends()" class="invite-friends">{{getLocalizedText("invite_text")}}</h2>
    <p class="complementary-info">{{getLocalizedText("tip")}}</p>
  </div-->
  
  
  <!--friends-bar user-list="filteredFriendList" on-challenge="onChallenge(user)"></friends-bar-->
  
  
  <!--div id="viewContestEntry" ng-switch="scrDet.isXsScreen" >
    <div ng-switch-when="true">
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
      <div class="new-row">
        <div class="autocentered-buttons-wrapper">
          <div ng-if="scrDet.isXsScreen" class="button-box"><button type="button" class="ok-button" ng-click="goToParent()">{{getLocalizedText("backtocontests")}}</button></div>
          <div ng-if="!scrDet.isXsScreen" class="button-box ok"><button type="button" class="ok-button" ng-click="goToParent()">{{getLocalizedText("backtocontests")}}</button></div>
        </div>
      </div>

    </div>
  </div-->
  
  <!--div class="share-methods-modal-content" id="shareMethodsContent">
    <div class="share-method">
      <p>Puedes compartir el enlace del torneo en tu perfil de Facebook</p>
      <social-share parameters-by-map="sharingInfo" inline inline-xs></social-share>
    </div>
    <div class="share-method">
      <p>o enviarlo por mail a los amigos que quieras.</p>
      <p class="important">Copia y envia este enlace a tus amigos</p>
      <input class="share-url" type="text" ng-if="contest != null" rows="1" 
             ng-keyup="onShareTextareaFocus($event)" ng-keydown="onShareTextareaFocus($event)" 
             ng-mouseup="onShareTextareaFocus($event)" ng-click="onShareTextareaFocus($event)"
             ng-focus="onShareTextareaFocus($event)" ng-model="inviteUrl" readonly autofocus>
    </div>
  </div-->
  
<!--ng-view></ng-view-->
<!--/section-->"""));
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
tc.put("packages/webclient/tutorial/pages_tutorial_initial.html", new HttpResponse(200, r"""<modal-window show-header="false" show-window="showTutorial" class="fullscreen pages-tutorial-initial-modal">
  <div class="tutorial-initial-slides-title"><span>Jugar es muy sencillo</span><i class="material-icons" ng-click="close()">&#xE14C;</i></div>
  <div class="tutorial-initial-slide tutorial-initial-slide-1" ng-show="currentSlide == 'tutorialInitialSlide_1'">
    <div class="tutorial-initial-slide-upper-text">
      <div class="tutorial-initial-slide-ordinal">1</div>
      <div class="tutorial-initial-slide-short-hint">Elige un torneo</div>
    </div>
    <div class="tutorial-initial-slide-image"><img src="images/tutorial/Help01.gif"></div>
    <div class="tutorial-initial-slide-long-hint"></div>
  </div>
  <div class="tutorial-initial-slide tutorial-initial-slide-2" ng-show="currentSlide == 'tutorialInitialSlide_2'">
    <div class="tutorial-initial-slide-upper-text">
      <div class="tutorial-initial-slide-ordinal">2</div>
      <div class="tutorial-initial-slide-short-hint">Haz tu alineación</div>
    </div>
    <div class="tutorial-initial-slide-image"><img src="images/tutorial/Help02.gif"></div>
    <div class="tutorial-initial-slide-long-hint">No puedes superar el presupuesto ni alinear mas de 4 futbolistas de un mismo equipo</div>
  </div>
  <div class="tutorial-initial-slide tutorial-initial-slide-3" ng-show="currentSlide == 'tutorialInitialSlide_3'">
    <div class="tutorial-initial-slide-upper-text">
      <div class="tutorial-initial-slide-ordinal">3</div>
      <div class="tutorial-initial-slide-short-hint">Puntúa y gana</div>
    </div>
    <div class="tutorial-initial-slide-image">
      <div class="tutorial-initial-slide-3-live">
        <img src="images/tabBar/Button_Lives.png">
        <span>Sigue los partidos<br>en tiempo real.</span>
      </div>
      <div class="tutorial-initial-slide-3-history">
        <i class="material-icons">&#xE889;</i>
        <span>Consulta los resultados definitivos en el historico.</span>
      </div>
    </div>
    <div class="tutorial-initial-slide-long-hint"></div>
  </div>
  <div class="tutorial-initial-nav">
    <i class="tutorial-initial-nav-arrow material-icons" ng-click="previousSlide()">{{currentSlide != 'tutorialInitialSlide_1'? "&#xE5C4;" : ""}}</i>
    <div class="tutorial-initial-nav-options-wrapper">
      <input class="tutorial-initial-nav-option" id="tutorialInitialNavSlide1" type="radio" name="tutorialInitialNavSlide1" value="tutorialInitialSlide_1" ng-model="currentSlide">
      <label for="tutorialInitialNavSlide1"><span></span></label>
      
      <input class="tutorial-initial-nav-option" id="tutorialInitialNavSlide2" type="radio" name="tutorialInitialNavSlide2" value="tutorialInitialSlide_2" ng-model="currentSlide">
      <label for="tutorialInitialNavSlide2"><span></span></label>
      
      <input class="tutorial-initial-nav-option" id="tutorialInitialNavSlide3" type="radio" name="tutorialInitialNavSlide3" value="tutorialInitialSlide_3" ng-model="currentSlide">
      <label for="tutorialInitialNavSlide3"><span></span></label>
    </div>
    <i class="tutorial-initial-nav-arrow material-icons" ng-click="nextSlide()">{{(currentSlide != 'tutorialInitialSlide_3'?  '&#xE5C8;' : '&#xE5CA;')}}</i>
  </div>
</modal-window>"""));
tc.put("packages/webclient/utils/modal_window.html", new HttpResponse(200, r"""<div class="modal-window-frame">
  <div class="modal-window-header" ng-if="showHeader">
    <div class="modal-window-title">{{title}}</div>
    <div class="modal-window-close-btt" ng-click="close()"><i class="material-icons">&#xE14C;</i></div>
  </div>
  <div class="modal-window-content">
    <content></content>
  </div>
</div>"""));
}