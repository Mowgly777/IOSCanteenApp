
import UIKit
import MSAL

class LoginViewController: UIViewController, UITextFieldDelegate, URLSessionDelegate  {
    
    let tenantName = "cccbf502-6b91-40d6-be02-5ffa0eb711d6"
    let clientId = "0da586eb-d44e-4a7d-9f4a-8763631a2cc2"
    let signInPolicy = ""
    let scopes: [String] = ["User.Read"]

    let endpoint = "%@"
    
    var accessToken = String()
    
    @IBOutlet weak var loggingText: UITextView!
    
    private let loginContentView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .red
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(authorizationButton), for: .touchUpInside)
        return btn
    }()
    
    let lblInvalid:UILabel = {
        let lbl = UILabel()
        lbl.text = "An error occured\nPlease try again"
        lbl.textColor = .red
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let imgLogo:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Logo2")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)

        return img
    }()
    
    let imgLogoContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpAutoLayout() {
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            loginContentView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        } else {
            loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            
        }
        loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //Imediately redraw the screen- this is needed because the following constraints are dependant on this parent view to get values
        loginContentView.layoutIfNeeded()
        
        //Button login constraints
        NSLayoutConstraint.activate([
            btnLogin.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor),
            btnLogin.centerYAnchor.constraint(equalTo: loginContentView.centerYAnchor, constant: loginContentView.frame.size.height/3),
            btnLogin.widthAnchor.constraint(equalTo: loginContentView.widthAnchor, constant: -100),
            btnLogin.heightAnchor.constraint(equalToConstant: 50),
            ])
    
        
        //Image logo container constraints
        NSLayoutConstraint.activate([
            imgLogoContainer.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor),
            imgLogoContainer.topAnchor.constraint(equalTo: loginContentView.topAnchor),
            imgLogoContainer.widthAnchor.constraint(equalTo: loginContentView.widthAnchor),
            imgLogoContainer.heightAnchor.constraint(equalTo: imgLogo.heightAnchor),
            ])
        
        //Image logo constraints
        NSLayoutConstraint.activate([
            imgLogo.centerXAnchor.constraint(equalTo: imgLogoContainer.centerXAnchor),
            imgLogo.topAnchor.constraint(equalTo: imgLogoContainer.topAnchor),
            imgLogo.heightAnchor.constraint(equalToConstant: 100),
            imgLogo.widthAnchor.constraint(equalToConstant: 200),
            ])
        
    }
    
    func showInvalidLabel(){
        self.loginContentView.addSubview(self.lblInvalid)
        self.lblInvalid.centerXAnchor.constraint(equalTo: self.loginContentView.centerXAnchor).isActive = true
        self.lblInvalid.topAnchor.constraint(equalTo: self.btnLogin.bottomAnchor).isActive = true
    }
    
    @IBAction func authorizationButton(_ sender: UIButton) {
        
        let authority = String(format: endpoint, tenantName, signInPolicy)
        
        do {
            let application = try MSALPublicClientApplication.init(clientId: clientId, authority: authority)
            
            application.acquireToken(forScopes: scopes) { (result, error) in
                if  error == nil {
                    self.accessToken = (result?.accessToken)!
                } else {
                    self.showInvalidLabel()
                }
            }
        } catch {
            self.showInvalidLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add sub views to content view
        imgLogoContainer.addSubview(imgLogo)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(imgLogoContainer)
        
        //Setup parent view
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        //Add content view to parent view
        view.addSubview(loginContentView)
        
        //Setup auto layout constraints
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


