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
public class Main extends Application {
    static Scene mainScene;
    static PrincipalView mainView;
 
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        mainView = new PrincipalView();
        mainScene = new Scene(mainView.getRoot(), 400, 400);
        primaryStage.setScene(mainScene);
        primaryStage.setTitle("Inicio");
        primaryStage.show();
    }
    
}
