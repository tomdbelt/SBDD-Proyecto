/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.views;

import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;

/**
 *
 * @author TBeltran
 */
public class PrincipalView {
    private BorderPane root;

    public PrincipalView() {
        root = new BorderPane();
    }

    public BorderPane getRoot() {
        return root;
    }
}
