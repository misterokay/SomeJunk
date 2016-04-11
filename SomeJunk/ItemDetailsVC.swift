//
//  ItemDetailsVC.swift
//  SomeJunk
//
//  Created by Kevin Ok on 4/10/16.
//  Copyright © 2016 Monsieurdaccord. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        ad.saveContext()

        
        
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            
            if let title = item.title {
                titleField.text = title
            }
            
            if let price = item.price {
                priceField.text = "\(price)"
            }
            
            if let details = item.details {
                detailsField.text = details
            }
            
            
            
            if let store = item.store {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index = index + 1
                } while (index < stores.count)
            }
        }
    }
    
    func getStores() {
        let fetchRequest = NSFetchRequest(entityName: "Store")
        
        do {
            self.stores = try ad.managedObjectContext.executeFetchRequest(fetchRequest) as! [Store]
            self.storePicker.reloadAllComponents()
        } catch {
            //handle error
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        //must write error handling for empty fields
        
        var item: Item!
        
        if itemToEdit == nil {
            item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            let priceStr = NSString(string: price)
            let priceDbl = priceStr.doubleValue
            item.price = NSNumber(double: priceDbl)
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.store = stores[storePicker.selectedRowInComponent(0)]
        
        ad.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        if itemToEdit != nil {
            ad.managedObjectContext.deleteObject(itemToEdit!)
            ad.saveContext()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}






























