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
public class EgresoView implements PaneStructure{
    private BorderPane rootEgreso;
    private Label titleView;
    private Button bVolver;
    
    public EgresoView(){
        rootEgreso = new BorderPane();
        createTopSection();
        createBottomSection();
    }
    
    public BorderPane getRootEgreso() {
        return rootEgreso;
    }
    
    @Override
    public void createTopSection(){
        titleView = new Label("EGRESO DE BODEGA");
        MainG3.mainStage.setTitle("EGRESO DE BODEGA");
        rootEgreso.setTop(titleView);
    }

    @Override
    public void createCenterSection() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void createBottomSection() {
        bVolver = new Button("Volver");
        rootEgreso.setBottom(bVolver);
        
        bVolver.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new PrincipalView().getRoot());
        });
    }
    
    
}
