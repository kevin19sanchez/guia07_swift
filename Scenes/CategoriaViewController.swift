//
//  CategoriaViewController.swift
//  GUIA07
//
//  Created by kevin on 24/9/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoriaViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    
    let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext?//contexto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //iniciamos el contexto
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func guardar(_ sender: Any){
        //creamos una nueva instancia
        let categoria = Categoria(context: context!)
        //asinagmos atributos
        categoria.nombre = self.nombre.text
        categoria.descripcion = self.descripcion.text
        
        //guardamos y limpiamos campos
        do{
            try context?.save()
            self.nombre.text = ""
            self.descripcion.text = ""
        }catch{
            print("Error saving")
        }
    }
}
