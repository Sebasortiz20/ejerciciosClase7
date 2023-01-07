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
    
    @IBOutlet weak var labelDeResultado: UILabel!
    
    private var alerta: UIAlertController?
    private var okAccion: UIAlertAction?
    private var numeroDeDocumento: String?
    private var documentoTextField: UITextField?
    
    override func viewDidLoad() {
        crearAlerta()
        configurarTextFieldEnLaAlerta()
        configuracionAccionEnLaAlerta()
    }
    
    private func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
    }
    
    private func configurarTextFieldEnLaAlerta() {
        alerta?.addTextField { campoDeTextoAConfigurar in
            campoDeTextoAConfigurar.placeholder = Constantes.textoPlaceholderDelTextField
            campoDeTextoAConfigurar.tag = Constantes.ideintificadorTextFieldTag
            campoDeTextoAConfigurar.keyboardType = .numberPad
        }
    }
    
    private func configuracionAccionEnLaAlerta() {
        okAccion = UIAlertAction(title: Constantes.tituloDelBotonDeLaAlerta, style: .default) { _ in
            self.procesarAccionOK()
        }
        if let alertaSegura = alerta, let okAccionSegura = okAccion  {
            alertaSegura.addAction(okAccionSegura)
        }
    }
    
    private func procesarAccionOK() {
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
    
    private func extraerNumeroDeDocumento() {
        self.numeroDeDocumento = documentoTextField?.text ?? ""
    }
    
    private func borrarCampoDeTextoDeLaAlerta() {
        if let documentoTextFielSeguro = documentoTextField {
            documentoTextFielSeguro.text = ""
        }
    }
    
    private func procesarDocumentoIngresado() {
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
    
    private func presentarVistaEstudiante() {
        performSegue(withIdentifier: Constantes.nombreSegueEstudiantes, sender: self)
    }
    
    private func presentarVistaProfesor() {
        performSegue(withIdentifier: Constantes.nombreSegueProfesor, sender: self)
    }
    
    private func presentarNoIngresoDocumentoEnElLabel() {
        mostrarMensajeDeResultado(mensaje: Constantes.noIngresoNingunDocumento)
    }
    
    private func presentarNoSeEcuentraRolEnElLabel() {
        mostrarMensajeDeResultado(mensaje: "\(Constantes.noSeEncuentraRol) \(self.numeroDeDocumento ?? "")")
    }
    
    private func mostrarMensajeDeResultado(mensaje: String) {
        labelDeResultado.text = mensaje
        labelDeResultado.isHidden = false
    }
    
    @IBAction func accionCuandoPresionoElBoton(_ sender: UIButton) {
        presentarAlerta()
    }
    
    private func presentarAlerta() {
        if let alertaSegura = alerta {
            present(alertaSegura, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
}

