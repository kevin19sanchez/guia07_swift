//
//  ConceptoViewController.swift
//  GUIA07
//
//  Created by kevin on 24/9/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ConceptoViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var context:NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var descripcion:UITextField!
    @IBOutlet weak var valor:UITextField!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var pickerView:UIPickerView!
    
    var categoriaList:[Categoria] = []
    
    override func viewDidLoad() {
        context = appDelegate.persistentContainer.viewContext
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    @IBAction func guardar(_ sender: Any) {
        //Obtenemos la categoria seleccionada del picker
        let categoria = categoriaList[pickerView.selectedRow(inComponent: 0)]
        //Creamos una nueva instancia
        let concepto = Concepto(context: context!)
        //Asignamos atributos
        concepto.categoria = categoria
        concepto.descripcion = descripcion.text
        concepto.valor = Double(valor.text!)!
        
        concepto.fecha = datePicker.date
        //Guardamos y limpiamos los campos
        do{
            try context?.save()
            descripcion.text = ""
            valor.text = ""
            datePicker.date = Date()
            pickerView.selectRow(1, inComponent: 0, animated: true)
        }catch{
            print("Couldn't save Concepto")
        }
    }
    
    func loadData(){
        do{
            //Se crea un Request a la Entidad
            let fetchRequest: NSFetchRequest<Categoria> = Categoria.fetchRequest()
            //Se obtienen los datos
            let fetchedCategorias = try context?.fetch(fetchRequest)
            
            //Imprimimos la lista para depuracion
            
            for categoria in fetchedCategorias!{
                print ("\(String(categoria.nombre!)) -> \(categoria.descripcion!)")
            }
            
            //Asignamos la lista
            categoriaList = fetchedCategorias!
            
        }catch{
            print("Couldn't fetch")
        }
        pickerView.reloadAllComponents()
    }
    
    //Funciones para el picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Funciones para el picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriaList.count
    }
    
    //Funciones para el picker (De UIPickerViewDelegate)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categoriaList[row].nombre
    }
}
