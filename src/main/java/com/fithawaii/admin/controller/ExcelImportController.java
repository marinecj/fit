package com.fithawaii.admin.controller;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.fithawaii.util.AlertForward;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/excelimport")
public class ExcelImportController {

	/**
	 * 엑셀 임포트 메인 페이지
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String main(HttpServletRequest request, Model model) {
		return "/admin/excelimport";
	}

	/*
	 * 엑셀파일 업로드 처리
	 */
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	public String fileUpload(HttpServletRequest request, 
		@RequestParam("file") MultipartFile file,
		Model model) {

		StringBuilder sb = uploadExcel(file);

		// return AlertForward.alertAndGoPage(result ? "Success \n Values => " + sb.toString() : "Fail", "/excelimport", model);

		//model.addAttribute("result", result);
		model.addAttribute("excelValue", sb.toString());

		return "/admin/excelimport";
	}

	private static StringBuilder uploadExcel(MultipartFile file) {

		/*
		List<ExcelResult> list = new ArrayList<ExcelResult>();
		XSSFWorkbook workbook = null;
		try {
			workbook = excelImportBO.readToWorkbook(file.getInputStream());
			String[] xlsConfigs = xlsConfig.split("@@");
			for (String config : xlsConfigs) {
				ExcelConfig excelConfig = excelConfigFactory.parseConfig(config);
				ExcelResult ret = excelImportBO.parseExcel(workbook, excelConfig);
				int insertCnt = excelImportBO.insertToDB(excelConfig.getDbId(), excelConfig.getTableName(), ret);
				ret.setInsertCount(insertCnt);
				list.add(ret);
			}
			model.addAttribute("result", true);
			model.addAttribute("list", list);
		} catch (Exception e) {
			logger.error("{}", e);
		} finally {
			excelImportBO.closeWorkbook(workbook);
		}
		*/

		boolean result = false;
		StringBuilder sb = new StringBuilder();

		try {
			//FileInputStream fis = new FileInputStream("Z:\\Tariff 040317.xlsx");
			XSSFWorkbook workbook=null;
			if (file != null) {
				workbook = new XSSFWorkbook(file.getInputStream());
			} else {
				workbook = new XSSFWorkbook("Z:\\Tariff 040317.xlsx");
			}
			int sheetIndex=0;
			int rowIndex=0;
			int columnIndex=0;
			int sheets = workbook.getNumberOfSheets();
			for (sheetIndex = 0; sheetIndex < sheets; sheetIndex++) {
				XSSFSheet sheet=workbook.getSheetAt(sheetIndex);
				String sheetName = sheet.getSheetName();
				System.out.println("================================== 시트명 :"+sheetName);
				sb.append("<br><br><p>sheetName : " + sheetName + "</p>");
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
								sb.append("<br>rowIndex : " + rowIndex + ", columnIndex : " + columnIndex + ", value : " + value);
							}
						}
					}
				}
			}
			if (workbook != null) {
				workbook.close();
			}
			result = true;
		} catch (FileNotFoundException fe) {
			System.out.println("FileNotFoundException >> " + fe.toString());
			fe.printStackTrace();
		} catch (IOException ie) {
			System.out.println("IOException >> " + ie.toString());
			ie.printStackTrace();
		}

		return sb;
	}

	/*public static void main(String[] args) throws Exception {
		MultipartFile file = null;
		StringBuilder sb = uploadExcel(file);
	}*/
}
