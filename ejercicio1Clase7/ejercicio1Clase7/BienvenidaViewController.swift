//
//  ViewController.swift
//  ejercicio1Clase7
//
//  Created by sebas  on 17/12/22.
//

import UIKit

class BienvenidaViewController: UIViewController {
    
    private struct Constantes {
        static let ideintificadorTextFieldTag = 2
        static let cantidadDeDigitosDocumentoEstudiante = 5
        static let cantidadDeDigitosDocumentoProfesor = 6
        static let tituloDelBotonDeLaAlerta = "OK"
        static let tituloDeLaAlerta = "Ingrese"
        static let cuerpoDeLaAlerta = "Numero De Documento"
        static let textoPlaceholderDelTextField = "Numero"
        static let nombreSegueEstudiantes = "navegarHaciaEstudiante"
        static let nombreSegueProfesor = "navegarHaciaProfesor"
    }
    
    var alerta = UIAlertController()
    var okAccion = UIAlertAction()
    var numeroDeDocumento: String?
    
    @IBOutlet weak var labelDeResultado: UILabel!
    
    @IBAction func accionCuandoPresionoElBoton(_ sender: UIButton) {
        crearAlerta()
        configurarTextFieldEnLaAlerta()
        presentarAlerta()
        configuracionAccionEnLaAlerta()
    }
    
    func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
    }
    
    func configuracionAccionEnLaAlerta() {
        okAccion = UIAlertAction(title: Constantes.tituloDelBotonDeLaAlerta, style: .default) { _ in
            guard let campoDeTexto = self.alerta.textFields else {
                return
            }
            guard let documentoTextField = campoDeTexto.first(where: { textFieldBajoAnalisis in
                return textFieldBajoAnalisis.tag == Constantes.ideintificadorTextFieldTag
            }) else {
                return
            }
            self.numeroDeDocumento = documentoTextField.text ?? ""
            self.verificarSiDocumentoIngresadoEsEstudianteOProfesor()
        }
        agregarAccionAlaAlerta()
    }
    
    func configurarTextFieldEnLaAlerta() {
        alerta.addTextField { campoDeTextoAConfigurar in
            campoDeTextoAConfigurar.placeholder = Constantes.textoPlaceholderDelTextField
            campoDeTextoAConfigurar.tag = Constantes.ideintificadorTextFieldTag
            campoDeTextoAConfigurar.keyboardType = .numberPad
        }
    }
    
    func agregarAccionAlaAlerta() {
        alerta.addAction(okAccion)
    }
    
    func presentarAlerta() {
        present(alerta, animated: true)
    }
    
    func mostrarMensajeDeResultado(mensaje: String) {
        labelDeResultado.text = mensaje
        labelDeResultado.isHidden = false
    }
    
    func verificarSiDocumentoIngresadoEsEstudianteOProfesor() {
        if numeroDeDocumento?.count == Constantes.cantidadDeDigitosDocumentoEstudiante {
            presentarVistaEstudiante()
        }else if numeroDeDocumento?.count == Constantes.cantidadDeDigitosDocumentoProfesor {
            presentarVistaProfesor()
        } else {
            presentarResultadoEnElLabel()
        }
    }
    
    func presentarResultadoEnElLabel() {
        mostrarMensajeDeResultado(mensaje: "No Se Encuentra Rol Con El Documento: \(self.numeroDeDocumento ?? "")")
    }
    
    func presentarVistaEstudiante() {
        performSegue(withIdentifier: Constantes.nombreSegueEstudiantes, sender: self)
    }
    
    func presentarVistaProfesor() {
        performSegue(withIdentifier: Constantes.nombreSegueProfesor, sender: self)
    }
}

