package com.Storage;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.Random;

public class MyTable implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4054049728149338294L;
	private LinkedList<MyColumn<?>> columns;
	private int rowCount;
	
	public MyTable(int r)
	{
		rowCount = r;
	}
	
	public MyColumn<?> AddColumn(MyColumn.DataType dt)
	{
		MyColumn<?> col = ColumnFactory.CreateColumn(dt, rowCount);
		
		columns.add(col);
		
		return col;
	}
	
	public static void main(String args[]){
		MyTable mt = new MyTable(10);
		
		Random rdm = new Random();
		MyColumn.DataType dt[] = {MyColumn.DataType.INTEGER, MyColumn.DataType.DOUBLE, MyColumn.DataType.INTEGER};
		
		for (int i = 0; i < 3; i++)
		{
			@SuppressWarnings("unchecked")
			MyColumn<Integer> col = (MyColumn<Integer>)mt.AddColumn(dt[i]);
			
			for(int j = 0; j < 10; j++)
			{
				col.SetData(j, rdm.nextInt());
			}
		}
	}
}
