/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import ec.edu.espol.constants.CONSTANTES;
import ec.edu.espol.main.MainG3;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
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
    private ImageView iconSystem;

    public PrincipalView() {
        root = new BorderPane();
        createTopSection();
        createCenterSection();
        instanciarIDs();
    }

    public BorderPane getRoot() {
        return root;
    }
    
    @Override
    public void createTopSection() {
        titleView = new Label("PROYECTO FINAL SBDD G3");
        HBox htitle = new HBox();
        htitle.getChildren().add(titleView);
        MainG3.mainStage.setTitle("PROYECTO FINAL SBDD G3");
        root.setTop(htitle);
    }
    
    @Override
    public void createCenterSection(){
        iconSystem = new ImageView(new Image(CONSTANTES.RUTAICON, 275, 275, true, true));
        
        bIngreso = new Button("Ingreso de Bodega");
        bEgreso = new Button("Egreso de Bodega");
        VBox vCenter = new VBox();
        vCenter.getChildren().addAll(iconSystem, bIngreso, bEgreso);
        root.setCenter(vCenter);
        
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
    
    private void instanciarIDs(){
        bIngreso.setId("button");
        bEgreso.setId("button");
        titleView.setId("lblTitle");
    }
}
