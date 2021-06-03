import java.io.BufferedWriter;
import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.FileWriter;


public aspect Logger {
	
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();

    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
        
    pointcut makeTransaction() : call(* money*(..) );
    after() : makeTransaction() {
    	if (thisJoinPointStaticPart.getSignature().toString().contains("moneyMakeTransaction"))
    		writeFile("Depósito");
    	else if (thisJoinPointStaticPart.getSignature().toString().contains("moneyWithdrawal"))
    		writeFile("Retiro");
    	System.out.println("Transacció realizada con éxito!\n");
    }
    
    void writeFile(String type) {
    	try(FileWriter fw = new FileWriter(file, true);
    			BufferedWriter bw = new BufferedWriter(fw);
				PrintWriter out = new PrintWriter(bw)) {
    		    out.println(type + "|" + cal.getTime());
		} catch (IOException e) {
		    System.out.println("Error al escribir en " + file.getName());
		}
    }
}
