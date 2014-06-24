library landing_page_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'landing-page',
    templateUrl: 'packages/webclient/components/landing_page_comp.html',
    publishAs: 'landingPage',
    useShadowDom: false
)
class LandingPageComp  implements DetachAware, AttachAware {

    String content;
    HtmlElement mainWrapper;
    HtmlElement containerForContent;
    bool isLoggedIn;

    LandingPageComp(Scope scope, this._router, this._profileService) {
        isLoggedIn  = _profileService.isLoggedIn;

        if(isLoggedIn)
            _router.go('lobby', {});

        // Capturamos el elemento wrapper
        mainWrapper = document.getElementById('mainWrapper');
        containerForContent = document.getElementById('mainContent');
    }

    void attach() {
       mainWrapper.classes.clear();
       mainWrapper.classes.add('landing-wrapper');
       containerForContent.classes.clear();
    }

    void detach() {
        mainWrapper.classes.clear();
        mainWrapper.classes.add('wrapper-content-container');
        containerForContent.classes.add('main-content-container');
    }

    Router _router;
    ProfileService _profileService;
}