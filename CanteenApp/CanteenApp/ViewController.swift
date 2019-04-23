
import UIKit
import MSAL


class ViewController: UIViewController, UITextFieldDelegate, URLSessionDelegate  {
    
    let tenantName = "cccbf502-6b91-40d6-be02-5ffa0eb711d6"
    let clientId = "0da586eb-d44e-4a7d-9f4a-8763631a2cc2"
    let signInPolicy = ""
    let scopes: [String] = ["User.Read"]

    let endpoint = "https://login.microsoftonline.com/%@/%@"
    
    var accessToken = String()
    
    @IBOutlet weak var loggingText: UITextView!
    
    @IBAction func authorizationButton(_ sender: UIButton) {
        
        let authority = String(format: endpoint, tenantName, signInPolicy)
        
        do {
            let application = try MSALPublicClientApplication.init(clientId: clientId, authority: authority)
            
            application.acquireToken(forScopes: scopes) { (result, error) in
                    if  error == nil {
                        self.accessToken = (result?.accessToken)!
                        self.loggingText.text = "Access token is \(self.accessToken)"
                    } else {
                        self.loggingText.text = "Could not acquire token: \(error ?? "No error informarion" as! Error)"
                    }
            }
        } catch {
            self.loggingText.text = "Unable to create application \(error)"
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getUserByPolicy (withUsers: [MSALUser], forPolicy: String) throws -> MSALUser? {
        
        for user in withUsers {
            if (user.userIdentifier().components(separatedBy: ".")[0].hasSuffix(forPolicy.lowercased())) {
                return user
            }
        }
        return nil
    }
}

