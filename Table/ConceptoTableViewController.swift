//
//  ConceptoTableViewController.swift
//  GUIA07
//
//  Created by kevin on 1/10/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ConceptoTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet  weak var tableView:UITableView!
    var context:NSManagedObjectContext? //Contexto
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var conceptosList:[Concepto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //Iniciamos el contexto
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()//Cargamos los datos
    }
    
    //Funciones para la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conceptosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conceptoCell") as! ConceptoTableViewCell
        
        //Cargamos los datos en la celda
        cell.categoria.text = conceptosList[indexPath.row].categoria?.descripcion
        cell.descripcion.text = conceptosList[indexPath.row].descripcion
        
        //Formateamos la fecha a String
        //Para poderla mostrar
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "dd-MM-yyyy"
        let stringFecha = dateFormatterDate.string(from: conceptosList[indexPath.row].fecha!)
        cell.fecha.text = stringFecha
        cell.valor.text = String(conceptosList[indexPath.row].valor)
        return cell
    }
    
    func loadData(){
        do{
            //Se crea un Request a la Entidad
            let fetchRequest:NSFetchRequest<Concepto> = Concepto.fetchRequest()
            //Se obtienen los datos
            let fetchedConceptos = try context?.fetch(fetchRequest)
            self.conceptosList = fetchedConceptos!
            //Imprimimos la lista para depuracion
            for tmp in conceptosList{
                print(tmp.descripcion!)
            }
            tableView.reloadData() //Recargamos los datos
        }catch{
            print("Couldn't fetch objetos")
        }
    }


}
