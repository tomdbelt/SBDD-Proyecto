/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.espol.util;

import java.sql.*;
import java.time.LocalDate;

/**
 *
 * @author TBeltran
 */
public class Conexion {
    public static Connection cn;
    
    public static Connection getConexion(){
        try{
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/g3p1", "root", "root");
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return cn;
    }
    
    public static void ingresoBodega(String idBod, String idMed, String cant, String just, LocalDate fSolicitud, LocalDate fIngreso){
        try{ //ingreso de med
            Connection x = getConexion();
            PreparedStatement pst = x.prepareStatement("call verificarIngreso(?,?,?,?,?,?)");
            pst.setString(1, idBod);
            pst.setString(2, idMed);
            pst.setInt(3, Integer.parseInt(cant));
            pst.setString(4, just);
            Date dsol = new Date(fSolicitud.getYear()-1900,fSolicitud.getMonth().getValue()-1,fSolicitud.getDayOfMonth());
            pst.setDate(5, dsol);
            Date ding = new Date(fIngreso.getYear()-1900,fIngreso.getMonth().getValue()-1,fIngreso.getDayOfMonth());
            pst.setDate(6, ding);          
            pst.executeUpdate();
        }catch (Exception e){
            System.out.println("error");
            System.out.println(e.getMessage());
            
        }
    }
    
    public static void egresoBodega(String idFarm, String idBod, String idMed, String cant, LocalDate fSolicitud, LocalDate fEgreso){
        try{
            Connection x = getConexion();
            PreparedStatement pst = x.prepareStatement("call verificarEgreso(?,?,?,?,?,?)");
            pst.setString(1, idFarm);
            pst.setString(2, idBod);
            pst.setString(3, idMed);
            pst.setInt(4, Integer.parseInt(cant));
            Date dsoli = new Date(fSolicitud.getYear()-1900,fSolicitud.getMonth().getValue()-1,fSolicitud.getDayOfMonth());
            pst.setDate(5, dsoli);       
            Date degre = new Date(fEgreso.getYear()-1900,fEgreso.getMonth().getValue()-1,fEgreso.getDayOfMonth());
            pst.setDate(6, degre);
            pst.executeUpdate();
        }catch (Exception e){
            
            System.out.println(e.getMessage());
        }
    }
}
