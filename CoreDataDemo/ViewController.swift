//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Nisha Sowdri NM on 24/06/2015.
//  Copyright (c) 2015 appi5. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    
    @IBAction func save(sender: UIButton) {
        
        let entityDescription =
        NSEntityDescription.entityForName("Contacts",
            inManagedObjectContext: managedObjectContext!)
        
        let contact = Contacts(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        contact.name = name.text
        contact.address = address.text
        contact.phone = phone.text
        
        var error: NSError?
        
        managedObjectContext?.save(&error)
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            name.text = ""
            address.text = ""
            phone.text = ""
            status.text = "Contact Saved"
        }
    }
    
    @IBAction func find(sender: AnyObject) {
        let entityDescription =
        NSEntityDescription.entityForName("Contacts",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", name.text)
        request.predicate = pred
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                name.text = match.valueForKey("name") as! String
                address.text = match.valueForKey("address") as! String
                phone.text = match.valueForKey("phone") as! String
                status.text = "Matches found: \(results.count)"
            } else {
                status.text = "No Match"
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

