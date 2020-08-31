/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import ec.edu.espol.main.MainG3;
import ec.edu.espol.util.Conexion;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

/**
 *
 * @author TBeltran
 */
public class EgresoView implements PaneStructure{
    private BorderPane rootEgreso;
    private Label titleView;
    private Label lFarm;
    private Label lBod;
    private Label lMed;
    private Label lCant;
    private Label lFSolicitud;
    private Label lFEgreso;
    private Label lGroup;
    private TextField txtFarm;
    private TextField txtBod;
    private TextField txtMed;
    private TextField txtCant;
    private DatePicker txtFSolicitud;
    private DatePicker txtFEgreso;
    private Button bLimpiar;
    private Button bAceptar;
    private Button bVolver;
    
    public EgresoView(){
        rootEgreso = new BorderPane();
        createTopSection();
        createCenterSection();
        createBottomSection();
        instanciarIDs();
    }
    
    public BorderPane getRootEgreso() {
        return rootEgreso;
    }
    
    @Override
    public void createTopSection(){
        titleView = new Label("EGRESO DE BODEGA");
        HBox htitle = new HBox();
        htitle.getChildren().add(titleView);
        MainG3.mainStage.setTitle("EGRESO DE BODEGA");
        rootEgreso.setTop(htitle);
    }

    @Override
    public void createCenterSection() {
        VBox vcenter = new VBox();
        lFarm = new Label("Farmacia:");
        lBod =  new Label("Bodega:");
        lMed = new Label("Medicina:");
        lCant = new Label("Cantidad:");
        lFSolicitud = new Label("Fecha de Solicitud:");
        lFEgreso = new Label("Fecha de Egreso:");
        
        txtFarm = new TextField();
        txtBod = new TextField();
        txtMed = new TextField();
        txtCant = new TextField();
        txtFSolicitud = new DatePicker();
        txtFEgreso = new DatePicker();
        
        GridPane gp = new GridPane();
        gp.add(lFarm, 0, 0);
        gp.add(lBod, 0, 1);
        gp.add(lMed, 0, 2);
        gp.add(lCant, 0, 3);
        gp.add(lFSolicitud, 0, 4);
        gp.add(lFEgreso, 0, 5);
       
        gp.add(txtFarm, 1, 0);
        gp.add(txtBod, 1, 1);
        gp.add(txtMed, 1, 2);
        gp.add(txtCant, 1, 3);
        gp.add(txtFSolicitud, 1, 4);
        gp.add(txtFEgreso, 1, 5);
        
        HBox hbuttons = new HBox();
        bLimpiar = new Button("Limpiar");
        bAceptar = new Button("Aceptar");
        hbuttons.getChildren().addAll(bLimpiar, bAceptar);
        
        //String idFarm, String idBod, String idMed, String cant, LocalDate fSolicitud, LocalDate fEgreso
        bAceptar.setOnMouseClicked(e->{
            Conexion.egresoBodega(txtFarm.getText(), txtBod.getText(), txtMed.getText(), txtCant.getText(), txtFSolicitud.getValue(), txtFEgreso.getValue());
        });
        
        bLimpiar.setOnMouseClicked(e->{
            txtFarm.setText("");
            txtBod.setText("");
            txtMed.setText("");
            txtCant.setText("");
            txtFSolicitud.setValue(null);
            txtFEgreso.setValue(null);
        });
        
        vcenter.getChildren().addAll(gp, hbuttons);
        rootEgreso.setCenter(vcenter);
    }

    @Override
    public void createBottomSection() {
        HBox hbottom = new HBox();
        lGroup = new Label("Grupo 3 SBDD 2020-1T");
        bVolver = new Button("Volver");

        hbottom.getChildren().addAll(bVolver, lGroup);
        
        bVolver.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new PrincipalView().getRoot());
        });
        
        rootEgreso.setBottom(hbottom);
    }
    
    private void instanciarIDs(){
        lFarm.setId("lblForm");
        lBod.setId("lblForm");
        lMed.setId("lblForm");
        lCant.setId("lblForm");
        lFSolicitud.setId("lblForm");
        lFEgreso.setId("lblForm");
        
        bLimpiar.setId("button");
        bAceptar.setId("button");
        bVolver.setId("button");
        
        titleView.setId("lblTitle");
    }  
}
