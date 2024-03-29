package com.st.smartrash;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.category.model.service.CategoryService;
import com.st.smartrash.category.model.vo.Category;
import com.st.smartrash.common.CategoryTranslation;
import com.st.smartrash.common.CompressZip;
import com.st.smartrash.common.CreateCSV;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.vo.User;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private TrashService trashService;
	
	@Inject
	private CategoryService categoryService;
	
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainViewForward(Model model) {
		ArrayList<Trash> trash_list = trashService.selectTrashNewTop();
		ArrayList<Trash> category_list = trashService.selectTrashNewTop();
		model.addAttribute("trash_list", trash_list);
		model.addAttribute("category_list", category_list);
		return "common/main";
	}
	
	@RequestMapping(value = "uploadFile.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile(HttpServletRequest request, Model model,
	    @RequestParam("uploadfile") MultipartFile uploadfile) {
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		JSONObject job = new JSONObject();
		
		try {
			String savePath = request.getSession().getServletContext().getRealPath("resources/trash_upfiles");
			String fileName = uploadfile.getOriginalFilename();
			
			// 이름바꾸기 처리 : 년월일시분초.확장자
			if(fileName != null && fileName.length() > 0) {
				// 바꿀 파일명에 대한 문자열 만들기
				// 공지글 등록 요청시점의 날짜정보를 이용함
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				
				// 변경할 파일이름 만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "-";
				Random random = new Random();
				
				for (int i=0; i<5; i++) {
					renameFileName += Integer.toString(random.nextInt(9));
				}
				
				// 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				job.put("file", renameFileName);
				
				// 파일 객체 만들기
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				// 업로드 파일 저장시키고, 바로 이름바꾸기 실행함
				uploadfile.transferTo(renameFile);
				fileName = renameFileName;
			}
			
			String testPath = request.getSession().getServletContext().getRealPath("resources/python/");
			String filePath = request.getSession().getServletContext().getRealPath("resources/trash_upfiles/") + fileName;
			String csvPath = request.getSession().getServletContext().getRealPath("resources/python/csv/") + "test.csv";
	        
			CreateCSV cc = new CreateCSV();
			cc.writeCSV(csvPath, testPath, filePath);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "전송파일 저장 실패");
			return "common/error";
		}
		
		// 파이썬 출력문
		try {
			String command = request.getSession().getServletContext().getRealPath("resources/python/venv/Scripts/") + "python.exe";
			String arg1 = request.getSession().getServletContext().getRealPath("resources/python/") + "test.py";
			
			ProcessBuilder builder = new ProcessBuilder(command, arg1);
			Process process;
			
			builder.redirectErrorStream(true);  // 표준 에러도 표준 출력에 쓴다
			process = builder.start();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream(), "utf-8"));
			
			int exitVal = process.waitFor();  // 자식 프로세스가 종료될 때까지 기다림
			String line;
			while ((line = br.readLine()) != null) {  // 출력문이 여러줄일때 사용
				job.put("category", line);  // 출력문 받아서 저장
			}
			if(exitVal != 0) {
				// 비정상 종료
				System.out.println("서브 프로세스가 비정상 종료되었다.");
			}
			
			// 배치파일로 파이썬 출력받기
//			String cmd = request.getSession().getServletContext().getRealPath("resources/python/") + "test.bat";
//			
//		    Process p = Runtime.getRuntime().exec(cmd);
//			
//		    inheritIO(p.getInputStream(), System.out);
//		    inheritIO(p.getErrorStream(), System.err);
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") != null) {
			User user = (User)session.getAttribute("loginUser");
			Category category = categoryService.selectSearchName((String)job.get("category"));
			System.out.println(user.getUser_no());
			Trash trash = new Trash();
			trash.setUser_no(user.getUser_no());
			trash.setCategory_no(category.getCategory_no());
			trash.setTrash_path((String)job.get("file"));
			
			trashService.trashInsert(trash);
			System.out.println(trash.toString());
		}
		
		jarr.add(job);
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}
	
	@RequestMapping(value="dataPush.do")
	public ModelAndView dataPush(@RequestParam(name="file") String file, @RequestParam(name="category") String category_name, HttpServletRequest request, ModelAndView mv) {
		Category category = categoryService.selectSearchName(category_name);
		CategoryTranslation ct = new CategoryTranslation();
		category.setCategory_name_kor(ct.categoryTranslation(category.getCategory_name()));
		
		ArrayList<Category> category_list = categoryService.selectList();
		for(Category c : category_list) {
			System.out.println(c.toString());
		}
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") != null) {
			// 로그인 했을 경우 : 회원
			User user = (User)session.getAttribute("loginUser");
			System.out.println(user.getUser_no());
			Trash trash = new Trash();
			trash.setUser_no(user.getUser_no());
			trash.setCategory_no(category.getCategory_no());
			trash.setTrash_path(file);
			
			mv.addObject("trash_path", file);
			mv.addObject("category", category);
			mv.addObject("category_list", category_list);
			mv.setViewName("trash/trashDesc");
			return mv;
		} else {
			// 로그인 안했을 경우 : 비회원
			mv.addObject("trash_path", file);
			mv.addObject("category", category);
			mv.setViewName("trash/trashDesc");
			return mv;
		}
	}
	
	// 배치파일로 파이썬 출력받기 쓰레드
