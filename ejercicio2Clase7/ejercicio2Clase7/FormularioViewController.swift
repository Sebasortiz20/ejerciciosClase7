//
//  ViewController.swift
//  ejercicio2Clase7
//
//  Created by sebas  on 19/12/22.
//

import UIKit

class FormularioViewController: UIViewController {
    
    struct Constantes {
        static let probabilidadMaxima = 3
        static let tituloDeLaAlerta = "Error"
        static let cuerpoDeLaAlerta = "Fue Imposible Enviar Informacion Al Servidor"
        static let nombreDelBottonDeLaAlerta = "Aceptar"
        static let nombreDelSegueAgradecimiento = "navegarHaciaVistaAgradecimiento"
    }
    
    var alerta = UIAlertController()
    var aceptarAction = UIAlertAction()
    var contador = 1
    
    @IBAction func accionEnviarDatos(_ sender: UIButton) {
        crearAlerta()
        agregarBotonAlerta()
        probalidadDeErroraAlActulizarContador()
    }
    
    func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
    }
    
    func agregarBotonAlerta(){
        aceptarAction = UIAlertAction(title: Constantes.nombreDelBottonDeLaAlerta, style: .default)
        alerta.addAction(aceptarAction)
    }
    
    func presentarAlerta() {
        present(alerta, animated: true)
    }
    
    func probalidadDeErroraAlActulizarContador () {
        contador = contador + 1
        if contador > Constantes.probabilidadMaxima {
            contador = 1
            presentarAlerta()
        }else{
            presentarVistaAgradecimiento()
        }
    }
    
    func presentarVistaAgradecimiento() {
        performSegue(withIdentifier: Constantes.nombreDelSegueAgradecimiento, sender: self)
    }
}

