/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import ec.edu.espol.main.MainG3;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

/**
 *
 * @author TBeltran
 */
public class IngresoView implements PaneStructure{
    private BorderPane rootIngreso;
    private Label titleView;
    private Label lBod;
    private Label lMed;
    private Label lCant;
    private Label lJust;
    private Label lFSolicitud;
    private Label lFIngreso;
    private TextField txtBod;
    private TextField txtMed;
    private TextField txtCant;
    private TextArea txtJust;
    private DatePicker txtFSolicitud;
    private DatePicker txtFIngreso;
    private Button bLimpiar;
    private Button bAceptar;
    private Button bVolver;
    
    public IngresoView(){
        rootIngreso = new BorderPane();
        createTopSection();
        createCenterSection();
        createBottomSection();
    }
    
    public BorderPane getRootIngreso() {
        return rootIngreso;
    }
    
    @Override
    public void createTopSection(){
        titleView = new Label("INGRESO DE BODEGA");
        MainG3.mainStage.setTitle("INGRESO DE BODEGA");
        rootIngreso.setTop(titleView);
    }

    @Override
    public void createCenterSection() {
        VBox vcenter = new VBox();
        lBod =  new Label("Bodega:");
        lMed = new Label("Medicina:");
        lCant = new Label("Cantidad:");
        lJust = new Label("Justificación:");
        lFSolicitud = new Label("Fecha de Solicitud:");
        lFIngreso = new Label("Fecha de Ingreso:");
  
        txtBod = new TextField();
        txtMed = new TextField();
        txtCant = new TextField();
        txtJust = new TextArea();
        txtFSolicitud = new DatePicker();
        txtFIngreso = new DatePicker();
        
        GridPane gp = new GridPane();
        gp.add(lBod, 0, 0);
        gp.add(lMed, 0, 1);
        gp.add(lCant, 0, 2);
        gp.add(lJust, 0, 3);
        gp.add(lFSolicitud, 0, 4);
        gp.add(lFIngreso, 0, 5);
       
        gp.add(txtBod, 1, 0);
        gp.add(txtMed, 1, 1);
        gp.add(txtCant, 1, 2);
        gp.add(txtJust, 1, 3);
        gp.add(txtFSolicitud, 1, 4);
        gp.add(txtFIngreso, 1, 5);
        
        HBox hbuttons = new HBox();
        bLimpiar = new Button("Limpiar");
        bAceptar = new Button("Aceptar");
        hbuttons.getChildren().addAll(bLimpiar, bAceptar);
        
        vcenter.getChildren().addAll(gp, hbuttons);
        rootIngreso.setCenter(vcenter);
    }

    @Override
    public void createBottomSection() {
        bVolver = new Button("Volver");
        rootIngreso.setBottom(bVolver);
        
        bVolver.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new PrincipalView().getRoot());
        });
    }
}
