package com.fithawaii.admin.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelCategoryInfo;
import com.fithawaii.model.HotelInfo;
import com.fithawaii.model.HotelRoomInfo;
import java.io.FileNotFoundException;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;
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

		uploadExcel(file);

		// return AlertForward.alertAndGoPage(result ? "Success \n Values => " + sb.toString() : "Fail", "/excelimport", model);

		//model.addAttribute("result", result);
		//model.addAttribute("excelValue", sb.toString());

		return "/admin/excelimport";
	}

	private static void uploadExcel(MultipartFile file) {

		boolean result = false;
		List<HotelAllInfo> hotelAllInfoList = new ArrayList<HotelAllInfo>();
		List<HotelInfo> hotelInfoList = new ArrayList<HotelInfo>();
		List<HotelCategoryInfo> hotelCategoryInfoList = new ArrayList<HotelCategoryInfo>();
		List<HotelRoomInfo> hotelRoomInfoList = new ArrayList<HotelRoomInfo>();

		try {
			//FileInputStream fis = new FileInputStream("Z:\\Tariff 040317.xlsx");
			XSSFWorkbook workbook=null;
			if (file != null) {
				workbook = new XSSFWorkbook(file.getInputStream());
			} else {
				workbook = new XSSFWorkbook("Z:\\private\\ab\\fit\\hotel_data\\2017 FIT HAWAII Hotel Tariff 022017.xlsx");
			}

			// 호텔 번호
			int hotelNo = 0;
			// 카테고리 번호
			int cateNo = 0;
			// 룸타입 번호
			int typeNo = 0;

			int sheetIndex=0;
			int rowIndex=0;
			int columnIndex=0;
			int sheets = workbook.getNumberOfSheets();
			for (sheetIndex = 0; sheetIndex < sheets; sheetIndex++) {
				XSSFSheet sheet=workbook.getSheetAt(sheetIndex);
				String sheetName = sheet.getSheetName();
				//System.out.println("================================== sheetName :"+sheetName);

				// 호텔정보
				HotelAllInfo hotelAllInfo = null;
				HotelInfo hotelInfo = null;
				HotelCategoryInfo hotelCategoryInfo = null;
				HotelRoomInfo hotelRoomInfo = null;

				// 필요한 컨텐츠 내용이 시작되는 행 번호
				int contentsRowNum = -1;
				int cateRowNum = -1;
				int breakfastColumnNum = -1;

				// 지역명 셋팅
				String state = sheetName;
				int idx = sheetName.indexOf("(");
				if (idx >= 0) {
					state = sheetName.substring(0, idx);
					//System.out.println("### state :"+state);
				}

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
								//System.out.println("rowIndex : " + rowIndex + ", columnIndex : " + columnIndex + ", value : " + value);

								if (contentsRowNum < 0 && "HOTEL".equals(value)) {
									contentsRowNum = rowIndex + 1;
									continue;
								} else if (breakfastColumnNum < 0 && "BREAKFAST".equals(value)) {
									breakfastColumnNum = columnIndex;
									break;
								} else if (contentsRowNum > 0 && contentsRowNum <= rowIndex) {

									if (columnIndex == 0) {
										// 호텔명 셋팅
										String hotelNm = value;
										if (cateRowNum == -1 || cateRowNum < rowIndex - 1) {
											// 호텔명 한글
											if (value.indexOf("포터레이지") >= 0) {
												hotelNm = value.substring(0, value.indexOf("포터레이지")).trim();
											} else if (value.indexOf("PH") >= 0) {
												hotelNm = value.substring(0, value.indexOf("PH")).trim();
											} else if (value.indexOf("(") >= 0) {
												hotelNm = value.substring(0, value.indexOf("(")).trim();
											}
											//System.out.println("###### hotelNm :" + hotelNm);

											// 호텔 데이터 row 시작 => 리셋
											hotelInfo = new HotelInfo();

											hotelNo++;
											hotelInfo.setHotelNmKr(hotelNm);
											hotelInfo.setHotelNo(hotelNo);
											hotelInfo.setState(state);
										} else {
											// 호텔명 영문
											hotelInfo.setHotelNm(hotelNm);

											// 호텔 정보 리스트에 저장
											hotelInfoList.add(hotelInfo);
										}
									} else if (columnIndex == 1) {
										// 카테고리
										if (value.indexOf("<") >= 0) {
											hotelCategoryInfo = new HotelCategoryInfo();

											cateNo++;
											hotelCategoryInfo.setHotelNo(hotelNo);
											hotelCategoryInfo.setCateNo(cateNo);
											hotelCategoryInfo.setCateNm(value);

											cateRowNum = rowIndex;

											// 카테고리 정보 리스트에 저장
											hotelCategoryInfoList.add(hotelCategoryInfo);
										} else if (rowIndex > cateRowNum){
											hotelRoomInfo = new HotelRoomInfo();

											typeNo++;
											hotelRoomInfo.setHotelNo(hotelNo);
											hotelRoomInfo.setCateNo(cateNo);
											hotelRoomInfo.setTypeNo(typeNo);
											hotelRoomInfo.setTypeNm(value);
										}
									} else if (columnIndex == 2 && rowIndex > cateRowNum) {
										// JTB CODE
										hotelRoomInfo.setAgencyCd(value);
									} else  if (columnIndex >= 3) {
										if (breakfastColumnNum > columnIndex) {
											// DURATION
											switch (columnIndex) {
												case 3:
													if (cateRowNum == rowIndex) {
														hotelCategoryInfo.setDuration1(value);
													} else {
														hotelRoomInfo.setPrice1(Double.parseDouble(value));
													}
													break;
												case 4:
													if (cateRowNum == rowIndex) {
														hotelCategoryInfo.setDuration2(value);
													} else {
														hotelRoomInfo.setPrice2(Double.parseDouble(value));
													}
													break;
												case 5:
													if (cateRowNum == rowIndex) {
														hotelCategoryInfo.setDuration3(value);
													} else {
														hotelRoomInfo.setPrice3(Double.parseDouble(value));
													}
													break;
												case 6:
													if (cateRowNum == rowIndex) {
														hotelCategoryInfo.setDuration4(value);
													} else {
														hotelRoomInfo.setPrice4(Double.parseDouble(value));
													}
													break;
												default:
													break;
											}
										} else if (breakfastColumnNum == columnIndex && rowIndex > cateRowNum) {
											// BREAKFAST
											hotelRoomInfo.setBreakfastYn("O".equals(value) ? "Y" : "N");

											// 룸타입 정보 리스트에 저장
											hotelRoomInfoList.add(hotelRoomInfo);
										} else if (breakfastColumnNum + 1 == columnIndex && rowIndex	 > cateRowNum) {
											// REMARK
											HotelCategoryInfo tempCate = hotelCategoryInfoList.get(hotelCategoryInfoList.size() - 1);
											tempCate.setRemark(value);
										} else if (breakfastColumnNum + 2 == columnIndex && rowIndex > cateRowNum) {
											// CXL POLICY
											HotelCategoryInfo tempCate = hotelCategoryInfoList.get(hotelCategoryInfoList.size() - 1);
											tempCate.setCancelPolicy(value);
										}
									}
								}
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

		for (HotelInfo hotelInfo : hotelInfoList) {
			System.out.println("hotelNo : " + hotelInfo.getHotelNo() + ", hotelNm : " + hotelInfo.getHotelNm() + ", hotelNmKr : " + hotelInfo.getHotelNmKr());
		}
		System.out.println("==================================");
		for (HotelCategoryInfo hotelCategoryInfo : hotelCategoryInfoList) {
			System.out.println("hotelNo : " + hotelCategoryInfo.getHotelNo() + ", cateNo : " + hotelCategoryInfo.getCateNo() + ", cateNm : " + hotelCategoryInfo.getCateNm());
		}
		System.out.println("==================================");
		for (HotelRoomInfo hotelRoomInfo : hotelRoomInfoList) {
			System.out.println("hotelNo : " + hotelRoomInfo.getHotelNo() + ", cateNo : " + hotelRoomInfo.getCateNo() + ", typeNo : " + hotelRoomInfo.getTypeNo() + ", typeNm : " + hotelRoomInfo.getTypeNm()
					+ ", AgencyCd : " + hotelRoomInfo.getAgencyCd() + ", Price1 : " + hotelRoomInfo.getPrice1() + ", Price2 : " + hotelRoomInfo.getPrice2() + ", Price3 : " + hotelRoomInfo.getPrice3() + ", Price4 : " + hotelRoomInfo.getPrice4());
		}

		/** DB 작업 */
		new FitBO().insertAllDataFromExcel(hotelInfoList, hotelCategoryInfoList, hotelRoomInfoList);
	}
}
