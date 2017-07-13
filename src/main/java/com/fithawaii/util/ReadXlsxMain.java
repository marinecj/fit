package com.fithawaii.util;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class ReadXlsxMain {

	public static void main(String[] args) {
		try {
			FileInputStream fis = new FileInputStream("Z:\\Tariff 040317.xlsx");
			XSSFWorkbook workbook=new XSSFWorkbook(fis);
			int sheetIndex=0;
			int rowIndex=0;
			int columnIndex=0;
			int sheets = workbook.getNumberOfSheets();
			for (sheetIndex = 0; sheetIndex < sheets; sheetIndex++) {
				XSSFSheet sheet=workbook.getSheetAt(sheetIndex);
				String sheetName = sheet.getSheetName();
				System.out.println("================================== 시트명 :"+sheetName);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				for(rowIndex=0;rowIndex<rows;rowIndex++){
					//행을읽는다
					XSSFRow row=sheet.getRow(rowIndex);
					if(row !=null){
						//셀의 수
						int cells=row.getPhysicalNumberOfCells();
						for(columnIndex=0;columnIndex<=cells;columnIndex++){
							//셀값을 읽는다
							XSSFCell cell=row.getCell(columnIndex);
							String value="";
							//셀이 빈값일경우를 위한 널체크
							if(cell==null){
								continue;
							}else{
								//타입별로 내용 읽기
								switch (cell.getCellType()){
									case XSSFCell.CELL_TYPE_FORMULA:
										value=cell.getCellFormula();
										break;
									case XSSFCell.CELL_TYPE_NUMERIC:
										value=cell.getNumericCellValue()+"";
										break;
									case XSSFCell.CELL_TYPE_STRING:
										value=cell.getStringCellValue()+"";
										break;
									case XSSFCell.CELL_TYPE_BLANK:
										//value=cell.getBooleanCellValue()+"";
										break;
									case XSSFCell.CELL_TYPE_ERROR:
										value=cell.getErrorCellValue()+"";
										break;
								}
							}
							if (!"".equals(value)) {
								System.out.println("각 셀 내용 :" + value);
							}
						}
					}
				}
			}
		} catch (FileNotFoundException fe) {
			System.out.println("FileNotFoundException >> " + fe.toString());
			fe.printStackTrace();
		} catch (IOException ie) {
			System.out.println("IOException >> " + ie.toString());
			ie.printStackTrace();
		}
	}
}
