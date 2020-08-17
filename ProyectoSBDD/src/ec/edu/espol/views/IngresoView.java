/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import ec.edu.espol.main.MainG3;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;

/**
 *
 * @author TBeltran
 */
public class IngresoView implements PaneStructure{
    private BorderPane rootIngreso;
    private Label titleView;
    private Button bVolver;
    
    public IngresoView(){
        rootIngreso = new BorderPane();
        createTopSection();
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
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
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
