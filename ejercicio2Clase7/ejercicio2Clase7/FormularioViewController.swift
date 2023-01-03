//
//  ViewController.swift
//  ejercicio2Clase7
//
//  Created by sebas  on 19/12/22.
//

import UIKit

class FormularioViewController: UIViewController {
    
    override func viewDidLoad() {
        crearAlerta()
    }
    
    enum EstadoFormulario {
        case nombreValido, sexoValido, tipoDeDocumentoValido, numeroDeDocumentoValido, nombreVacio, sexoVacio, tipoDeDocumentoVacio, numeroDeDocumentoVacio
    }
    
    struct Constantes {
        static let probabilidadMaxima = 3
        static let tituloDeLaAlerta = "Error"
        static let cuerpoDeLaAlerta = "Fue Imposible Enviar Informacion Al Servidor"
        static let nombreDelBottonDeLaAlerta = "Aceptar"
        static let nombreDelSegueAgradecimiento = "navegarHaciaVistaAgradecimiento"
    }
    
    @IBOutlet weak var nombreTextFIeld: UITextField!
    @IBOutlet weak var sexoTextFIeld: UITextField!
    @IBOutlet weak var tipoDeDocumentoTextField: UITextField!
    @IBOutlet weak var numeroDeDocumentoTextFIeld: UITextField!
    
    var nombre: String?
    var sexo: String?
    var tipoDeDocumento: String?
    var numeroDeDocumento: String?
    var alerta: UIAlertController?
    var aceptarAction: UIAlertAction?
    
    var resultadosDeValidacion: [EstadoFormulario] = []
    
    @IBAction func accionEnviarDatos(_ sender: UIButton) {
        limpiarResultadosDeValidacion()
        extraerDatos()
        validacionDeCamposDelFormulario()
        procesarCredenciales()
        determinarColoresCamposDeFormulario()
    }
    
    func limpiarResultadosDeValidacion() {
        resultadosDeValidacion = []
    }
    
    func extraerDatos() {
        nombre = nombreTextFIeld.text ?? ""
        sexo = sexoTextFIeld.text ?? ""
        tipoDeDocumento = tipoDeDocumentoTextField.text ?? ""
        numeroDeDocumento = numeroDeDocumentoTextFIeld.text ?? ""
    }
    
    func validarCampoNombre() {
        if let nombreSeguro = nombre {
            if nombreSeguro.isEmpty {
                resultadosDeValidacion.append(.nombreVacio)
            } else {
                resultadosDeValidacion.append(.nombreValido)
            }
        }
    }
    
    func validarCampoSexo() {
        if let sexoSeguro = sexo {
            if sexoSeguro.isEmpty {
                resultadosDeValidacion.append(.sexoVacio)
            } else {
                resultadosDeValidacion.append(.sexoValido)
            }
        }
    }
    
    func validarCampoTipoDeDocumento() {
        if let tipoDeDocumentoSeguro = tipoDeDocumento {
            if tipoDeDocumentoSeguro.isEmpty {
                resultadosDeValidacion.append(.tipoDeDocumentoVacio)
            } else {
                resultadosDeValidacion.append(.tipoDeDocumentoValido)
            }
        }
    }
    
    func validarCampoNumeroDeDocumento() {
        if let numeroDeDocumentoSeguro = numeroDeDocumento {
            if numeroDeDocumentoSeguro.isEmpty {
                resultadosDeValidacion.append(.numeroDeDocumentoVacio)
            } else {
                resultadosDeValidacion.append(.numeroDeDocumentoValido)
            }
        }
    }
    
    func validacionDeCamposDelFormulario() {
        validarCampoNombre()
        validarCampoSexo()
        validarCampoTipoDeDocumento()
        validarCampoNumeroDeDocumento()
    }
    
    func procesarCredenciales() {
        if let nombreSeguro = nombre, let sexoSeguro = sexo, let tipoDeDocumentoSeguro = tipoDeDocumento, let numeroDeDocumentoSeguro = numeroDeDocumento {
            let lasCredencialesSonValidas = validarCredenciales(nombre: nombreSeguro, sexo: sexoSeguro, tipoDeDocumento: tipoDeDocumentoSeguro, numeroDeDocumento: numeroDeDocumentoSeguro )
            procesarResultadoDeLaValidación(resultado: lasCredencialesSonValidas)
        }
    }
    
    func validarCredenciales(nombre: String, sexo: String, tipoDeDocumento: String, numeroDeDocumento: String) -> Bool {
        let condicion = nombre != "" && sexo != "" && tipoDeDocumento != "" && numeroDeDocumento != ""
        if  condicion {
            return true
        } else {
            return false
        }
    }
    
    func procesarResultadoDeLaValidación(resultado: Bool) {
        if resultado {
            aplicarProbalidadDeErroraAlActulizarContador()
        }
    }
    
    func determinarColorCampoNombre() {
        nombreTextFIeld.backgroundColor = resultadosDeValidacion.contains(.nombreValido) ? .systemBackground : .brown
    }
    
    func determinarColorCampoSexo() {
        sexoTextFIeld.backgroundColor = resultadosDeValidacion.contains(.sexoValido) ? .systemBackground : .brown
    }
    
    func determinarColorCampoTipoDeDocumento() {
        tipoDeDocumentoTextField.backgroundColor = resultadosDeValidacion.contains(.tipoDeDocumentoValido) ? .systemBackground : .brown
    }
    
    func determinarColorCampoNumeroDeDocumento() {
        numeroDeDocumentoTextFIeld.backgroundColor = resultadosDeValidacion.contains(.numeroDeDocumentoValido) ? .systemBackground : .brown
    }
    
    func determinarColoresCamposDeFormulario() {
        determinarColorCampoNombre()
        determinarColorCampoSexo()
        determinarColorCampoTipoDeDocumento()
        determinarColorCampoNumeroDeDocumento()
    }
    
    func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
        aceptarAction = UIAlertAction(title: Constantes.nombreDelBottonDeLaAlerta, style: .default)
        if let alertaSegura = alerta, let aceptarActionSegura = aceptarAction {
            alertaSegura.addAction(aceptarActionSegura)
        }
    }
    
    func presentarAlerta() {
        if let alertaSegura = alerta{
            present(alertaSegura, animated: true)
        }
    }
    
    func presentarVistaAgradecimiento() {
        performSegue(withIdentifier: Constantes.nombreDelSegueAgradecimiento, sender: self)
    }
    
    func limpiarCamposDeTexto() {
        nombreTextFIeld.text = ""
        sexoTextFIeld.text = ""
        tipoDeDocumentoTextField.text = ""
        numeroDeDocumentoTextFIeld.text = ""
    }
    
    func generarNumeroAleatorio() -> Int{
        return Int.random(in: 1 ... 3)
    }
    
    func aplicarProbalidadDeErroraAlActulizarContador(){
        let numeroAleatorio = generarNumeroAleatorio()
        switch (numeroAleatorio) {
        case 1 :
            presentarAlerta()
        default :
            presentarVistaAgradecimiento()
            limpiarCamposDeTexto()
        }
    }
}

