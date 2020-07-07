import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage


class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var img: UIImageView!
    /*
     let heightInPoints = image.size.height
     let heightInPixels = heightInPoints * image.scale
 */
    var storageRef = Storage.storage()
    var db: Firestore!
    var username2 = ""
    var foodType2 = 2
    var glutenFree2 = false
    var oneName = ""
    var twoName = ""
    var cameFromGoogle = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        goatUser = Auth.auth().currentUser?.uid
        imagePicker.delegate = self
        img.frame.size.width = img.frame.size.height
        img.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
        db = Firestore.firestore()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        img.layer.cornerRadius = img.frame.size.height / 2
    }
    
    @IBAction func profilePicBackButton(_ sender: Any) {
        
        if cameFromGoogle   {
            performSegue(withIdentifier: "profilePicBackGoogle", sender: self)
        }
        else    {
            performSegue(withIdentifier: "profilePicBackStandard", sender: self)
        }
        
    }
    
    @IBAction func onClickPickImage(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            img.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
        img.layer.cornerRadius = img.frame.size.height / 2
        
        
    
    }
    
    @IBAction func profileFirebaseSender(_ sender: Any) {
        
        
        let storageRef = Storage.storage().reference().child("\(goatUser!).png")
        
        if let uploadData = self.img.image?.pngData() {
        
            storageRef.putData(uploadData, metadata: nil) { ( metadata, error ) in
                if error != nil {
                    //print(error)
                    return
                }
                
                //print(metadata)
                
            }
        
        }
        
        performSegue(withIdentifier: "AllergySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AllergySegue"    {
            
            let destination: AllergyViewController = segue.destination as! AllergyViewController
            // destination.currentEmail2 = currentEmail
            destination.foodType = foodType2
            destination.glutenFree = glutenFree2
            destination.username = username2
            destination.firstName = oneName
            destination.lastName = twoName
            
        }
    }
    
}
