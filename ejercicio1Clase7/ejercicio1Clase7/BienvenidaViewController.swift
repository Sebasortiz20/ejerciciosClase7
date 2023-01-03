//
//  ViewController.swift
//  ejercicio1Clase7
//
//  Created by sebas  on 17/12/22.
//

import UIKit

class BienvenidaViewController: UIViewController {
    
    override func viewDidLoad() {
        crearAlerta()
        configurarTextFieldEnLaAlerta()
        configuracionAccionEnLaAlerta()
    }
    
    private struct Constantes {
        static let ideintificadorTextFieldTag = 2
        static let cantidadDeDigitosDocumentoEstudiante = 5
        static let cantidadDeDigitosDocumentoProfesor = 6
        static let sinNumeroIngresado = 0
        static let tituloDelBotonDeLaAlerta = "OK"
        static let tituloDeLaAlerta = "Ingrese"
        static let cuerpoDeLaAlerta = "Numero De Documento"
        static let textoPlaceholderDelTextField = "Numero"
        static let nombreSegueEstudiantes = "navegarHaciaEstudiante"
        static let nombreSegueProfesor = "navegarHaciaProfesor"
        static let noIngresoNingunDocumento = "No Ingreso Ningun Documento"
        static let noSeEncuentraRol = "No Se Encuentra Rol Con El Numero De Documento: "
    }
    
    var alerta: UIAlertController?
    var okAccion: UIAlertAction?
    var numeroDeDocumento: String?
    var documentoTextField: UITextField?
    
    @IBOutlet weak var labelDeResultado: UILabel!
    
    @IBAction func accionCuandoPresionoElBoton(_ sender: UIButton) {
        presentarAlerta()
    }
    
    func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
    }
    
    func configurarTextFieldEnLaAlerta() {
        alerta?.addTextField { campoDeTextoAConfigurar in
            campoDeTextoAConfigurar.placeholder = Constantes.textoPlaceholderDelTextField
            campoDeTextoAConfigurar.tag = Constantes.ideintificadorTextFieldTag
            campoDeTextoAConfigurar.keyboardType = .numberPad
        }
    }
    
    func procesarAccionOK() {
        guard let conjuntoDeCampoDeTexto = self.alerta?.textFields else {
            return
        }
        guard let documentoTextField = conjuntoDeCampoDeTexto.first(where: { textFieldBajoAnalisis in
            return textFieldBajoAnalisis.tag == Constantes.ideintificadorTextFieldTag
        }) else {
            return
        }
        self.documentoTextField = documentoTextField
        extraerNumeroDeDocumento()
        borrarCampoDeTextoDeLaAlerta()
        self.procesarDocumentoIngresado()
    }
    
    func borrarCampoDeTextoDeLaAlerta() {
        if let documentoTextFielSeguro = documentoTextField {
            documentoTextFielSeguro.text = ""
        }
    }
    
    func extraerNumeroDeDocumento() {
        self.numeroDeDocumento = documentoTextField?.text ?? ""
    }
    
    func configuracionAccionEnLaAlerta() {
        okAccion = UIAlertAction(title: Constantes.tituloDelBotonDeLaAlerta, style: .default) { _ in
            self.procesarAccionOK()
        }
        if let alertaSegura = alerta, let okAccionSegura = okAccion  {
            alertaSegura.addAction(okAccionSegura)
        }
    }
    
    func presentarAlerta() {
        if let alertaSegura = alerta {
            present(alertaSegura, animated: true)
        }
    }
    
    func mostrarMensajeDeResultado(mensaje: String) {
        labelDeResultado.text = mensaje
        labelDeResultado.isHidden = false
    }
    
    func procesarDocumentoIngresado() {
        if numeroDeDocumento?.count == Constantes.cantidadDeDigitosDocumentoEstudiante {
            presentarVistaEstudiante()
        } else if numeroDeDocumento?.count == Constantes.cantidadDeDigitosDocumentoProfesor {
            presentarVistaProfesor()
        } else if numeroDeDocumento?.count == Constantes.sinNumeroIngresado {
            presentarNoIngresoDocumentoEnElLabel()
        } else {
            presentarNoSeEcuentraRolEnElLabel()
        }
    }
    
    func presentarNoIngresoDocumentoEnElLabel() {
        mostrarMensajeDeResultado(mensaje: Constantes.noIngresoNingunDocumento)
    }
    
    func presentarNoSeEcuentraRolEnElLabel() {
        mostrarMensajeDeResultado(mensaje: "\(Constantes.noSeEncuentraRol) \(self.numeroDeDocumento ?? "")")
    }
    
    func presentarVistaEstudiante() {
        performSegue(withIdentifier: Constantes.nombreSegueEstudiantes, sender: self)
    }
    
    func presentarVistaProfesor() {
        performSegue(withIdentifier: Constantes.nombreSegueProfesor, sender: self)
    }
}

