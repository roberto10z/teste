//
//  MainTableViewController.swift
//  MyToDoList
//
//  Created by Roberto de Oliveira Rodrigues on 16/09/17.
//  Copyright © 2017 Roberto de Oliveira Rodrigues. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    struct Afazeres { //os dois arrays das listas
        var listaCompletas : [(String,String)] = []
        var listaIncompletas : [(String,String)] = []
    }
    
    var meusAfazeres = Afazeres()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Minhas Listas"
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MainTableViewController.addAfazeres))
        
        tableView.rowHeight = UITableViewAutomaticDimension //muda o tamanho da caixa pela quantidade de palavras digitas
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0{ //as duas section das tarefas
            return 	self.meusAfazeres.listaIncompletas.count
        }else{
            return 	self.meusAfazeres.listaCompletas.count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return 	"Lista para fazer"
        }else{
            return 	"Lista feita"
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAfazeres", for: indexPath)
        
        if indexPath.section == 0{
            cell.textLabel?.text = self.meusAfazeres.listaIncompletas[indexPath.row].0
            cell.detailTextLabel?.text = self.meusAfazeres.listaIncompletas[indexPath.row].1
        }else{
            cell.textLabel?.text = self.meusAfazeres.listaCompletas[indexPath.row].0
            cell.detailTextLabel?.text = self.meusAfazeres.listaCompletas[indexPath.row].1
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //func para alterar a tarefa de feita para nao feita e
        
        if indexPath.section == 0{
            let removido = self.meusAfazeres.listaIncompletas.remove(at: indexPath.row)
            self.meusAfazeres.listaCompletas.append(removido)
        }else{
            
            let removido = self.meusAfazeres.listaCompletas.remove(at: indexPath.row)
            self.meusAfazeres.listaIncompletas.append(removido)
        }
        
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{ // func para deletar a tarefa
            
            if indexPath.section == 0{
                self.meusAfazeres.listaIncompletas.remove(at: indexPath.row)
                
            }else{
                
                self.meusAfazeres.listaCompletas.remove(at: indexPath.row)
                
            }
            
        }
        
        
        self.tableView.reloadData()
        
    }
    
    
    func addAfazeres(){
        let meuAlerta = UIAlertController(title: "Nova Tarefa", message: "Insira a tarefa e a sua descrição", preferredStyle: UIAlertControllerStyle.alert)
        
        let confirmarAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default) { (alert) in
            if let titulo = (meuAlerta.textFields![0] as UITextField).text {
                let desc = (meuAlerta.textFields![1] as UITextField).text ?? ""
                self.meusAfazeres.listaIncompletas.append((titulo,desc))
                
                self.tableView.reloadData()
                
            }
        }
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil) //cancelar tarefa
        
        meuAlerta.addTextField { (textField) in
            
            textField.placeholder = "Digite o titulo da tarefa aqui: "
        }
        
        meuAlerta.addTextField { (textField) in
            
            textField.placeholder = "Digite a descrição da tarefa aqui: "
        }
        // nao vai
        meuAlerta.addAction(confirmarAction)
        meuAlerta.addAction(cancel)
        self.present(meuAlerta, animated: true, completion: nil)
        
    }
}
