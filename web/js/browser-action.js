var parser = new UAParser();

function isValidBrowser(userAgentDetected) {
    var valid = true;

    switch (userAgentDetected.browser.name) {
        case "IE":
            valid = userAgentDetected.browser.version >= "9";
            break;

        case "Firefox":
            valid = userAgentDetected.browser.version >= "16";
            break;

        case "Chrome":
            valid = userAgentDetected.browser.version >= "27";
            break;

        case "Safari":
            valid = userAgentDetected.browser.version >= "7";
            break;

        case "Opera":
            valid = userAgentDetected.browser.version >= "12";
            break;
    }

    return valid;
}

if (!isValidBrowser(parser.getResult())) {
    window.location = "/unsupported.html";
}
