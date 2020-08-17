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
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;

/**
 *
 * @author TBeltran
 */
public class PrincipalView implements PaneStructure{
    private BorderPane root;
    private Button bIngreso;
    private Button bEgreso;
    private Label titleView;

    public PrincipalView() {
        root = new BorderPane();
        createTopSection();
        createCenterSection();
    }

    public BorderPane getRoot() {
        return root;
    }
    
    @Override
    public void createTopSection() {
        titleView = new Label("PROYECTO FINAL SBDD G3");
        MainG3.mainStage.setTitle("PROYECTO FINAL SBDD G3");
        root.setTop(titleView);
    }
    
    @Override
    public void createCenterSection(){
        bIngreso = new Button("Ingreso de Bodega");
        bEgreso = new Button("Egreso de Bodega");
        VBox vButtons = new VBox();
        vButtons.getChildren().addAll(bIngreso, bEgreso);
        root.setCenter(vButtons);
        
        bIngreso.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new IngresoView().getRootIngreso());
        });
        
        bEgreso.setOnMouseClicked(e->{
            MainG3.mainScene.setRoot(new EgresoView().getRootEgreso());
        });
    }

    @Override
    public void createBottomSection() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
