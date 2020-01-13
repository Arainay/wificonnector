import UIKit
import NetworkExtension

@objc(WiFiConnector)
@available(iOS 11, *)
class WiFiConnector : CDVPlugin {
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    if !msg.isEmpty {
      let toastController: UIAlertController =
        UIAlertController(
          title: "",
          message: msg,
          preferredStyle: .alert
        )
      
      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toastController.dismiss(
            animated: true,
            completion: nil
        )
      }
        
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
    
    @objc(isSecure:SSID:password:isWEP:)
    func connect(isSecure: Bool, SSID: String, password: String, isWEP: Bool) {
        let hotspotConfig = isSecure ? NEHotspotConfiguration(ssid: SSID, passphrase: password, isWEP: isWEP) : NEHotspotConfiguration(ssid: SSID)
        
        NEHotspotConfigurationManager.shared.apply(hotspotConfig) {[unowned self] (error) in
            
            if let error = error {
                self.showError(error: error)
            }
            else {
                self.showSuccess()
            }
        }
    }
    
    private func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Darn", style: .default, handler: nil)
        alert.addAction(action)
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    private func showSuccess() {
        let alert = UIAlertController(title: "", message: "Connected", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cool", style: .default, handler: nil)
        alert.addAction(action)
        self.viewController?.present(alert, animated: true, completion: nil)
    }
}
