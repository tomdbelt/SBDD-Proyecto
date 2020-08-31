/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import ec.edu.espol.main.MainG3;
import ec.edu.espol.util.Conexion;
import java.time.LocalDate;
import javafx.geometry.Pos;
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
    private Label lGroup;
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
        instanciarIDs();
    }
    
    public BorderPane getRootIngreso() {
        return rootIngreso;
    }
    
    @Override
    public void createTopSection(){
        titleView = new Label("INGRESO DE BODEGA");
        HBox htitle = new HBox();
        htitle.getChildren().add(titleView);
        MainG3.mainStage.setTitle("INGRESO DE BODEGA");
        rootIngreso.setTop(htitle);
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
        txtJust.setWrapText(true);
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
        
        bAceptar.setOnMouseClicked(e->{
            Conexion.ingresoBodega(txtBod.getText(), txtMed.getText(), txtCant.getText(), txtJust.getText(), txtFSolicitud.getValue(), txtFIngreso.getValue());
        });
        
        //String idBod, String idMed, String cant, String just, LocalDate fSolicitud, LocalDate fIngreso
        bLimpiar.setOnMouseClicked(e->{
            txtBod.setText("");
            txtMed.setText("");
            txtCant.setText("");
            txtJust.setText("");
            txtFSolicitud.setValue(null);
            txtFIngreso.setValue(null);
        });
        
        vcenter.getChildren().addAll(gp, hbuttons);
        rootIngreso.setCenter(vcenter);
    }

    @Override
    public void createBottomSection() {
        HBox hbottom = new HBox();
        lGroup = new Label("Grupo 3 SBDD 2020-1T");
        lGroup.setAlignment(Pos.CENTER_RIGHT);
        bVolver = new Button("Volver");
        
        hbottom.getChildren().addAll(bVolver, lGroup);
        
        bVolver.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new PrincipalView().getRoot());
        });
        
        rootIngreso.setBottom(hbottom);
    }
    
    private void instanciarIDs(){
        lBod.setId("lblForm");
        lMed.setId("lblForm");
        lCant.setId("lblForm");
        lJust.setId("lblForm");
        lFSolicitud.setId("lblForm");
        lFIngreso.setId("lblForm");
        txtJust.setId("txtJust");

        bLimpiar.setId("button");
        bAceptar.setId("button");
        bVolver.setId("button");
        
        titleView.setId("lblTitle");
    }
}
