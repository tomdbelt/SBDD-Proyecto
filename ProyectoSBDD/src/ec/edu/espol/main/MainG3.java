/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.main;

import ec.edu.espol.views.PrincipalView;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 *
 * @author TBeltran
 */
public class MainG3 extends Application {
    public static Scene mainScene;
    public static Stage mainStage;
    public static PrincipalView mainView;
 
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        mainStage = primaryStage;
        mainView = new PrincipalView();
        mainScene = new Scene(mainView.getRoot(), 500, 500);      
        mainStage.setScene(mainScene);
        mainStage.show();
    }
    
}
