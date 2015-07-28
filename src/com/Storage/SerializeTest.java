package com.Storage;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Random;

public class SerializeTest implements Serializable {

//private String name = "this is a test object";
//private int value = 10;
//private int num = 100;
private SingleColumn columns[];

	public SerializeTest(String str, int val)
	{
		//name = str;
		//value = val;
		
		columns = new SingleColumn[3];
		
		Random random = new Random();
		for (int i = 0; i < 3; i++)
		{
			int r = (i+1)*2;
			double values[] = new double[r];
			
			for (int j = 0; j < r; j++)
			{
				values[j] = random.nextDouble()*10;
			}
			columns[i] = new SingleColumn(r, values);
		}
	}
	
	public void Print()
	{
	
		for (SingleColumn c: columns)
		{
			c.Print();
		}
	}
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;

	public static void main(String[] args) throws ClassNotFoundException {
		// TODO Auto-generated method stub
		
		try {
			
			
			ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File("o.ser")));
			
			SerializeTest instance = (SerializeTest) ois.readObject();
			
			instance.Print();
			ois.close();
//			SerializeTest instance = new SerializeTest("test again again", 1024);
//			ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(new File("o2.ser")));
//			
//			oos.writeObject(instance);
//			oos.close();
			
			
			System.out.println("finished");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
