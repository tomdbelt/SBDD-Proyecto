/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;

/**
 *
 * @author TBeltran
 */
public class AlertView {
    Stage stg;
    Alert alerta;
    
    public AlertView(Stage stg, AlertType at, String msg){
        this.stg = stg;
        crearEstructura(at, msg);
    }

    private void crearEstructura(AlertType at, String msg){
        alerta = new Alert(at, msg);
        alerta.getDialogPane().setPrefSize(300,200);
        alerta.initOwner(stg);
        alerta.showAndWait();
    }
}
