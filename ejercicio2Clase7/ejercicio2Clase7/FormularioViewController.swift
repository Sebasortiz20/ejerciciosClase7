//
//  ViewController.swift
//  ejercicio2Clase7
//
//  Created by sebas  on 19/12/22.
//

import UIKit

class FormularioViewController: UIViewController {
    
    private enum EstadoFormulario {
        case nombreValido, sexoValido, tipoDeDocumentoValido, numeroDeDocumentoValido, nombreVacio, sexoVacio, tipoDeDocumentoVacio, numeroDeDocumentoVacio
    }
    
    private struct Constantes {
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
    
    private var nombre: String?
    private var sexo: String?
    private var tipoDeDocumento: String?
    private var numeroDeDocumento: String?
    private var alerta: UIAlertController?
    private var accionAceptar: UIAlertAction?
    private var resultadosDeValidacion: [EstadoFormulario] = []
    private let resultadosInvalidos: [EstadoFormulario] = [.sexoVacio, .nombreVacio, .numeroDeDocumentoVacio, .tipoDeDocumentoVacio]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearAlerta()
    }
    
    private func crearAlerta() {
        alerta = UIAlertController(title: Constantes.tituloDeLaAlerta, message: Constantes.cuerpoDeLaAlerta , preferredStyle: .alert)
        accionAceptar = UIAlertAction(title: Constantes.nombreDelBottonDeLaAlerta, style: .default)
        if let alertaSegura = alerta, let aceptarActionSegura = accionAceptar {
            alertaSegura.addAction(aceptarActionSegura)
        }
    }
    
    @IBAction func accionEnviarDatos(_ sender: UIButton) {
        limpiarResultadosDeValidacion()
        extraerDatos()
        validarCamposDelFormulario()
        determinarColoresCamposDeFormulario()
        revisarFormulario()
    }
    
    private func limpiarResultadosDeValidacion() {
        resultadosDeValidacion = []
    }
    
    private func extraerDatos() {
        nombre = nombreTextFIeld.text ?? ""
        sexo = sexoTextFIeld.text ?? ""
        tipoDeDocumento = tipoDeDocumentoTextField.text ?? ""
        numeroDeDocumento = numeroDeDocumentoTextFIeld.text ?? ""
    }
    
    private func validarCamposDelFormulario() {
        validarCampoNombre()
        validarCampoSexo()
        validarCampoTipoDeDocumento()
        validarCampoNumeroDeDocumento()
    }
    
    private func validarCampoNombre() {
        if let nombreSeguro = nombre {
            if nombreSeguro.isEmpty {
                resultadosDeValidacion.append(.nombreVacio)
            } else {
                resultadosDeValidacion.append(.nombreValido)
            }
        }
    }
    
    private func validarCampoSexo() {
        if let sexoSeguro = sexo {
            if sexoSeguro.isEmpty {
                resultadosDeValidacion.append(.sexoVacio)
            } else {
                resultadosDeValidacion.append(.sexoValido)
            }
        }
    }
    
    private func validarCampoTipoDeDocumento() {
        if let tipoDeDocumentoSeguro = tipoDeDocumento {
            if tipoDeDocumentoSeguro.isEmpty {
                resultadosDeValidacion.append(.tipoDeDocumentoVacio)
            } else {
                resultadosDeValidacion.append(.tipoDeDocumentoValido)
            }
        }
    }
    
    private func validarCampoNumeroDeDocumento() {
        if let numeroDeDocumentoSeguro = numeroDeDocumento {
            if numeroDeDocumentoSeguro.isEmpty {
                resultadosDeValidacion.append(.numeroDeDocumentoVacio)
            } else {
                resultadosDeValidacion.append(.numeroDeDocumentoValido)
            }
        }
    }
    
    private func determinarColoresCamposDeFormulario() {
        determinarColorCampoNombre()
        determinarColorCampoSexo()
        determinarColorCampoTipoDeDocumento()
        determinarColorCampoNumeroDeDocumento()
    }
    
    private func determinarColorCampoNombre() {
        nombreTextFIeld.backgroundColor = resultadosDeValidacion.contains(.nombreValido) ? .systemBackground : .brown
    }
    
    private func determinarColorCampoSexo() {
        sexoTextFIeld.backgroundColor = resultadosDeValidacion.contains(.sexoValido) ? .systemBackground : .brown
    }
    
    private func determinarColorCampoTipoDeDocumento() {
        tipoDeDocumentoTextField.backgroundColor = resultadosDeValidacion.contains(.tipoDeDocumentoValido) ? .systemBackground : .brown
    }
    
    private func determinarColorCampoNumeroDeDocumento() {
        numeroDeDocumentoTextFIeld.backgroundColor = resultadosDeValidacion.contains(.numeroDeDocumentoValido) ? .systemBackground : .brown
    }
    
    private func revisarFormulario() {
        let formularioValido = procesarResultadosDeValidacion()
        if formularioValido {
            tratarDeMostrarAlertaDeResultado()
        }
    }
    
    private func procesarResultadosDeValidacion() -> Bool {
        var formularioEsValido = true
        for resultadoBajoAnalisis in resultadosDeValidacion {
            if resultadosInvalidos.contains(resultadoBajoAnalisis) {
                formularioEsValido = false
                break
            }
        }
        return formularioEsValido
    }
    
    private func tratarDeMostrarAlertaDeResultado(){
        let seObtuvoError = obtenerPosibleError()
        if seObtuvoError{
            presentarAlertaDeError()
        } else {
            presentarVistaAgradecimiento()
            limpiarCamposDeTexto()
        }
    }
    
    private func obtenerPosibleError() -> Bool {
        let numeroAleatorio = generarNumeroAleatorio()
        return numeroAleatorio == 1
    }
    
    private func generarNumeroAleatorio() -> Int{
        return Int.random(in: 1 ... 3)
    }
    
    private func presentarAlertaDeError() {
        if let alertaSegura = alerta{
            present(alertaSegura, animated: true)
        }
    }
    
    private func presentarVistaAgradecimiento() {
        performSegue(withIdentifier: Constantes.nombreDelSegueAgradecimiento, sender: self)
    }
    
    private func limpiarCamposDeTexto() {
        nombreTextFIeld.text = ""
        sexoTextFIeld.text = ""
        tipoDeDocumentoTextField.text = ""
        numeroDeDocumentoTextFIeld.text = ""
    }
}

