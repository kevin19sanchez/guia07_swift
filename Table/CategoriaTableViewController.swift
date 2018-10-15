//
//  CategoriaTableViewController.swift
//  GUIA07
//
//  Created by kevin on 1/10/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoriaTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext?//Contexto
    var categoriasList:[Categoria] = []
    
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
        return categoriasList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriaCell") as! CategoriaTableViewCell
        cell.nombre.text = self.categoriasList[indexPath.row].nombre
        cell.descripcion.text = self.categoriasList[indexPath.row].descripcion
        return cell
    }
    
    //Funcion para cargar los datos de la base de datos
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
            categoriasList = fetchedCategorias!
        }catch{
            print("Couldn't fetch data")
        }
        self.tableView.reloadData()//Recargamos los datos
    }

    
    
    
}
