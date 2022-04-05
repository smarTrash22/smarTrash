package com.st.smartrash.common;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class CreateCSV {
	public void writeCSV(String csvPath, String testPath, String filePath){
        try (PrintWriter writer = new PrintWriter(new File(csvPath))) {
            StringBuilder sb = new StringBuilder();
			sb.append("testPath");
			sb.append(',');
			sb.append("filePath");
			sb.append('\n');
			
			sb.append(testPath);
			sb.append(',');
			sb.append(filePath);
			sb.append('\n');

            writer.write(sb.toString());
            writer.close();

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
        }
        CreateCSV testCSV =  new CreateCSV();
    }

    public void readCSV(String csvPath){
        List<List<String>> records = new ArrayList<>();
        try (Scanner scanner = new Scanner(new File(csvPath))) {
            while (scanner.hasNextLine()) {
                records.add(getRecordFromLine(scanner.nextLine()));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        System.out.println(records.toString());
    }
    
    private List<String> getRecordFromLine(String line) {
        List<String> values = new ArrayList<String>();
        try (Scanner rowScanner = new Scanner(line)) {
            rowScanner.useDelimiter(",");
            while (rowScanner.hasNext()) {
                values.add(rowScanner.next());
            }
        }
        return values;
    }
}
