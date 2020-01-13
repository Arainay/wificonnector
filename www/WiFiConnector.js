exports.echo = function(arg0, success, error) {
	cordova.exec(success, error, 'WiFiConnector', 'echo', [arg0]);
};

exports.connect = function(isSecure, ssid, password, isWep, success, error) {
	cordova.exec(success, error, 'WiFiConnector', 'connect', [isSecure, ssid, password, isWep]);
};