//	private static void inheritIO(final InputStream src, final PrintStream dest) {
//	    new Thread(new Runnable() {
//	        public void run() {
//	            Scanner sc = new Scanner(src);
//	            while (sc.hasNextLine()) {
//	                dest.println(sc.nextLine());
//	            }
//	        }
//	    }).start();
//	}
	
	@RequestMapping(value="zipSet.do")
	public ModelAndView zipdown(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			User user = (User)session.getAttribute("loginUser");
			System.out.println(user.toString());
			if(user.getUser_admin().equals("Y")) {
				ArrayList<Trash> trash_list = trashService.selectSearchReport("Y");
				if(trash_list.size() != 0) {
					String path = request.getSession().getServletContext().getRealPath("resources/");
					
					for(Trash t : trash_list) {
						String srcFile = path + "trash_upfiles\\" + t.getTrash_path();
						String dstFile = path + "report_images\\" + t.getTrash_path();
						
						// 신고 쓰레기 제거
						trashService.deleteTrash(t.getTrash_no());
						
						File src = new File(srcFile);
						File dst = new File(dstFile);
						      
						try {
						   FileUtils.moveFile(src, dst);
						}
						catch (Exception e) {
						   e.printStackTrace();
						}
					}
					
					// 압축 파일 위치와 압축된 파일
					String zipPath = path + "report_images\\";
					String zipFile = "report_images.zip";
			
					// 압축을 해제할 위치, 압축할 파일이름
			//		String unZipPath = "G:/ZIP_TEST/TEST/";
			//		String unZipFile = "jsmpeg-player";
			
			//		System.out.println("--------- 압축 해제 ---------");
			//		UnZip unZip = new UnZip();
			//		// 압축 해제 
			//		if (!unZip.unZip(zipPath, zipFile, unZipPath)) {
			//			System.out.println("압축 해제 실패");
			//		}
					
					System.out.println("--------- 압축 하기 ---------");
					CompressZip compressZip = new CompressZip();
					
					// 압축 하기
					try {
						if (!compressZip.compress(zipPath, path, zipFile)) {
							System.out.println("압축 실패");
						}
					} catch (Throwable e) {
						e.printStackTrace();
					}
				
					// 신고사진 삭제
					try {
					    File rootDir = new File(path + "report_images\\");
					    FileUtils.deleteDirectory(rootDir);
					} catch (IOException e) {
					    e.printStackTrace();
					}
				}
				mv.addObject("count", trash_list.size());
				mv.setViewName("user/zipDownload");
				return mv;
			} else {
				mv.setViewName("user/login");
				return mv;
			}
		} else {
			mv.setViewName("user/login");
			return mv;
		}
	}
	
	//첨부파일 다운로드
	@RequestMapping("zipDown.do")
	public ModelAndView fileDownMethod(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			User user = (User)session.getAttribute("loginUser");
			if(user.getUser_admin().equals("Y")) {
				String path = request.getSession().getServletContext().getRealPath("resources/");
				File renameFile = new File(path + "report_images.zip");
				File originFile = new File("report_images.zip");
		
		
				mv.setViewName("filedown");
				mv.addObject("renameFile", renameFile);
				mv.addObject("originFile", originFile);
				
				return mv;
			} else {
				mv.setViewName("user/login");
				return mv;
			}
		} else {
			mv.setViewName("user/login");
			return mv;
		}
	}
}
