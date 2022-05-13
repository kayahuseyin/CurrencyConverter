//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Hüseyin Kaya on 11.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // 1) Request & Session  info da değişiklik gerekli
        // 2) Response & Data
        // 3) Parsing & JSON Serialization işlemek için
        
        
        // 1. Adım
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        
        let session = URLSession.shared // url session'un objesini oluşturuyoruz. 1 obje üstünden gidecek istekler
        
        //Closure
        
        let task = session.dataTask(with: url!) { data, response, error in //istediğimiz isimleri veriyoruz
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true, completion: nil)
            } else {
                
                //2. Adım
                if data != nil {
                 
                    do { // hata olma ihtimali yüksek o yuzden xcode guvenmeyıp try yapmamızı istiyor
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> //anahtar kelimelerin hepsi string fakat karsısındakiler boolean double vb.
                        
                        // ASYNC senkronize olmadan
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                            
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tl)"
                                }
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                    
                    
                    
                    
                }
                
                
            }
        } // url vereceğiz bize output verecek
        
        task.resume() // bunu eklemeden işlem başlamıyor.
        
    }
    
}

