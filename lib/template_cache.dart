// GENERATED, DO NOT EDIT!
library template_cache;

import 'package:angular/angular.dart';

primeTemplateCache(TemplateCache tc) {
tc.put("packages/webclient/components/account/change_password_comp.html", new HttpResponse(200, r"""<div id="changePasswordRoot">
  <div id="loginBox" class="main-box">

    <div class="panel window-slide-in">

      <!-- Header -->
      <div class="panel-heading">
        <div ng-switch="state">
          <!-- SI ES INVALID URL -->
          <div ng-if="state=='STATE_INVALID_URL'"     class="panel-title">Error 404</div>
          <!-- SI ES TOKEN INVALIDO -->
          <div ng-if="state=='STATE_INVALID_TOKEN'"   class="panel-title">CAMBIO DE CONTRASEÑA</div>
          <!-- SI ES TOKEN VALIDO/INVALIDO -->
          <div ng-if="state=='STATE_CHANGE_PASSWORD'" class="panel-title">CAMBIO DE CONTRASEÑA</div>
        </div>

        <button type="button" class="close" ng-click="navigateTo('landing_page',{}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>

      </div>
      <div class="panel-body" ng-cloak>
        <div ng-if="state=='STATE_INVALID_URL'">
          La página solicitada no está disponible
        </div>
        <div ng-if="state=='STATE_INVALID_TOKEN'">
          El token proporcionado no es válido o ha expirado.
        </div>
        <form  ng-if="state=='STATE_CHANGE_PASSWORD'" id="loginForm" class="form-horizontal" ng-submit="changePassword()" data-toggle="validator" role="form" formAutofillFix>

          <div class="form-description">Introduce tu cuenta de correo electrónico y tu contraseña para acceder a los torneos.</div>

          <!-- PÂSSWORD -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
            <input id="password" type="password" ng-model="password" name="password" placeholder="password" autofocus class="form-control" tabindex="1">
          </div>

          <!-- RE PASSWORD -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
            <input id="rePassword" type="password" ng-model="rePassword" name="password" placeholder="repetir password" class="form-control" tabindex="2">
          </div>

          <!-- Error de password -->
          <div class="input-group"  ng-class="{'error-visible' : !errorDetected}">
            <div class="new-row">
              <div id="passError" class="pass-err-text ">{{errorMessage}}</div>
            </div>
          </div>

          <!-- BUTTONS -->

          <div class="input-group">
            <div class="new-row">
              <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">ENTRAR</button>
              <button id="btnCancelLogin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCELAR</button>
            </div>
          </div>

        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/edit_personal_data_comp.html", new HttpResponse(200, r"""<div id="personalDataContent" ng-show="!loadingService.isLoading">

  <div class="edit-personal-data-modal-header">
    <span class="header-title">EDITAR CUENTA</span>
    <button type="button" class="close" ng-click="closeModal()" aria-hidden="true">
      <span class="glyphicon glyphicon-remove"></span>
    </button>
  </div>
  <form id="editPersonalDataForm" class="form-horizontal" ng-submit="saveChanges()" data-toggle="validator" role="form" formAutofillFix>
    <div class="content">
      <!-- Nombre -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtName" auto-focus type="text" ng-model="parent.editedFirstName" name="firstName" placeholder="Nombre" class="form-control"  tabindex="1"></div>
      </div>
      <!-- Apelidos -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtLastName" type="text" ng-model="parent.editedLastName" name="lastName" placeholder="Apellidos" class="form-control" tabindex="2"></div>
      </div>
      <!-- Nickname -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtNickName" type="text" ng-model="parent.editedNickName" name="nickName" placeholder="Nombre de usuario" class="form-control" tabindex="3"></div>
        <!-- Error de mail -->
        <div class="content-field"       ng-class="{'hidden':!parent.hasNicknameError}">
          <div id="nickNameError" class="join-err-text" ng-class="{'errorDetected':parent.hasNicknameError}">{{parent.nicknameErrorText}}</div>
        </div>
      </div>

      <!-- Correo Electrónico -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtEmail" type="email" ng-model="parent.editedEmail" name="email" placeholder="Email" class="form-control" tabindex="4"></div>
        <!-- Error de mail -->
        <div class="content-field"       ng-class="{'hidden':!parent.hasEmailError}">
          <div id="emailError" class="join-err-text" ng-class="{'errorDetected':!parent.hasEmailError}">{{parent.emailErrorText}}</div>
        </div>
      </div>

      <!-- Label Contraseña -->
      <div class="content-field-block">
        <div class="control-wrapper"><span id="lblPassword" class="text-label">Contraseña: Rellena los campos de contraseña para actualizar tu contraseña</span></div>
      </div>
      <!-- Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtPassword" type="password" ng-model="parent.editedPassword" name="password" placeholder="Contraseña" class="form-control" tabindex="5"></div>
        <!-- Error de contraseñas -->
        <div class="content-field-block" ng-class="{'hidden':!parent.hasPasswordError}">
          <div id="passwordError" class="join-err-text"  ng-class="{'errorDetected':parent.hasPasswordError}">{{parent.passwordErrorText}}</div>
        </div>
      </div>
      <!-- Repetir Contraseña -->
      <div class="content-field">
        <div class="control-wrapper"><input id="txtRepeatPassword" type="password" ng-model="parent.editedRepeatPassword" name="repeatPassword" placeholder="Repetir Contraseña" class="form-control" tabindex="6"></div>
      </div>

      <!-- Label Instrucciones contraseña -->
      <div class="content-field-block">
        <div class="control-wrapper"><span id="lblPasswordIntructions" class="text-label">Asegúrate al menos que tiene 8 caracteres y que no contiene espacios</span></div>
      </div>
      <!-- Pais, Region y Ciudad
      <div class="content-field">
        <div class="control-wrapper"><input id="txtCountry" type="text" ng-model="country" name="contry" placeholder="País" class="form-control"></div>
      </div>

      <div class="content-field">
        <div class="control-wrapper"><input id="txtRegion" type="text" ng-model="region" name="region" placeholder="Región" class="form-control"></div>
      </div>

      <div class="content-field">
        <div class="control-wrapper"><input id="txtCity" type="text" ng-model="city" name="city" placeholder="Ciudad" class="form-control"></div>
      </div>
       -->
    </div>
  <!-- Notificaciones -->
    <div class="header">NOTIFICACIONES</div>
    <div class="subscriptions-content">

      <div class="content-field-block">

        <div class="subscription-wrapper">
          <div class="subscription-label">NEWSLETTER/OFERTAS ESPECIALES</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchNewsletter" id="inputNewsletter"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">NOTIFICACIONES DE JUEGO</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchGameAlerts"> </div>
        </div>

        <div class="subscription-wrapper">
          <div class="subscription-label">NOTIFICACIONES DE TUS FICHAJES</div>
          <div class="check-wrapper"> <input type="checkbox" name="switchsoccerPlayerAlerts"> </div>
        </div>

      </div>

    </div>

    <div class="save-changes-content">
      <button id="btnSubmit" class="action-button" type="submit">GUARDAR CAMBIOS</button>
    </div>
  </form>
</div>"""));
tc.put("packages/webclient/components/account/join_comp.html", new HttpResponse(200, r"""<div id="joinRoot" ng-show="!loadingService.isLoading">
  <div id="signupbox" class="main-box">

    <div class="panel window-slide-in">

      <div class="panel-heading">
        <div class="panel-title">REGÍSTRATE</div>
        <button type="button" class="close" ng-click="navigateTo('landing_page', {}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" >

        <form id="signupForm" class="form-horizontal" ng-submit="submitSignup()" data-toggle="validator" role="form" formAutofillFix>
          <div class="form-description">¿Todavía no tienes cuenta en EPIC ELEVEN? Rellena los campos de este formulario para completar el registro. ¡Es muy sencillo!</div>
          <!-- USERNAME  -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-user"></div></span>
            <input id="nickName" auto-focus name="NickName" type="text" ng-model="nickName" placeholder="Nombre de usuario" class="form-control" data-toggle="validator" required=""  tabindex="1">
          </div>
          <!-- Error de username -->
          <div class="new-row">
            <div id="nickNameError" class="join-err-text">ERROR DE REGISTRO. El user name no es válido.</div>
          </div>
          <!-- EMAIL -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
            <input id="email" name="Email" type="email" ng-model="email" placeholder="Correo electrónico" class="form-control" data-toggle="validator" required=""  tabindex="2">
          </div>
          <!-- Error de mail -->
          <div class="new-row">
            <div id="emailError" class="join-err-text">ERROR DE REGISTRO. El mail no es válido.</div>
          </div>
          <!-- PASSWORD -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
            <input id="password" name="Password" type="password" ng-model="password" placeholder="Contraseña" class="form-control" data-toggle="validator" required="" data-minlength="8" ng-minlength="8"  tabindex="3">
          </div>

          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
            <input id="rePassword" name="RePassword" type="password" ng-model="rePassword" placeholder="Repite la contraseña " class="form-control" data-toggle="validator" required="" data-minlength="8" ng-minlength="8" tabindex="4">
          </div>
          <!-- Error de password -->
          <div class="new-row">
            <div id="passwordError" class="join-err-text">ERROR DE REGISTRO. El password no es válido.</div>
          </div>
          <!-- BUTTONS -->
          <div class="input-group">
            <div class="new-row">
              <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">REGÍSTRATE</button>
              <button id="btnCancelJoin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCELAR</button>
            </div>
          </div>
          <!-- GOTO REGISTER -->
          <div class="input-group">
            <div class="new-row">
              <div class="separator-top">¿Ya tienes cuenta? <a ng-click="navigateTo('login', {}, $event)"> Entra por aquí! </a></div>
            </div>
          </div>

        </form>

      </div>

    </div>

  </div>
</div>




"""));
tc.put("packages/webclient/components/account/login_comp.html", new HttpResponse(200, r"""<div id="loginRoot" ng-show="!loadingService.isLoading">
  <div id="loginBox" class="main-box">

    <div class="panel window-slide-in">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title">ENTRA</div>
        <button type="button" class="close" ng-click="navigateTo('landing_page',{}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" ng-cloak>

        <form id="loginForm" class="form-horizontal" ng-submit="login()" data-toggle="validator" role="form" formAutofillFix>

          <div class="form-description">Introduce tu cuenta de correo electrónico y tu contraseña para acceder a los torneos.</div>
          <!-- MAIL -->
          <div class="input-group">
            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
            <input id="login-mail" auto-focus type="email" ng-model="email" name="email" placeholder="Correo Electrónico" class="form-control" tabindex="1">
          </div>
          <!-- PÂSSWORD -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-lock"></div></span>
            <input id="login-password" type="password" ng-model="password" name="password" placeholder="password" class="form-control" tabindex="2">
          </div>
          <!-- REMEMBER ME -->
          <div class="remember-forgot-group">
            <!--<div class="checkbox">
              <label><input id="login-remember" type="checkbox" ng-model="rememberMe" name="rememberMe"> Recuerdame </label>
            </div>-->
            <div class="forget-pass">
              <a ng-click="navigateTo('remember_password', {}, $event)">¿Olvidaste tu contraseña?</a>
            </div>
          </div>
          <!-- BUTTONS -->
          <div class="input-group">
            <div class="new-row">
              <button type="submit" id="btnSubmit" name="JoinNow" ng-disabled="!enabledSubmit" class="enter-button-half">ENTRAR</button>
              <button id="btnCancelLogin" ng-click="navigateTo('landing_page', {}, $event)" class="cancel-button-half">CANCELAR</button>
            </div>
          </div>
          <!-- Error de login/password -->
          <div class="input-group">
            <div class="new-row">
              <div id="mailPassError" class="login-err-text">ERROR DE LOGIN. El mail y/o la contraseña no son correctos.</div>
            </div>
          </div>
          <!-- GOTO REGISTER -->
          <div class="input-group">
            <div class="new-row">
              <div class="separator-top">¿Aún no tienes cuenta? <a ng-click="navigateTo('join', {}, $event)"> Regístrate aquí! </a></div>
            </div>
          </div>
        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/remember_password_comp.html", new HttpResponse(200, r"""<div id="rememberPasswordRoot" ng-show="!loadingService.isLoading">
  <div id="loginBox" class="main-box">

    <div class="panel window-slide-in">

      <!-- Header -->
      <div class="panel-heading">
        <div class="panel-title" ng-class="{'center-text':state=='STATE_REQUESTED'}">RECORDAR CONTRASEÑA</div>
        <button ng-if="state=='STATE_REQUEST'" type="button" class="close" ng-click="navigateTo('login', {}, $event)">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>

      <div class="panel-body" ng-cloak>
        <div ng-if="state=='STATE_REQUESTED'">
          <div class="form-description">Se ha enviado tu petición. Revisa tu correo. <br><br>Ya puedes cerrar esta ventana.</div>
          <!-- GOTO REGISTER -->
          <!-- Esta ventana es el final del flow y queda muerta. por lo tanto no damos opción de linkar a otra parte.
          <div class="input-group">
            <div class="new-row">
              <a ng-click="navigateTo('join', {}, $event)"> Volver al inicio! </a>
            </div>
          </div>
          -->
        </div>
        <form ng-if="state=='STATE_REQUEST'" id="loginForm" class="form-horizontal" ng-submit="rememberMyPassword()" data-toggle="validator" role="form" formAutofillFix>

          <div class="form-description">¿Olvidaste tu contraseña? Introduce tu dirección de correo electrónico y recibirás un email para recuperar tu cuenta.</div>
          <!-- MAIL -->
          <div class="input-group">
            <span class="input-group-addon"><div class="glyphicon glyphicon-envelope"></div></span>
            <input id="email" auto-focus name="Email" type="email" ng-model="email" placeholder="Correo electrónico" class="form-control" data-toggle="validator"  tabindex="1">
          </div>
          <!-- Error de login/password -->
          <div class="input-group" ng-class="{'error-visible' : !errorDetected}">
            <div class="new-row">
              <div id="errLabel" class="login-err-text">Algo ha ido mal, revisa el correo electrónico que has introducido.</div>
            </div>
          </div>
          <!-- BUTTONS -->
          <div class="input-group">
            <div class="new-row">
              <button type="submit" id="btnSubmit" name="RememberPassword" ng-disabled="!enabledSubmit" class="enter-button-half">ENVIAR</button>
              <button id="btnCancelRemember" ng-click="navigateTo('login', {}, $event)" class="cancel-button-half">CANCELAR</button>
            </div>
          </div>

          <!-- GOTO REGISTER -->
          <div class="input-group">
            <div class="new-row">
              <div class="separator-top">¿Aún no tienes cuenta? <a ng-click="navigateTo('join', {}, $event)"> Regístrate aquí! </a></div>
            </div>
          </div>

        </form>

      </div>

    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/account/user_profile_comp.html", new HttpResponse(200, r"""<div id="viewProfileContent">
  <div class="default-header-text"> MI CUENTA </div>
  <div class="profile-content">

    <div class="personal-data">
      <div class="data-header"><span class="data-header-title">INFORMACION PERSONAL</span><button class="action-button" ng-click="editPersonalData()">EDITAR</button></div>
      <div class="bloque-sm">
        <div class="data-row"><span class="data-key">Nombre:</span><span class="data-value">{{userData.firstName + ' ' + userData.lastName}}</span></div>
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
    </div>

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

  </div>
</div>

<!-- Edit personal data fullScreen -->
<div id="editProfileContent">
  <edit-personal-data id="fullscreenEditPersonalDataForm"></edit-personal-data>
</div>

<!-- Edit personal data Modal -->
<div  id="editPersonalDataModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
      <div id="infoContent" class="modal-content">
        <edit-personal-data id="modalEditPersonalDataForm"></edit-personal-data>
      </div>
    </div>
</div>


"""));
tc.put("packages/webclient/components/contest_filters_comp.html", new HttpResponse(200, r"""<div id="contestSortsFilters">

  <!-- Resumen y Botón de filtros XS -->
  <div class="choosed-filters-container" ng-show="scrDet.isXsScreen">
      <div class="competition-filter-name" ng-bind-html="filterResume"></div>
      <div class="filterToggler">
        <div id="filtersButtonMobile" type="button" class="btn filters-button" ng-click="toggleFilterMenu()" data-toggle="collapse" data-target="#filtersPanel">filtros</div>
      </div>
  </div>

  <!-- Ordenación -->
  <div id="contestFastSort">
    <span class="filter-text">Ordenar por: </span>
    <div class="btn-group" >
      <div ng-repeat="button in sortingButtons" id="{{button['id']}}" type="button" class="btn sorting-button" ng-class="button['state']" ng-click="sortListByField(button['field-name'])">{{button["name"].toUpperCase()}}</div>
    </div>
  </div>

  <!-- Filtro por nombre -->
  <div id="contestFastSearch">
      <input class="searcher" type="text" placeholder="Buscar torneo" ng-model="filterContestName" ng-keyUp="filterByName()">
  </div>

  <div class="filterToggler" ng-show="!scrDet.isXsScreen">
      <div id="filtersButtonDesktop" type="button" class="btn filters-button" ng-click="toggleFilterMenu()" data-toggle="collapse">FILTROS</div>
  </div>

</div>

<div id="filtersPanel" class="collapse">

    <!-- Filtro x tipos de concurso -->
    <div class="filter-column-tournaments">
      <p class="filter-title">COMPETICION</p>
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
      <p class="filter-title">TORNEOS</p>
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
      <p class="filter-title">LÍMITE DE SALARIO</p>
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
      <p class="filter-title">ENTRADA</p>
      <div class="filter-content">
         <div class="entry-fee-value-min">MIN: {{filterEntryFeeRangeMin | number:0}}€ </div>
         <div class="entry-fee-value-max">MAX: {{filterEntryFeeRangeMax | number:0}}€ </div>
          <div class="slider-wrapper">
            <div id="slider-range"></div>
          </div>
      </div>
    </div>

    <div class="reset-button-wrapper">
      <button type="button" class="btn-reset" ng-click="resetAllFilters()">LIMPIAR FILTROS</button>
    </div>
    <div class="confirm-button-wrapper">
      <button type="button" class="btn-confirm" ng-click="toggleFilterMenu()">ACEPTAR</button>
    </div>
</div>"""));
tc.put("packages/webclient/components/contest_header_comp.html", new HttpResponse(200, r"""<div id="contestHeaderWrapper" ng-cloak ng-show="contest != null">

  <div class="contest-name">{{info['description']}}</div>
  <div class="contest-explanation">{{info['contestType']}} {{info['contestantCount']}}</div>
  
  <div class="contest-coins">
    <div class="contest-price">
      <div class="contest-coins-header">ENTRADA</div>
      <div class="contest-coins-content"><span>{{info['entryPrice']}}</span></div>
    </div>

    <div class="contest-prize">
      <div class="contest-coins-header">
        <div class="contest-coins-header-title">PREMIOS</div>
        <div class="contest-coins-header-prize-type">{{info['prizeType']}}</div>
      </div>
      <div class="contest-coins-content"><span>{{info['prize']}}</span></div>
    </div>      
  </div>

  <div class="contest-start-date">{{info['startTime']}}&nbsp;</div>
  <div class="countdown-text">
    <span class="text-countdown">{{info['textCountdownDate']}}&nbsp;</span>
    <span class="time-countdown">{{info['countdownDate']}}&nbsp;</span>
  </div>
  
  <div class="close-contest"><button type="button" class="close" ng-click="goToParent()"><span class="glyphicon glyphicon-remove"></span></button></div>
</div>

<div class="clearfix"></div>
"""));
tc.put("packages/webclient/components/contest_info_comp.html", new HttpResponse(200, r""" <div ng-if="isPopUp">
    <div class="modal-info-head">
        <div class="contest-info-header-row">

            <div class="column-name">
                <div class="inner-content">
                    <span class="title-text">{{currentInfoData['description']}}</span>
                    <span class="content-text">{{currentInfoData['name']}}</span>
                </div>
            </div>

            <div class="column-entry-fee">
                <!--<div class="inner-icon">
                    <span class="price-icon"></span>
                </div>-->
                <div class="inner-content">
                    <span class="title-text">ENTRADA</span>
                    <span class="content-text">{{currentInfoData['entry']}}€</span>
                </div>
            </div>

            <div class="column-prize">
                <div class="inner-icon">
                    <span class="prize-icon"></span>
                </div>
                <div class="inner-content">
                    <span class="title-text">PREMIOS</span>
                    <span class="content-text">{{currentInfoData['prize']}}€</span>
                </div>
            </div>

        </div>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
    </div>

    <div class="modal-info-content">

        <div class="tabs-background">
          <!-- Nav tabs -->
          <ul class="contest-info-tabs " id="modalInfoContestTabs">
              <li class="tab active"><a  data-toggle="tab" ng-click="tabChange('info')">INFORMACIÓN</a></li>
              <li class="tab"><a  data-toggle="tab" ng-click="tabChange('contestants')">PARTICIPANTES</a></li>
              <li class="tab"><a  data-toggle="tab" ng-click="tabChange('prizes')">PREMIOS</a></li>
              <li class="buton-place">
                <button id="btn-go-enter-contest" class="btn btn-primary" ng-click="enterContest()">ENTRAR</button>
              </li>
          </ul>
        </div>

        <div class="contest-info-content" id="modalInfoContestTabContent">
            <div class=" tab-content">

                <!-- Tab panes -->
                <div class="tab-pane active" id="info">
                    <p class="instructions">{{currentInfoData['rules']}}</p>
                    <div class="start-date">COMIENZA EL {{currentInfoData['startDateTime']}}</div>

                    <div class="matches-involved">
                        <div class="match"   ng-repeat="match in currentInfoData['matchesInvolved']">
                            <p class="teams">{{match.soccerTeamA.shortName}} - {{match.soccerTeamB.shortName}}</p>
                            <p class="date">{{formatMatchDate(match.startDate)}}</p>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <p class="bases-title">REGLAS DE PUNTUACIÓN</p>

                    <div class="rules-description">
                      <scoring-rules></scoring-rules>
                    </div>
                </div>

                <div class="tab-pane" id="contestants">
                  <div class="contestant-list-wrapper ">
                    <div ng-if="currentInfoData['contestants'].isEmpty" class="default-info-text">
                      Todavía no hay participantes en este concurso. <br> Anímate a ser el primero.
                    </div>
                    <div class="contestant-list">
                      <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
                        <div class="contestant-position">{{$index + 1}}º</div>
                        <div class="contestant-name">{{contestant.name}}</div>
                        <div class="contestant-points">{{contestant.wins + ' '}}<span class="prize-currency">Ganados</span></div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="tab-pane" id="prizes">

                  <div class="prizes-wrapper">
                    <div ng-if="currentInfoData['prizes'].isEmpty" class="default-info-text">
                      Este concurso no tiene premios
                    </div>
                    <div id="prizes-list">
                      <div class="prize-element-wrapper" ng-repeat="prize in currentInfoData['prizes']">
                        <div class="prize-element">
                            {{$index + 1}}º &nbsp;&nbsp; {{prize.value | number: 0.00}}€
                        </div>
                      </div>
                      <div class="clearfix"></div>
                    </div>
                  </div>

                </div>
            </div>
        </div>

    </div>
</div>

<div ng-if="!isPopUp">
  <div id="contestInfoTabbed">
    <p class="title">{{currentInfoData['rules']}}</p>
    <div class="matches-involved">
        <div class="match"   ng-repeat="match in currentInfoData['matchesInvolved']">
            <p class="teams">{{match.soccerTeamA.shortName}} - {{match.soccerTeamB.shortName}}</p>
            <p class="date">{{formatMatchDate(match.startDate)}}</p>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="info-section"></div>

    <p class="title">REGLAS DE PUNTUACIÓN</p>
    <div class="rules-description">
      <scoring-rules></scoring-rules>
    </div>
    <div class="clearfix"></div>
    <div class="info-section"></div>


    <p class="title">PREMIOS</p>
    <div class="prizes-wrapper">
        <div id="prizes-list">
          <div ng-if="currentInfoData['prizes'].isEmpty" class=default-info-text>
            Este concurso no tiene premios
          </div>
          <div class="prize-element-wrapper" ng-repeat="prize in currentInfoData['prizes']">
            <div class="prize-element">
                {{$index + 1}}º &nbsp;&nbsp; {{prize.value | number: 0.00}}€
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="info-section"></div>

    <p class="title">JUGADORES</p>
    <div ng-if="currentInfoData['contestants'].isEmpty" class="default-info-text">
      Todavía no hay participantes en este concurso. <br> Anímate a ser el primero.
    </div>
    <div class="contestant-list">
        <div class="contestant-element"ng-repeat="contestant in currentInfoData['contestants']">
            <div class="contestant-position">{{$index + 1}}º</div>
            <div class="contestant-name">{{contestant.name}}</div>
            <div class="contestant-points">{{contestant.wins + ' '}}<span class="prize-currency">Ganados</span></div>
        </div>
    </div>
    <div class="clearfix"></div>

  </div>

</div>"""));
tc.put("packages/webclient/components/contests_list_comp.html", new HttpResponse(200, r"""<div class="contests-list-root">
  <div class="contest-row" ng-repeat="contest in currentPageList">

    <div class="column-contest-name" ng-click="onRow(contest)">
      <div class="column-name">{{contest.name}}</div>
      <div class="column-description">{{contest.description}}</div>
    </div>

    <div class="column-contest-empty" ng-click="onRow(contest)" ng-if="contest.isLive"></div>

    <div class="column-contest-price" ng-click="onRow(contest)" ng-if="!contest.isLive && !contest.isHistory">
      <div class="column-contest-price-content"><span>{{contest.entryFee}}€</span></div>
      <div class="column-contest-price-header">ENTRADA</div>
      <!-- torneo gratis -->
      <!--<div ng-if="isFreeContest(contest)"><img src="images/iconFree.png" alt="GRATIS"></div>-->
    </div>

    <div class="column-contest-position" ng-click="onRow(contest)" ng-if="contest.isLive || contest.isHistory">
      <div class="column-contest-position-content"><span>{{getMyPosition(contest)}}</span></div>
      <div class="column-contest-position-header">DE {{contest.maxEntries}}</div>
    </div>

    <div class="column-contest-prize" ng-click="onRow(contest)" ng-if="!contest.isLive">
      <div class="column-contest-prize-content">
        <span ng-if="!contest.isHistory"class="prize">{{contest.prizePool}}€</span>
        <span ng-if="contest.isHistory">{{getMyPrize(contest)}}€</span>
      </div>
      <div class="column-contest-prize-header">
        <div class="column-contest-prize-header-title">PREMIO</div>
        <div class="column-contest-prize-header-prize-type">{{contest.prizeTypeName}}</div>
      </div>
    </div>

    <div class="column-contest-points" ng-click="onRow(contest)" ng-if="contest.isLive">
      <div class="column-contest-points-content"><span>{{getMyFantasyPoints(contest)}}</span></div>
      <div class="column-contest-points-header">PUNTOS</div>
    </div>

    <div class="column-contest-start-date" ng-click="onRow(contest)" ng-if="!contest.isLive">
      <div class="column-start-date-day">{{dateInfo(contest.startDate)}}</div>
      <div class="column-start-date-hour">{{timeInfo(contest.startDate)}}</div>
    </div>

    <div class="column-contest-action">
      <button type="button" class="btn" ng-click="onAction(contest)">{{actionButtonTitle}}</button>
    </div>

  </div>

  <paginator on-page-change="onPageChange(currentPage, itemsPerPage)" list-length="contestsListFiltered.length"></paginator>

</div>"""));
tc.put("packages/webclient/components/enter_contest/enter_contest_comp.html", new HttpResponse(200, r"""<div id="enter-contest-wrapper" ng-cloak>

  <contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header>

  <!-- Nav tabs -->
  <ul class="enter-contest-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('lineup-tab-content')">Tu alineación</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('contest-info-tab-content')">Info torneo</a></li>
  </ul>

  <div id="enterContest">
    <div class="tabs">
      <!-- Tab panes -->
      <div class="tab-content">
        <div class="tab-pane active" id="lineup-tab-content">

            <!-- Este sera el selector de partidos en "grande", con botones-->
            <matches-filter id="matchesFilterBig" contest="contest" selected-option="matchFilter" ng-if="isBigScreenVersion"></matches-filter>

            <div class="enter-contest-actions-wrapper" ng-if="isSmallScreenVersion">
              <div class="total-salary"><span class="total-salary-money" ng-class="{'red-numbers': availableSalary < 0 }" ng-show="contest != null">{{availableSalary}}€</span></div>
              <button id="cancelSoccerPlayerSelection" type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer">CANCELAR</button>
            </div>

            <div class="enter-contest-lineup-wrapper">
              <div class="enter-contest-lineup">
                <div class="enter-contest-total-salary">
                    <span class="total-salary-text">TU ALINEACIÓN</span>
                    <div class="total-salary">
                      <span class="total-salary-text">DINERO RESTANTE:</span>
                      <span class="total-salary-money" ng-class="{'red-numbers': availableSalary < 0 }" ng-show="contest != null">{{availableSalary}}€</span>
                    </div>
                </div>

                <lineup-selector ng-show="!isSelectingSoccerPlayer || isBigScreenVersion"></lineup-selector>
              </div>
            </div>

            <div class="enter-contest-soccer-players-wrapper" ng-show="isSelectingSoccerPlayer || isBigScreenVersion">
              <div class="enter-contest-soccer-players">

                <!-- Este es el desplegable, para todas las versiones que sean moviles -->
                <matches-filter contest="contest" selected-option="matchFilter" ng-if="isSmallScreenVersion"></matches-filter>

                <soccer-players-filter name-filter="nameFilter" field-pos-filter="fieldPosFilter"></soccer-players-filter>
                
                <soccer-players-list soccer-players="availableSoccerPlayers"
                                     field-pos-filter="fieldPosFilter" name-filter="nameFilter" match-filter="matchFilter"
                                     on-row-click="onRowClick(soccerPlayerId)"
                                     on-add-click="onSoccerPlayerSelected(soccerPlayer)"></soccer-players-list>
              </div>
            </div>

            <div class="enter-contest-actions-wrapper">
              <button type="button" class="btn-cancel-player-selection" ng-click="cancelPlayerSelection()" ng-show="isSelectingSoccerPlayer" ng-if="isSmallScreenVersion">CANCELAR</button>

              <div ng-if="!isSelectingSoccerPlayer || isBigScreenVersion">
                <div class="button-wrapper">
                  <button type="button" class="btn-clean-lineup-list" ng-click="deleteFantasyTeam()" ng-disabled="isPlayerSelected()">BORRAR TODO</button>
                </div>
                <div class="button-wrapper">
                  <button type="button" class="btn-confirm-lineup-list" ng-click="createFantasyTeam()" ng-disabled="!isFantasyTeamValid()">CONFIRMAR</button>
                </div>
                <p>Recuerda que puedes editar tu equipo cuantas veces quieras hasta que comience la competición</p>
              </div>
            </div>

        </div>

        <div class="tab-pane" id="contest-info-tab-content">
          <contest-info contest-id-data="contestId"></contest-info>
        </div>

      </div>
    </div>

    <div class="contest-id-bar">
      <div class="contest-id">ID: {{contest.contestId.toUpperCase()}}</div>
    </div>
  </div>

</div>

<div id="soccer-player-info-wrapper" ng-if="scrDet.isXsScreen">
  <soccer-player-info instance-soccer-player="selectedInstanceSoccerPlayer"></soccer-player-info>
</div>

<!-- Modal Window que envuelve la informacion de concurso, mostrada cuando clickamos en cualquiera de los campos de la fila -->
<div  id="infoContestModal" class="modal fade" tabindex="-1" role="dialog" ng-if="!scrDet.isXsScreen">
  <div class="modal-dialog modal-lg">
    <div class="modal-content-soccer-player-info">
      <soccer-player-info instance-soccer-player="selectedInstanceSoccerPlayer"></soccer-player-info>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/enter_contest/lineup_selector_comp.html", new HttpResponse(200, r"""<div class="lineup-selector">
  <div class="lineup-selector-slot" ng-repeat="slot in enterContestComp.lineupSlots" ng-click="enterContestComp.onSlotSelected($index)" ng-class="getSlotClassColor($index)">
    <div class="column-fieldpos" ng-if="!isEmptySlot(slot)">{{slot.fieldPos.abrevName}}</div>
    <div class="column-fieldpos" ng-if="isEmptySlot(slot)">{{getSlotPosition($index)}}</div>
    <div class="column-primary-info" ng-if="!isEmptySlot(slot)">
        <span class="soccer-player-name">{{slot.fullName | limitToDot : 19}}</span>
        <span class="match-event-name" ng-bind-html="slot.matchEventName"></span>
    </div>
    <div class="column-empty-slot" ng-if="isEmptySlot(slot)">{{getSlotDescription($index)}}</div>
    <div class="column-salary" ng-if="!isEmptySlot(slot)">{{slot.salary}}€</div>
    <div class="column-action">
        <a class="iconButtonSelect" ng-if="isEmptySlot(slot)"><span class="glyphicon glyphicon-chevron-right"></span></a>
        <a class="iconButtonRemove" ng-if="!isEmptySlot(slot)"><span class="glyphicon glyphicon-remove"></span></a>
    </div>
  </div>

  <div class="alert alert-danger alert-dismissible alert-red-numbers" role="alert">
    <button type="button" class="close" ng-click="enterContestComp.alertDismiss()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
    <strong>Te has pasado del límite salarial</strong><br> Por favor, elige jugadores que se ajusten al presupuesto
  </div>

</div>"""));
tc.put("packages/webclient/components/enter_contest/matches_filter_comp.html", new HttpResponse(200, r"""<div id="matchesFilterWrapper" ng-switch="srcDet.isXsScreen">
  
  <select id="matchesSelectorFilter" ng-switch-when="true" class="matches-selector-filter" ng-model="optionsSelectorValue" >
    <option ng-repeat="match in matchEvents" id="option-match-{{match.id}}" value="{{$index + 1}}" ng-value="match.id">{{match.textoSelector}}</option>
  </select>
  
  <div id="matchesFilterButtons" class="matches-filter-buttons" ng-switch-when="false">
    <button class="btn btn-default button-filtro-team" ng-repeat="match in matchEvents" ng-bind-html="match.texto" id="match-{{match.id}}" 
            ng-click="optionsSelectorValue = match.id" ng-class="{'active': optionsSelectorValue == match.id }">
    </button>
  </div>
</div>"""));
tc.put("packages/webclient/components/enter_contest/soccer_player_info_comp.html", new HttpResponse(200, r"""<div class="soccer-player-info-header">
  <div class="actions-header">
    <div class="text-header">Estadísticas de jugador</div>
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
      <span class="glyphicon glyphicon-remove"></span>
    </button>
    <div class="button-wrapper">
      <button class="btn-cancel-soccer-player-info" ng-click="enterContestComp.closePlayerInfo()">CANCELAR</button>
    </div>
    <div class="button-wrapper">
      <span class="next-match">PRÓXIMO PARTIDO:</span> <span class="next-match" ng-bind-html="currentInfoData['nextMatchEvent']"></span>
      <button class="btn-add-soccer-player-info" ng-click="enterContestComp.addSoccerPlayerToLineup(currentInfoData['id'])">AÑADIR</button>
    </div>
  </div>
  <div class="description-header">
    <div class="soccer-player-description">
      <div class="soccer-player-pos-team">
        <span>{{currentInfoData['fieldPos']}}</span> | <span>{{currentInfoData['team']}}</span>
      </div>
      <div class="soccer-player-name">{{currentInfoData['name']}}</div>
    </div>
    <div class="soccer-player-info-stats">
      <div class="soccer-player-fantasy-points"><span>DFP</span><span>{{currentInfoData['fantasyPoints']}}</span></div>
      <div class="soccer-player-matches"><span>PARTIDOS</span><span>{{currentInfoData['matches']}}</span></div>
      <div class="soccer-player-salary"><span>SALARIO</span><span>{{currentInfoData['salary']}}</span></div>
    </div>
  </div>
</div>



<div class="soccer-player-info-content">
    <!-- Nav tabs -->
    <ul class="soccer-player-info-tabs" role="tablist">
      <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('season-info-tab-content')">Datos de Temporada</a></li>
      <li><a role="tab" data-toggle="tab" ng-click="tabChange('match-info-tab-content')">Partido a Partido</a></li>
    </ul>

    <div class="tabs">
      <!-- Tab panes -->
      <div class="tab-content">
        <!--SEASON-->
        <div class="tab-pane active" id="season-info-tab-content">
          <div class="next-match">PRÓXIMO PARTIDO: <span ng-bind-html="currentInfoData['nextMatchEvent']"></span></div>
          <!--<div class="date-season">15/05 19:00</div>-->
          <!-- MEDIAS -->
          <div class="season-header">Estadísticas de temporada <span>(datos por partido)</span></div>
          <div class="season-stats">
            <div class="season-stats-wrapper">
              <div class="season-stats-row" ng-repeat="stat in medias">
                <div class="season-stats-header">{{stat['nombre']}}</div>
                <div class="season-stats-info">{{stat['valor']}}</div>
              </div>
            </div>
          </div>
        </div>
        <!--END SEASON-->
        <!--MATCH-->
        <div class="tab-pane" id="match-info-tab-content">
          <div class="match-header">Partido a partido</div>
          <div class="match-stats" ng-if="matchesPlayed">
            <!--HEADER-->
            <div ng-if="isGoalkeeper()" class="match-stats-header">
              <div><span ng-if="enterContestComp.scrDet.isDesktop || enterContestComp.scrDet.isSmScreen">FECHA</span>&nbsp;</div>
              <div ng-if="enterContestComp.scrDet.isXsScreen">DÍA</div>
              <div>OP</div>
              <div>DFP</div>
              <div>MIN</div>
              <div>GE</div>
              <div>PA</div>
              <div>D</div>
              <div>P</div>
              <div>RE</div>
              <div>PB</div>
              <div>PD</div>
              <div>FC</div>
              <div>TA</div>
              <div>TR</div>
            </div>
            <div ng-if="!isGoalkeeper()" class="match-stats-header">
              <div><span ng-if="enterContestComp.scrDet.isDesktop || enterContestComp.scrDet.isSmScreen">FECHA</span>&nbsp;</div>
              <div ng-if="enterContestComp.scrDet.isXsScreen">DÍA</div>
              <div>OP</div>
              <div>DFP</div>
              <div>MIN</div>
              <div>G</div>
              <div>T</div>
              <div>P</div>
              <div>A</div>
              <div>R</div>
              <div>RE</div>
              <div>E</div>
              <div>PB</div>
              <div>FJ</div>
              <div>TA</div>
              <div>TR</div>
            </div>
            <!--CONTENT-->
            <div class="match-stats-content">
                <div class="match-stats-data">
                  <!-- Los datos con un ng-repeat por año -->
                  <div ng-repeat="slot in seasons">
                      <div class="match-year">{{slot["año"]}}</div>
                      <div class="data" ng-repeat="match in slot['value']">
                        <div ng-repeat="data in match">{{data}}<span ng-if="$index == 0 && scrDet.isDesktop">/{{slot["año"]}}</span></div>
                      </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="noMatchesPlayed" ng-if="!matchesPlayed">
              <span>NO HA JUGADO NINGÚN PARTIDO ESTA TEMPORADA</span>
          </div>
        </div>
        <!--END MATCH-->
      </div>
    </div>
    <!--BUTTONS-->
    <div class="action-buttons">
      <div class="button-wrapper">
        <button class="btn-cancel-soccer-player-info" ng-click="enterContestComp.closePlayerInfo()">CANCELAR</button>
      </div>
      <div class="button-wrapper">
        <button class="btn-add-soccer-player-info" ng-click="enterContestComp.addSoccerPlayerToLineup(currentInfoData['id'])">AÑADIR</button>
      </div>
    </div>
</div>



"""));
tc.put("packages/webclient/components/enter_contest/soccer_players_filter_comp.html", new HttpResponse(200, r"""<div class="soccer-players-filter">
            
  <div class="filter-by-position">
    <span>JUGADORES</span>
    <button class="btn btn-default button-filtro-position" ng-click="fieldPosFilter = fieldPos" 
            ng-repeat="fieldPos in posFilterList" ng-bind-html="getTextForFieldPos(fieldPos)" ng-class="getClassForFieldPos(fieldPos)"></button>
  </div>
  
  <input type="text" class="name-player-input-filter" placeholder="Buscar jugador" ng-model="nameFilter" />
</div>"""));
tc.put("packages/webclient/components/enter_contest/soccer_players_list_comp.html", new HttpResponse(200, r"""
<div class="soccer-player-list-header-table">
  <div class="filterOrderPos"><a ng-click="sortListByField('Pos')">Pos.</a></div>
  <div class="filterOrderName"><a ng-click="sortListByField('Name')">Nombre</a></div>
  <div class="filterOrderDFP"><a ng-click="sortListByField('DFP')">DFP</a></div>
  <div class="filterOrderPlayed"><a ng-click="sortListByField('Played')">Jugados</a></div>
  <div class="filterOrderSalary"><a ng-click="sortListByField('Salary')">Sueldo</a></div>
</div>

<div class="soccer-players-list">

  <div id="soccerPlayer{{slot['intId']}}" class="soccer-players-list-slot" ng-repeat="slot in sortedSoccerPlayers | orderBy:sortList" 
       ng-class="getSlotClassColor(slot.fieldPos.abrevName)">
    <div class="column-fieldpos" ng-click="onRow(slot)">{{slot.fieldPos.abrevName}}</div>
    <div class="column-primary-info">
      <span class="soccer-player-name" ng-click="onRow(slot)">{{slot.fullName | limitToDot : showWidth(slot.fullName)}}</span>
      <span class="match-event-name" ng-click="onRow(slot)" ng-bind-html="slot.matchEventName"></span>
    </div>
    <div class="column-dfp" ng-click="onRow(slot)">{{slot.fantasyPoints}}</div>
    <div class="column-played" ng-click="onRow(slot)">{{slot.playedMatches}}</div>
    <div class="column-salary" ng-click="onRow(slot)">{{slot.salary}}€</div>
    <div class="column-add">
      <button type="button" class="btn" ng-click="onAdd(slot)">Añadir</button>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/flash_messages_comp.html", new HttpResponse(200, r"""<div>
  <div ng-repeat="msg in messages" id="flash-messages">
      <div class="alert alert-{{msg.type}} alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <span class="">{{msg.text}}</span>
      </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/global_connection_comp.html", new HttpResponse(200, r"""<div class="alert-danger" ng-show="msg.isNotEmpty" style="padding: 1em; position: fixed; top: 10%; left: 50%; transform: translateX(-50%);">
  {{msg}}
</div>
"""));
tc.put("packages/webclient/components/landing_page_comp.html", new HttpResponse(200, r"""<div id="#landingPageRoot">
  <!-- Portada Versión Desktop -->
  <div id="desktopContent" ng-if="!scrDet.isXsScreen" class="first-screen" style="height:{{screenHeight}}px">
    <div class="screen-pattern" src="images/pattern.png"></div>
    <div class="beta-label"><img src="images/beta.png"/></div>
    <div class="main-title-wrapper">

      <div class="main-title">LIGAS FANTÁSTICAS DIARIAS</div>
      <div class="separator-wrapper">
        <img src="images/separator.png"/>
      </div>
      <div class="modules-wrapper">

        <div class="module-column">
          <img class="icono" src="images/icon1.png"/>
          <p class="icono-text">Crea tu equipo en segundos</p>
        </div>

        <div class="module-column">
          <img class="icono" src="images/icon2.png"/>
          <p class="icono-text">Compite en tantas ligas como quieras</p>
        </div>

        <div class="module-column">
          <img class="icono" src="images/icon3.png"/>
          <p class="icono-text">Sigue los partidos en directo</p>
        </div>

      </div>

      <div class="button-wrap">
        <button type="button" class="button-play"  ng-click="buttonPressed('join')" id="playButton1">JUGAR</button>
      </div>

    </div>

    <!-- Separador -->
    <a class="wrapping-link" href="#screen2">
      <span id="screenSeparator1" class="more-info-section-light">
        <span>SABER MÁS</span>
        <span class="go-down-icon"></span>
      </span>
    </a>
  </div>
  <!-- END Portada Versión Desktop -->

  <!-- Portada Versión Móvil -->
  <div id="mobileContent" ng-if="scrDet.isXsScreen" class="screen">
    <div class="slider-wrapper-mobile">
      <img class="background" src="images/xsLandingBackground.jpg" />
    </div>
    <div class="beta-label"><img src="images/beta.png"/></div>
    <div class="content">
      <p class="main-title-mobile">LIGAS FANTÁSTICAS <br> DIARIAS</p>
      <p class="title-sup-text-mobile">CREA TU EQUIPO EN SEGUNDOS</p>
      <p class="title-sup-text-mobile">COMPITE EN TANTAS LIGAS COMO QUIERAS</p>
      <p class="title-sup-text-mobile">SIGUE LOS PARTIDOS EN DIRECTO</p>
      <button type="button" class="button-play-mobile" ng-click="buttonPressed('join')" id="playButtonMobile">JUGAR</button>
    </div>
    <!-- Separador -->
    <a class="wrapping-link" href="#screen2">
      <span id="screenSeparator1" class="more-info-section-light">
        <span>SABER MÁS</span>
        <span class="go-down-icon"></span>
      </span>
    </a>
  </div>
  <!-- END Portada Versión Móvil -->
  <div id="screen2" class="screen">
      <div class="slider-wrapper">
        <img class="screen-background" src="images/landing02.jpg" />
        <div class="screen-pattern"></div>
      </div>
      <div class="content-wrapper">
        <div class="content-container">
          <div class="screen-image-block">
            <img class="screen-logo" src="images/landingLogo1.png" />
          </div>
          <div class="screen-text-block">
            <p class="title-text-dark">CADA DÍA NUEVOS TORNEOS</p>
            <p class="description-text">
                Liga, Champions, Europa League: cada día te ofrecemos torneos de las competiciones más importantes. Puedes participar en tantos como quieras
            </p>
            <button type="button" class="button-play"  ng-click="buttonPressed('join')" id="playButton2">JUGAR</button>
          </div>
        </div>
      </div>
  </div>

  <a class="wrapping-link" href="#screen3">
    <span id="screenSeparator2" class="more-info-section-light">
      <span>SABER MÁS</span>
      <span class="go-down-icon"></span>
    </span>
  </a>

  <div id="screen3" class="screen">
      <div class="slider-wrapper">
        <img class="screen-background" src="images/landing03.jpg" />
        <div class="screen-pattern"></div>
      </div>
      <div class="content-wrapper">
        <div class="content-container">
          <div class="screen-image-block">
            <img class="screen-logo" src="images/landingLogo2.png" />
          </div>
          <div class="screen-text-block">
            <p class="title-text-dark">CREA TU EQUIPO IDEAL</p>
            <p class="description-text">
                Cada jugador tienen un salario acorde a su rendimiento en la vida real. Elige bien, deberás mantenerte por debajo del límite de presupuesto.
            </p>
            <button type="button" class="button-play"  ng-click="buttonPressed('join')" id="playButton3">JUGAR</button>
          </div>
        </div>
      </div>
  </div>

  <a class="wrapping-link" href="#screen4">
    <span id="screenSeparator3" class="more-info-section-dark">
      <span>SABER MÁS</span>
      <span class="go-down-icon"></span>
    </span>
  </a>

  <div id="screen4" class="screen">
      <div class="slider-wrapper">
        <img class="screen-background" src="images/landing04.jpg" />
        <div class="screen-pattern"></div>
      </div>
      <div class="content-wrapper">
        <div class="content-container">
          <div class="screen-image-block">
            <img class="screen-logo" src="images/landingLogo3.jpg" />
          </div>
          <div class="screen-text-block">
            <p class="title-text-dark">PUNTÚA Y GANA</p>
            <p class="description-text">
                Cuando comiencen los partidos en la vida real, tus jugadores acumularán puntos en función de sus acciones. Podrás seguir su puntuación en tiempo real desde donde quieras y compararla con los equipos rivales.
            </p>
            <button type="button" class="button-play"  ng-click="buttonPressed('join')" id="playButton4">JUGAR</button>
          </div>
        </div>
      </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/legalese_and_help/beta_info_comp.html", new HttpResponse(200, r"""<div id="betaComp">
   <div class="block-dark-header">
    <div class="default-header-text">EPIC ELEVEN: VERSIÓN BETA</div>
  </div>
  <div class="block-blue-header">
    <div class="title_white">ESTA SECCIÓN NO ESTA DISPONIBLE</div>
  </div>
  <div class="info-wrapper">
    <div class="texto">
      Lo sentimos, esta es una versión beta de Epic Eleven.<br>
      Próximamente podrás jugar y ganar premios en metálico y tendrás habilitadas<br>
      todas las funcionalidades necesarias. Te avisaremos cuando esté operativo
      <br><br>
      <b>Muchas gracias</b>
    </div>

  </div>
</div>"""));
tc.put("packages/webclient/components/legalese_and_help/help_info_comp.html", new HttpResponse(200, r"""<div id="helpInfo">

  <div class="block-dark-header">
    <div class="default-header-text">AYUDA</div>
  </div>

  <!-- Nav tabs -->
  <ul class="help-info-tabs" role="tablist">
    <li class="active"><a role="tab" data-toggle="tab" ng-click="tabChange('how-works-content')">CÓMO FUNCIONA</a></li>
    <li><a role="tab" data-toggle="tab" ng-click="tabChange('rules-scores-content')">PUNTUACIONES Y REGLAS</a></li>
  </ul>

  <div class="tab-pane active" id="how-works-content">
    <div class="block-light">
      <div class="title">ELIGE UN TORNEO</div>
      <div class="description">Configura tu equipo siguiendo estas sencillas indicaciones: <br>En primer lugar, debes seleccionar el torneo en el que quieras participar. <br>Haz clic en la competición deseada y a continuación podrás elegir tus jugadores.</div>
      <div class="img-wrapper">
        <img src="images/help01.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help01-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
      <div class="description">Puedes filtrar los torneos según la competición, el límite salarial de que dispones <br>para confeccionar tu equipo o el tipo de torneo en el que quieras participar. </div>
      <div class="img-wrapper">
        <img src="images/help02.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help02-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
    </div>
    <div class="block-dark">
      <div class="title">HAZ TU EQUIPO</div>
      <div class="description">A continuación, selecciona los 11 jugadores que quieras que participen <br>en el torneo que has elegido. Recuerda que debes ceñirte al <br>límite salarial que marque cada torneo.</div>
      <div class="img-wrapper">
        <img src="images/help03.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help03-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
      <div class="description">No olvides que puedes consultar las estadísticas de los jugadores que has elegido <br>en tiempo real y comparar los resultados de tu alineación con las de otros usuarios.</div>
      <div class="img-wrapper">
        <img src="images/help04.jpg" ng-if="!scrDet.isXsScreen">
        <img src="images/help04-xs.jpg" ng-if="scrDet.isXsScreen">
      </div>
    </div>
    <div class="block-light">
      <div class="title">CONSIGUE EL MÁXIMO DE PUNTOS Y GANA</div>
      <div class="description">En EPIC ELEVEN ser un buen estratega del fútbol tiene recompensa. <br>Confecciona tu alineación para cada torneo en el que quieras participar <br>y observa las estadísticas de los jugadores. Demuestra que eres el mejor, <br>porque próximamente podrás ganar fantásticos premios en metálico.</div>
      <div class="img-wrapper">
        <img src="images/help05.jpg" ng-if="!scrDet.isXsScreen">
        <p class="img-footer">Compara tu alineación con las de otros usuarios en directo.</p>
      </div>
    </div>
    <div class="block-light">
      <div class="title">JUEGA DESDE CUALQUIER LUGAR</div>
      <div class="block-last">
        <div class="img-wrapper-left">
          <img src="images/help06.jpg">
        </div>
        <div class="description-right">
          <p>Comprueba lo sencillo que es participar en los torneos de EPIC 11 desde dónde quieras. Podrás seguir en directo las estadísticas de tus jugadores desde tu ordenador, tablet o smartphone con interfaces adaptadas a cada tipo de dispositivo para optimizar la usabilidad.</p>
          <button type="button" class="button-play" ng-click="goTo('lobby')">JUGAR AHORA</button>
        </div>
      </div>
    </div>
  </div>
  <div class="tab-pane" id="rules-scores-content">
    <div class="block-dark">
      <div class="title">PUNTUACIONES Y ABREVIATURAS</div>
      <div class="scores-wrapper">
        <scoring-rules></scoring-rules>
      </div>
    </div>
    <div class="block-light">
      <div class="title">REGLAS</div>
      <div class="toogle-block">
        <input type="checkbox" id="rule1" class="toggle">
        <label for="rule1">LEGALIDAD</label>
        <div>
          <p>Para efectuar jugar en cualquiera de nuestros torneos, debes tener 18 años o más y ser residente en España. Para más información sobre bases legales, por favor, consulta nuestros <a ng-click="goTo('terminus_info')">Términos y Condiciones de Uso</a>.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule2" class="toggle">
        <label for="rule2">CUENTAS MÚLTIPLES</label>
        <div>
          <p>Cada jugador de Epic Eleven puede tener una sola cuenta de usuario. No obstante, en casos especiales, Epic Eleven permite la creación de una segunda cuenta de usuario. Para ello, debes recibir por escrito una autorización expresa de Epic Eleven antes de abrir la segunda cuenta. En este caso, es decisión última de Epic Eleven determinar el derecho de un usuario a estar en posesión de dos cuentas. Las sanciones serán emitidas a discreción del personal de Epic Eleven y pueden conllevar el cierre de todas las cuentas de un usuario, así como la retención de dinero en efectivo, si determinamos que ha sido obtenido de manera fraudulenta.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule3" class="toggle">
        <label for="rule3">CUENTAS ANULADAS</label>
        <div>
          <p>Existen determinados comportamientos que actúan en detrimento de Epic Eleven y del resto de jugadores. La práctica de estos comportamientos implicará la anulación de algunas (o la totalidad) de las funciones asociadas a una cuenta de usuario. Como consecuencia de lo anteriormente expuesto, los usuarios cuyas cuentas hayan sido anuladas deberán respetar las medidas disciplinarias impuestas. Toda comunicación perteneciente a la restauración de una cuenta de usuario deberá efectuarse a través de la cuenta de correo electrónico soporte@epiceleven.com.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule4" class="toggle">
        <label for="rule4">NOMBRES DE USUARIOS</label>
        <div>
          <p>Epic Eleven se reserva el derecho de solicitar el cambio de nombre de usuario en los casos en que resulte ofensivo o responda a intereses comerciales. El requisito de cambio será determinado exclusivamente por Epic Eleven. Si el usuario ignora la petición Epic Eleven podrá modificar dicho nombre de usuario.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule5" class="toggle">
        <label for="rule5">TORNEOS SIN PARTICIPACIÓN</label>
        <div>
          <p>Todos los torneos abiertos que se realicen en Epic Eleven tienen un premio determinado y un número de participantes concreto. Si no se alcanza este número de participantes al inicio del torneo, éste podrá anularse. Por ejemplo, una competición “Uno contra Uno” sin 2 competidores y una liga de 10 personas con sólo 9 participantes podrán no celebrarse.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule6" class="toggle">
        <label for="rule6">CANCELAR UNA PARTICIPACIÓN</label>
        <div>
          <p>Los usuarios pueden cancelar su participación en cualquier torneo haciendo clic en el botón “cancelar entrada” ubicado en la parte inferior izquierda de la sección en que puedes editar tu equipo. Una vez haya dado comienzo el torneo el botón “cancelar entrada” desaparecerá. Epic Eleven no tendrá en cuenta las solicitudes de cancelación de las inscripciones en los concursos que se rellenen durante los primeros 15 minutos del inicio del juego. Epic Eleven no tiene obligación de tramitar las solicitudes de cancelación que no se reciban o que se reciban después de los plazos indicados anteriormente en este epígrafe, debido a dificultades técnicas u otras razones. Asimismo, Epic Eleven no atenderá peticiones  para cancelar inscripciones en los torneos “Uno Contra Uno”. </p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule7" class="toggle">
        <label for="rule7">JUEGOS POSPUESTOS</label>
        <div>
          <p>Las reglas que especifican el tratamiento de los juegos pospuestos varían en función del tipo de torneo. Epic Eleven se reserva el derecho de actuar a este respecto en función de cada circunstancia particular.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule8" class="toggle">
        <label for="rule8">PARTIDOS SUPENDIDOS</label>
        <div>
          <p>Las reglas que se refieren a partidos que hayan sido suspendidos tienen un tratamiento determinado en función del tipo de torneo. Se considera que un partido ha quedado suspendido cuando queda sin concluir, pero con perspectivas de finalizarse en el futuro. Como mínimo, las estadísticas recopiladas antes de la finalización del periodo del torneo serán tenidas en cuenta entre los partidos.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule9" class="toggle">
        <label for="rule9">JUGADORES EN PROCESO DE NEGOCIACIÓN</label>
        <div>
          <p>Los jugadores inmersos en procesos de negociación pueden afectar al desarrollo de los torneos que ya hayan sido planificados teniendo en cuenta a estos jugadores en sus antiguos equipos. Los listados de jugadores de los equipos en Epic Eleven se actualizan una vez al día (por la noche). Hay que tener en cuenta que los torneos se crean con un adelanto de 5 a 6 días previos al partido, por lo que los jugadores que estén en proceso de negociación pueden no estar disponibles para torneos que incluyan un partido con su equipo nuevo, pero no con su antiguo equipo. También hay que tener en cuenta que, en algunos casos, un jugador que se ha seleccionado ya no esté disponible para un torneo que vaya a disputar su antiguo equipo ni su nuevo equipo. En este caso, el usuario deberá seleccionar un suplente o será acreditado con cero puntos para este jugador en cuestión.</p>
          <p>Ten en cuenta que, el mismo día que un jugador es objeto de negociación, aún puede aparecer en el listado de jugadores de su antiguo equipo. Si la negociación se está produciendo, precisamente, con el equipo rival del jugador en negociaciones en el mismo partido en el que estás participando, todavía podrás recibir puntos por su participación en la competición. Estos puntos no se podrán reflejar con exactitud durante la puntuación en vivo, pero se tendrán en cuenta en el momento en que finalice el partido. Asimismo, ten en cuenta que la liquidación del torneo puede sufrir retrasos con el fin de asegurar la máxima exactitud.</p>
          <p>En casos muy raros, un jugador se traspasa lo suficientemente temprano en el día como para poder jugar un partido para su nuevo equipo esa misma jornada. Si se traspasa desde un equipo que juega un partido tarde a un equipo que va a jugar un partido temprano, podrás seleccionar este jugador para el juego que tenga lugar de manera tardía aun sabiendo que el traspaso se ha realizado de facto antes del partido. Si este fuera el caso, se te asignarán cero puntos por su desempeño</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule10" class="toggle">
        <label for="rule10">RESTRICCIONES EN LAS ALINEACIONES</label>
        <div>
          <p>En casos muy raros, un jugador se traspasa lo suficientemente temprano en el día como para poder jugar un partido para su nuevo equipo esa misma jornada. Si se traspasa desde un equipo que juega un partido tarde a un equipo que va a jugar un partido temprano, podrás seleccionar este jugador para el juego que tenga lugar de manera tardía aun sabiendo que el traspaso se ha realizado de facto antes del partido. Si este fuera el caso, se te asignarán cero puntos por su desempeño</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule11" class="toggle">
        <label for="rule11">LAS REVISIONES DE PUNTUACIÓN</label>
        <div>
          <p>Durante el partido recibimos las puntuaciones en directo desde nuestro proveedor de Estadísticas, Opta. Al finalizar el juego, nos envía el documento final con las estadísticas completas del partido. Una vez recibidas y confirmadas las estadísticas de todos los partidos de la jornada, comenzamos a gestionar la liquidación de todas las participaciones. Sin embargo, en contadas ocasiones, las ligas y estadísticas revisadas por el proveedor sufren alguna modificación posterior a la publicación del cuadro de puntuación final. En caso de que esto ocurra, no se actualizará la puntuación del jugador en Epic Eleven. Ten en cuenta que esta situación no es la misma que un caso en que una corrección deba hacerse después del cierre debido a un problema con la fuente de datos o al proceso de resolución.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule12" class="toggle">
        <label for="rule12">SERVICIO DE ACCESO Y EDICIÓN DE PROBLEMAS</label>
        <div>
          <p>Aunque tratamos de asegurar que Epic Eleven funciona sin problemas en todo momento, al igual que cualquier servicio online, en ocasiones podemos experimentar períodos de interrupción o rendimiento lento. A veces, se producen problemas para acceder al servicio, para editar alineaciones o para entrar en nuevos torneos. Si no puedes acceder al Servicio, por favor, infórmanos de los problemas escribiendo a nuestro correo electrónico soporte@epiceleven.com. Si hay períodos prolongados en que los usuarios no puedan acceder a la funcionalidad de nuestro servicio, la edición de alineaciones no funciona correctamente u otros casos no especificados, desde Epic Eleven, ofrecemos instrucciones para cancelar las entradas en los torneos por correo electrónico antes de que empiece el juego.</p>
        </div>
      </div>
      <div class="toogle-block">
        <input type="checkbox" id="rule13" class="toggle">
        <label for="rule13">CANCELACIÓN DE TORNEOS</label>
        <div>
          <p>Epic Eleven también se reserva el derecho de cancelar los torneos a su criterio, sin ningún tipo de restricciones. Normalmente, esto se llevará a cabo sólo en los casos en los que creemos que, debido a problemas en el servicio o hechos que afecten a los eventos deportivos, no habría un impacto generalizado en la mayor parte de las competiciones.</p>
          <p>Para más información sobre la manera en que Epic Eleven trabaja, por favor, visita nuestra sección de Preguntas Frecuentes en nuestra Página de Ayuda.</p>
        </div>
      </div>
    </div>
  </div>

</div>
"""));
tc.put("packages/webclient/components/legalese_and_help/legal_info_comp.html", new HttpResponse(200, r"""<div id="staticInfo">

  <div class="block-dark-header">
    <div class="default-header-text">LEGAL</div>
  </div>

  <div class="info-wrapper">
    <h1>Datos de identificación</h1>
  	<p>Usted está visitando la página web www.epiceleven.com, titularidad de FANTASY SPORTS GAMES, S.L (en adelante EPIC ELEVEN). La misma está domiciliada en la Avenida de Brasil, 23, Oficinal 5-A, 28020, Madrid, siendo su e-mail de contacto: info@epiceleven.com identificada con C.I.F. B-87028445.</p>
  	<h1>Aceptación del Usuario</h1>
  	<p>Este Aviso Legal regula el acceso y utilización de la página web www.epiceleven.com (en adelante la “Web”) que EPIC ELEVEN pone a disposición de los usuarios de Internet. El acceso a la misma implica la aceptación sin reservas del presente Aviso Legal. Asimismo, EPIC ELEVEN puede ofrecer a través de la Web, servicios que podrán encontrarse sometidos a unas condiciones particulares propias sobre las cuales se informará al Usuario en cada caso concreto.</p>
  	<h1>Acceso a la Web y Contraseñas</h1>
  	<p>Al acceder a la página web de EPIC ELEVEN el usuario declara tener capacidad suficiente para navegar por la mencionada página web, esto es ser mayor de dieciocho años y no estar incapacitado. A su vez, de manera general no se exige la previa suscripción o registro como Usuario para el acceso y uso de la Web, sin perjuicio de que para la utilización de determinados servicios o contenidos de la misma se deba realizar dicha suscripción o registro. Los datos de los Usuarios obtenidos a través de la suscripción o registro a la presente Web, están protegidos mediante contraseñas elegidas por ellos mismos. El Usuario se compromete a mantener su contraseña en secreto y a protegerla de usos no autorizados por terceros. El Usuario deberá notificar a EPIC ELEVEN inmediatamente cualquier uso no consentido de su cuenta o cualquier violación de la seguridad relacionada con el servicio de la Web, de la que haya tenido conocimiento. EPIC ELEVEN adopta las medidas técnicas y organizativas necesarias para garantizar la protección de los datos de carácter personal y evitar su alteración, ida, tratamiento y/o acceso no autorizado, habida cuenta del estado de la técnica, la naturaleza de los datos almacenados y los riesgos a que están expuestos, todo ello, conforme a lo establecido por la legislación española de Protección de Datos de Carácter Personal. EPIC ELEVEN no se hace responsable frente a los Usuarios, por la revelación de sus datos personales a terceros que no sea debida a causas directamente imputables a EPIC ELEVEN, ni por el uso que de tales datos hagan terceros ajenos a EPIC ELEVEN.</p>
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

  <div class="block-dark-header">
    <div class="default-header-text">POLÍTICA DE PRIVACIDAD</div>
  </div>

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
        aconseja a los usuarios que la visiten periódicamente.A su vez, informamos al usuario que EPIC ELEVEN realiza el tratamiento de los datos de acuerdo a las
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

  <div class="block-dark-header">
    <div class="default-header-text">TÉRMINOS Y CONDICIONES</div>
  </div>

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
                        contests-list="activeContestsService.activeContests" contest-count="contestCount"
                        on-sort-order-change="onSortOrderChange(fieldName)" on-filter-change="onFilterChange(filterList)"></contest-filters-comp>

  <!-- Lista de concursos -->
  <contests-list  id="activeContestList"
                  sorting="lobbySorting"
                  contests-list="activeContestsService.activeContests"
                  on-action-click='onActionClick(contest)'
                  on-row-click="onRowClick(contest)" action-button-title="'Jugar'"
                  competition-type-filter="lobbyFilters['FILTER_COMPETITION']"
                  tournament-type-filter="lobbyFilters['FILTER_TOURNAMENT']" salary-cap-filter="lobbyFilters['FILTER_TIER']"
                  entry-fee-filter="lobbyFilters['FILTER_ENTRY_FEE']" name-filter="lobbyFilters['FILTER_CONTEST_NAME']"
                  contest-count="contestCount">
  </contests-list>

  <!-- Modal Window que envuelve la informacion de concurso, mostrada cuando clickamos en cualquiera de los campos de la fila -->
  <div  id="infoContestModal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg">
        <div id="infoContent" class="modal-content">
          <contest-info contest-id-data="selectedContestId"></contest-info>
        </div>
      </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/my_contests_comp.html", new HttpResponse(200, r"""<div id="myContest" ng-cloak>
  <div class="default-header-text">MIS TORNEOS</div>
  <!-- Nav tabs -->
  <ul  id="myContestMenuTabs" class="my-contest-tabs" role="tablist">

    <li class="active"> <!-- LIVE CONTESTS CONTENT-->
      <a role="tab" data-toggle="tab" ng-click="tabChange('live-contest-content')">
        En Vivo
        <span class="contest-count" ng-if="hasLiveContests">
          {{myContestsService.liveContests.length}}
        </span>
      </a>
    </li>

    <li> <!-- WAITING CONTESTS TAB-->
      <a role="tab" data-toggle="tab" ng-click="tabChange('waiting-contest-content')">Próximos</a>
    </li>

    <li> <!-- HISTORY CONTESTS TAB-->
      <a role="tab" data-toggle="tab" ng-click="tabChange('history-contest-content')">Historial</a>
    </li>
  </ul>

  <div class="tabs">
    <!-- Tab panes -->
    <div class="tab-content">

      <!-- LIVE CONTESTS CONTENT-->
      <div class="tab-pane active" id="live-contest-content">

        <!-- Barra de resumen de actividad -->
        <div class="resume-bar" ng-if="!hasLiveContests">
             <span class="information-no-contest">AQUÍ PODRÁS CONSULTAR EN TIEMPO REAL LOS TORNEOS QUE TENGAS ACTIVOS</span>
        </div>

        <!-- Banner de información de lista vacía -->
        <div class="no-contest" ng-if="!hasLiveContests">
          <div class="no-contests-wrapper">
            <div class="default-info-text">
             EN ESTE MOMENTO, NO ESTÁS JUGANDO<br>NINGÚN TORNEO
            </div>
            <div class="no-contests-text">
              CONSULTA LA LISTA DE TUS <strong data-toggle="tab" ng-click="tabChange('waiting-contest-content')">PRÓXIMOS TORNEOS</strong> PARA VER CUÁNDO EMPIEZAN
            </div>
          </div>
          <div class="my-no-contest-bottom-row">
            <button class="btn-go-to-contest" ng-click="gotoLobby()">IR A LOS TORNEOS</button>
          </div>
        </div>

        <!-- lista de concursos -->
        <div class="list-container" ng-if="hasLiveContests">
          <contests-list id="liveContests"
                         sorting="liveSortType"
                         contests-list="myContestsService.liveContests"
                         on-action-click='onLiveActionClick(contest)'
                         on-row-click='onLiveRowClick(contest)'>
          </contests-list>
        </div>
      </div>

      <!-- WAITING CONTESTS CONTENT-->
      <div class="tab-pane" id="waiting-contest-content">

        <!-- Barra de resumen de actividad sin registros-->
        <div class="resume-bar" ng-if="!hasWaitingContests">
          <span class="information-no-contest">EN ESTE ESPACIO PODRÁS CONSULTAR Y MODIFICAR LOS EQUIPOS QUE TIENES PENDIENTES DE JUGAR EN UN TORNEO</span>
        </div>

        <!-- Barra de resumen de actividad con registros-->
        <!--<div class="resume-bar" ng-if="hasWaitingContests">
          <div class="change-player">
            <button class="btn-change-player" ng-click="">CAMBIO RÁPIDO DE JUGADOR</button>
          </div>
        </div>-->

        <!-- Banner de información de lista vacía -->
        <div class="no-contest" ng-if="!hasWaitingContests">
          <div class="no-contests-wrapper">
            <div class="default-info-text">
             EN ESTE MOMENTO, NO TIENES UN<br>EQUIPO CREADO PARA NINGÚN TORNEO
            </div>
            <div class="no-contests-text">
              VE A LA LISTA DE TORNEOS, ELIGE UNO Y EMPIEZA A JUGAR
            </div>
          </div>
          <div class="my-no-contest-bottom-row">
            <button class="btn-go-to-contest" ng-click="gotoLobby()">IR A LOS TORNEOS</button>
          </div>
        </div>

        <!-- lista de concursos -->
        <div class="list-container" ng-if="hasWaitingContests">
          <contests-list id="waitingContests"
                         sorting="waitingSortType"
                         contests-list='myContestsService.waitingContests'
                         on-action-click='onWaitingActionClick(contest)'
                         on-row-click='onWaitingRowClick(contest)'>
          </contests-list>
        </div>
      </div>

      <!-- HISTORY CONTESTS CONTENT-->
      <div class="tab-pane" id="history-contest-content">
          <!-- Barra de resumen de actividad sin registros-->
          <div class="resume-bar" ng-if="!hasHistoryContests">
            <span class="information-no-contest">AQUÍ PODRÁS CONSULTAR Y REPASAR TODOS LOS TORNEOS QUE HAS JUGADO: TUS EQUIPOS, RIVALES PUNTUACIONES…</span>
          </div>
          <!-- Barra de resumen de actividad con registros-->
          <div class="resume-bar" ng-if="hasHistoryContests">
            <!--<div class="refresh-text">Actualizado cada 24 horas</div>-->
            <div class="info">
              <span class="info-registers-count">{{myContestsService.historyContests.length}} REGISTROS</span>
              <span class="info-wins-count">{{totalHistoryContestsWinner}} GANADOS</span>
              <!--<span class="info-available-money">{{totalHistoryContestsPrizes}} €</span>-->
            </div>
            <!--<div class="data-to-csv">
              <button class="btn-data-to-csv" ng-click="">DESCARGAR COMO CSV</button>
            </div>-->
          </div>

          <!-- Banner de información de lista vacía -->
          <div class="no-contest" ng-if="!hasHistoryContests">
            <div class="no-contests-wrapper">
              <div class="default-info-text">
               TODAVÍA NO HAS JUGADO NINGÚN TORNEO
              </div>
              <div class="no-contests-text">
                VE A LA LISTA DE TORNEOS, ELIGE UNO Y EMPIEZA A JUGAR
              </div>
            </div>
            <div class="my-no-contest-bottom-row">
              <button class="btn-go-to-contest" ng-click="gotoLobby()">IR A LOS TORNEOS</button>
            </div>
          </div>

          <!-- lista de concursos -->
          <div class="list-container" ng-if="hasHistoryContests">
            <!--<div class="text-refresh-history">Actualizado cada 24 horas</div>-->
            <contests-list id="historyContests"
                           sorting="historySortType"
                           contests-list="myContestsService.historyContests"
                           on-action-click='onHistoryActionClick(contest)'
                           on-row-click='onHistoryRowClick(contest)'>
            </contests-list>
          </div>
      </div>

    </div>

  </div>
</div>
"""));
tc.put("packages/webclient/components/navigation/footer_comp.html", new HttpResponse(200, r"""<!--<div id="footerRoot" ng-show="!loadingService.isLoading" ng-cloak>-->
<div id="footerRoot" ng-show="false" ng-cloak>

   <div class="sup-footer-wrapper">
    <div class="user-info-sup-footer" ng-show="profileService.isLoggedIn">
        <a id="footerProfile" href="#" class="goto-link" ng-click="gotoProfile()"><span class="username-link">{{profileService.user.nickName}}</span></a>
        <a id="footerLogOut" href="#" class="goto-link" ng-click="profileService.logout()"><span class="logout-link">Salir</span></a>
        <!--<button id="footerAddFunds" class="add-funds-button">AÑADIR FONDOS</button>-->
    </div>
  </div>

  <div class="sub-footer-wrapper">
    <div class="sub-footer">

      <div class="logo-wrapper">
        <img src="images/logoLobbyFooter.png" alt="EPIC ELEVEN">
      </div>

      <div class="data-wrapper">
          <a class="goto-link" id="footerHelp" ng-click="goTo('help_info')"><span class="sub-footer-help-link">AYUDA</span></a>
          <a class="goto-link" id="footerLegal" ng-click="goTo('legal_info')"><span class="sub-footer-legal-link">LEGAL</span></a>
          <a class="goto-link" id="footerTermsOfUse" ng-click="goTo('terminus_info')"><span class="sub-footer-terms-link">TERMINOS<span> DE USO</span></span></a>
          <a class="goto-link" id="footerPrivacyPolicy" ng-click="goTo('policy_info')"><span class="sub-footer-policy-link"><span>POLÍTICA DE </span>PRIVACIDAD</span></a>
      </div>

      <!--<div class="credit-cards">
          <img src="images/creditCards.png" />
      </div>-->

      <div class="opta">
        <div>Datos suministrados por: <span>OPTA</span></div>
        <div>A <strong>PERFORM</strong> GROUP COMPANY</div>
      </div>

      <div class="copyright">@ Copyright 2014 Epic Eleven</div>

      <div class="social">
          <a href="https://www.facebook.com/pages/Epic-Eleven/582891628483988?fref=ts"><img src="images/social.png"/></a>
      </div>

      <!--<a href="#" class="url-link">
          <span>Fantasy Sports Games.com</span>
      </a>-->

      <div class="footer-count" ng-if="isDev">{{dateTimeService.nowEverySecond}}</div>
    </div>
  </div>
</div>
"""));
tc.put("packages/webclient/components/navigation/main_menu_slide_comp.html", new HttpResponse(200, r"""<nav id="mainMenu" ng-class="{'image-background':profileService.isLoggedIn == true}" class="navbar navbar-default" role="navigation">
  <div class="inner-wrapper">

    <div id="menuLoggedIn">
      <!-- lcabecera when logeado -->
      <div class="navbar-header"  ng-show="profileService.isLoggedIn">
        <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-target="#menuSlide" data-canvas="body" id="toggleSlideMenu">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <div id="brandLogoLogged" class="navbar-brand" ng-click="navigateTo($event)" destination="lobby" ng-class="['loggedIn-brand']" ng-model="checkForActiveElement()"></div>
      </div>
      <!-- Opciones del menu -->
      <div id="menuSlide" class="navbar-offcanvas navmenu-fixed offcanvas" ng-if="profileService.isLoggedIn">
        <ul class="nav navbar-nav">
          <li highlights="lobby"> <a  id="menuLobby"                ng-click="navigateTo($event)" destination="lobby">Buscar Torneos</a></li>
          <li highlights="my_contests">          <a  id="menuMy_Contest"           ng-click="navigateTo($event)" destination="my_contests">Mis torneos</a></li>
          <li highlights="">                     <a  id="menuPromos"               ng-click="navigateTo($event)" destination="beta_info">Promos</a></li>
          <li highlights="user" class="right-menu">
            <a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">{{userNickName}}</a>
            <ul class="dropdown-menu">
              <li>                    <a  id="menuUserMyAccount"        ng-click="navigateTo($event)" destination="user_profile">Mi cuenta</a></li>
              <li>                    <a  id="menuUserAddFunds"         ng-click="navigateTo($event)" destination="beta_info">Añadir fondos</a></li>
              <li>                    <a  id="menuUserHistory"          ng-click="navigateTo($event)" destination="beta_info">Historial de transacciones</a></li>
              <li>                    <a  id="menuUserReferencesCenter" ng-click="navigateTo($event)" destination="beta_info">Centro de referencias</a></li>
              <li>                    <a  id="menuUserClassification"   ng-click="navigateTo($event)" destination="beta_info">Clasificación</a></li>
              <li>                    <a  id="menuUserAyuda"            ng-click="navigateTo($event)" destination="help_info">Ayuda</a></li>
              <!-- <li class="divider"></li> -->
              <li>                    <a  id="menuUserLogOut"           ng-click="logOut()"           destination="beta_info">Salir</a></li>
            </ul>
          </li>
         <!--  <li class="right-menu"><span class="current-balance">35.000€</span><button class="add-funds-button">AÑADIR FONDOS</button></li> -->
        </ul>
      </div>
    </div>

    <!-- lcabecera when NO logeado -->
    <div class="navbar-header-unloggin" ng-if="!profileService.isLoggedIn">
      <div id="brandLogoNotLogged" class="navbar-brand" ng-click="navigateTo($event)" destination="landing_page"></div>
      <div class="button-wrapper">
        <a id="joinButton"  type="button" class="button-join"  ng-click="navigateTo($event)" destination="join">REGISTRO</a>
        <a id="loginButton" type="button" class="button-login" ng-click="navigateTo($event)" destination="login">ENTRAR</a>
      </div>
      <div class="clearfix"></div>
    </div>

  </div>
</nav>"""));
tc.put("packages/webclient/components/paginator_comp.html", new HttpResponse(200, r"""<div class="paginator-wrapper">
  <div class="paginator-box" ng-model="buildMe()">
    <!-- Aqui van los botones -->
  </div>
</div>"""));
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
  <div class="header">TODOS LOS JUGADORES</div>
  <div class="body">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in AllPlayers">
      <span class="name">{{event["name"]}}</span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForGoalKeepers" class="panel-points">
  <div class="header">PORTEROS</div>
  <div class="body">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in GoalKeepers">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForDefenders" class="panel-points">
  <div class="header">DEFENSAS</div>
  <div class="body">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Defenders ">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForMidFielders" class="panel-points">
  <div class="header">CENTROCAMPISTAS</div>
  <div class="body">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in MidFielders">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>

<div id="scoringForForwards" class="panel-points">
  <div class="header">DELANTEROS</div>
  <div class="body">
    <div class="punctuation" ng-class="getClassesIsNegative(event['points'])" ng-repeat="event in Forwards">
      <span class="name">{{event["name"]}} </span>
      <span class="points"><b>{{event["points"]}}</b></span>
    </div>
  </div>
</div>"""));
tc.put("packages/webclient/components/view_contest/fantasy_team_comp.html", new HttpResponse(200, r"""<div id="fantasyTeamRoot" class="fantasy-team-wrapper" ng-cloak>

  <div class="fantasy-team-header" ng-class="{'opponent-team-gradient': isOpponent, 'header-view-contest-entry-mode': isViewContestEntryMode}">

    <div class="edit-team" ng-if="isViewContestEntryMode">
      <button class="btn-edit-team" ng-click="editTeam()">EDITAR EL EQUIPO</button>
    </div>

    <div class="ranking-box" ng-if="!isViewContestEntryMode">
      <span class="title">POS</span>
      <span class="content">{{userPosition}}</span>
    </div>

    <div class="score-box" ng-if="!isViewContestEntryMode">
      <span class="title">PUNTOS</span>
      <span class="content">{{userScore}}</span>
    </div>

    <div class="user-picture"></div>
    <div class="user-nickname" ng-class="{'nickname-view-contest-entry-mode': isViewContestEntryMode}">{{userNickname}}</div>
    <div class="total-remaining-matches-time" ng-if="!isViewContestEntryMode">TIEMPO RESTANTE: {{remainingTime}}</div>

    <div class="close-team" ng-click="onCloseButtonClick()" ng-show="showCloseButton">
      <span class="title">CERRAR</span>
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
          <span class="remaining-match-time" ng-if="!isViewContestEntryMode">{{slot.percentOfUsersThatOwn}}% LO TIENEN</span>
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
      <div id="teamsToggler" type="button" class="teams-toggler toggleOff" ng-click="toggleTeamsPanel()"  data-toggle="collapse" data-target="#teamsPanel">PARTIDOS EN ESTE TORNEO</div>
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
tc.put("packages/webclient/components/view_contest/users_list_comp.html", new HttpResponse(200, r"""<div id="usersListRoot" ng-cloak>

  <div ng-class="{'users-header-next': isViewContestEntryMode, 'users-header' : !isViewContestEntryMode}">
    <h1>USUARIOS EN ESTE TORNEO</h1>
    <h2 ng-if="!isViewContestEntryMode">Selecciona un usuario de esta lista para ver y comparar su alineacion con la tuya:</h2>
  </div>

  <div class="users-table-header">
    <div class="pos">POS</div>
    <div class="name" ng-class="{'name-view-contest-entry-mode': isViewContestEntryMode}">JUGADOR</div>
    <div class="remaining-time" ng-if="!isViewContestEntryMode">T.R.</div>
    <div class="score">PUNTOS</div>
    <div class="prize" ng-if="!isViewContestEntryMode">PREMIOS</div>
  </div>

  <div class="users-table-rows">
    <div class="user-row" ng-repeat="user in users" ng-click="onUserClick(user)" ng-class="{'user-main': isMainPlayer(user)}">
      <div class="pos">{{$index + 1}}</div>
      <div class="name" ng-class="{'name-view-contest-entry-mode': isViewContestEntryMode}">{{user.name}}</div>
      <div class="remaining-time" ng-if="!isViewContestEntryMode">{{user.remainingTime}}</div>
      <div class="score"><span>{{user.score}}</span></div>
      <div class="prize" ng-if="!isViewContestEntryMode">{{getPrize($index)}}</div>
    </div>
  </div>

</div>"""));
tc.put("packages/webclient/components/view_contest/view_contest_comp.html", new HttpResponse(200, r"""<section>

  <contest-header id="contestHeader" contest="contest" contest-id="contestId"></contest-header>
  <teams-panel id="teamsPanelComp" contest="contest" contest-id="contestId"></teams-panel>

  <div id="liveContestRoot" ng-switch="scrDet.isXsScreen" ng-cloak>
    <div ng-switch-when="true">
     <!-- Tabs de la versión XS -->
      <ul class="live-contest-tabs" id="liveContestTab" >
        <li class="active"> <a id="userFantasyTeamTab" ng-click="tabChange('userFantasyTeam')" data-toggle="tab">Tu alineación</a></li>
        <li>                <a id="usersListTab" ng-click="tabChange('usersList')" data-toggle="tab">Usuarios</a></li>
        <li ng-disabled="!isOpponentSelected"><a id="opponentFantasyTeamTab" ng-click="tabChange('opponentFantasyTeam')" data-toggle="tab">{{lastOpponentSelected}}</a></li>
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

  <div class="separator-bar"></div>
  <div class="info-complete-bar" ng-if="!isModeViewing">
    <p ng-if="isModeCreated">¡PERFECTO! HAS COMPLETADO TU ALINEACIÓN CON ÉXITO</p>
    <p ng-if="isModeEdited">¡PERFECTO! HAS EDITADO TU ALINEACIÓN CON ÉXITO</p>
    <p ng-if="isModeSwapped">EL TORNEO ESTABA LLENO PERO TE HEMOS METIDO EN ESTE QUE ES IGUAL</p>
    <p>Recuerda que puedes editar tu equipo cuantas veces quieras hasta que comience la competición</p>
  </div>

  <div id="viewContestEntry" ng-switch="scrDet.isXsScreen" ng-cloak>
    <div ng-switch-when="true">
      <!-- Tabs de la versión XS -->
      <ul class="view-contest-entry-tabs" id="viewContestEntryTab" >
        <li class="active"><a ng-click="tabChange('userFantasyTeam')" data-toggle="tab">Tu alineación</a></li>
        <li><a ng-click="tabChange('usersList')" data-toggle="tab">Usuarios</a></li>
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
      <div class="button-wrapper">
        <button type="button" class="btn-cancel-contest" ng-click="cancelContestEntry()">CANCELAR ENTRADA</button>
      </div>
      <div class="button-wrapper">
        <button type="button" class="btn-back-contest" ng-click="goToParent()">OTROS DESAFÍOS</button>
      </div>
    </div>
    <div class="clear-fix-bottom"></div>
  </div>

</section>"""));
}