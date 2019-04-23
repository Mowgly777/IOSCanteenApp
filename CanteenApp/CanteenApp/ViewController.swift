
import UIKit
import MSAL

class ViewController: UIViewController, UITextFieldDelegate, URLSessionDelegate  {
    
    let tenantName = "cccbf502-6b91-40d6-be02-5ffa0eb711d6"
    let clientId = "0da586eb-d44e-4a7d-9f4a-8763631a2cc2"
    let signInPolicy = ""
    let scopes: [String] = ["User.Read"]

    let endpoint = "https://login.microsoftonline.com/%@/%@"
    
    var accessToken = String()
    
//    @IBOutlet weak var loggingText: UITextView!
//
//    @IBAction func authorizationButton(_ sender: UIButton) {
//
//        let authority = String(format: endpoint, tenantName, signInPolicy)
//
//        do {
//            let application = try MSALPublicClientApplication.init(clientId: clientId, authority: authority)
//
//            application.acquireToken(forScopes: scopes) { (result, error) in
//                    if  error == nil {
//                        self.accessToken = (result?.accessToken)!
//                        self.loggingText.text = "Access token is \(self.accessToken)"
//                    } else {
//                        self.loggingText.text = "Could not acquire token: \(error ?? "No error informarion" as! Error)"
//                    }
//            }
//        } catch {
//            self.loggingText.text = "Unable to create application \(error)"
//        }
//    }
    
    private let loginContentView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let unameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Username"
        return txtField
    }()
    
    private let pwordTxtField:UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Password"
        return txtField
    }()
    
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .black
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setUpAutoLayout() {
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        unameTxtField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant:20).isActive = true
        unameTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        unameTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        unameTxtField.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        pwordTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        pwordTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        pwordTxtField.topAnchor.constraint(equalTo:unameTxtField.bottomAnchor, constant:20).isActive = true
        pwordTxtField.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo:pwordTxtField.bottomAnchor, constant:20).isActive = true
        btnLogin.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        btnLogin.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant:50).isActive = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginContentView.addSubview(unameTxtField)
        loginContentView.addSubview(pwordTxtField)
        loginContentView.addSubview(btnLogin)
        
        view.addSubview(loginContentView)
        
        setUpAutoLayout()
        
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


