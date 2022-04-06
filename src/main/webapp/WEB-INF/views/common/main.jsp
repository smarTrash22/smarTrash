<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Page Title -->
<c:set var="page_title" value="Main" />

<!DOCTYPE html>
<html>
	<head>
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style type="text/css">
			#drop-zone {
			    outline: 10px dashed #fff ;
			    outline-offset:-10px;  
			    text-align: center;
			    width: 50%;
			    height: 300px;
			    -webkit-text-stroke-width: 0.5px;
			    -webkit-text-stroke-color: black;
			}
			#drop-zone.hover {
				border: 10px dashed #333;
			}
		</style>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
		$(function() {
			$image = document.getElementById("upload-file-input")
			dropZone = document.querySelector("#drop-zone")
			
			$(dropZone)
				.on("dragover", dragOver)
				.on("dragleave", dragOver)
				.on("click", ajaxFileSelect);
			
			function dragOver(e) {
			    e.stopPropagation();
			    e.preventDefault();
			    if (e.type == "dragover") {
			        $(e.target).css({
			            "transform": "scale(0.9)",
			            "transition": "transform .25s"
			        });
			    } else {
			        $(e.target).css({
			            "transform": "scale(1.0)",
			            "transition": "transform .25s"
			        });
			    }
			}
			
			/* var showFiles = function (files) {
				dropZone.innerHTML = ""
				for (var i = 0, len = files.length; i < len; i++) {
					dropZone.innerHTML += "<p>" + files[i].name + "</p>"
				}
			} */
			
			var selectFile = function (files) {
				// input file 영역에 드랍된 파일들로 대체
				$image.files = files
				/* showFiles($image.files) */
				
			}
			
			/* $image.addEventListener("change", function (e) {
				showFiles(e.target.files)
			}) */
			
			// 드래그한 파일이 드랍되었을 때
			dropZone.addEventListener("drop", function (e) {
				e.preventDefault()
		        $(e.target).css({
		            "transform": "scale(1.0)",
		            "transition": "transform .25s"
		        });
				var files = e.dataTransfer && e.dataTransfer.files
				console.log(files)
				if (files != null) {
					if(files[0].type.match(/image.*/)) {
						
						$(dropZone).html("업로드한 쓰레기사진을 분류중입니다. <br> 잠시만 기달려 주세요");
					    $(dropZone).css({
					        "background-image": "url(" + window.URL.createObjectURL(files[0]) + ")",
					        "background-size": "contain",
					        "background-repeat": "no-repeat",
					        "background-position": "center"
					    });
						
						selectFile(files)
						
						ajaxFileUpload()
					}else{
						alert('이미지가 아닙니다.');
						dropZone.innerHTML = "Drop & Click"
		        		$('#drop-zone').css({
					        "background-image": "none"
					    });
						return;
					}
				} else {
					alert("ERROR")
				}
			})
			
			function ajaxFileSelect() {
		        jQuery("#upload-file-input").click();
			}
			
			jQuery(document).ready(function($) {
			    $("#upload-file-input").change(function() {
			        var files = !!this.files ? this.files : [];
			        if(!files.length || !window.FileReader) {
			        	dropZone.innerHTML = "Drop & Click"
		        		$(dropZone).css({
					        "background-image": "none"
					    });
			        	return; // no file selected, or no FileReader support
			        }
			        
			        if(/^image/.test( files[0].type)){ // only image file
				    	ajaxFileUpload()
			        	
			            var reader = new FileReader(); // instance of the FileReader
			            reader.readAsDataURL(files[0]); // read the local file
			            reader.onload = function(e) {
			            	
			    			$(dropZone).html("업로드한 쓰레기사진을 분류중입니다. <br> 잠시만 기달려 주세요");
			            	$(dropZone).css({
						        "background-image": "url(" + e.target.result + ")",
						        "background-size": "contain",
						        "background-repeat": "no-repeat",
						        "background-position": "center"
						    });
			            	console.log(e.target.result)
			            }
			        } else {
			        	alert('이미지가 아닙니다.');
			        	dropZone.innerHTML = "Drop & Click"
		        		$(dropZone).css({
					        "background-image": "none"
					    });
						return;
			        }
			        
			    });
			});
			
		    function ajaxFileUpload() {
		    	$.ajax({
					url: "uploadFile.do",
					type: "POST",
					data: new FormData($("#upload-file-form")[0]),
					dataType: "json",
					enctype: 'multipart/form-data',
					processData: false,
					contentType: false,
					cache: false,
					success: function (data) {
						console.log("success");
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						
						var values = "";
						for(var i in json.list){  // i(인덱스) 변수가 자동으로 1씩 증가 처리됨
							values += "<input type='text' name='file' value='" + json.list[i].file + "'  style='display:none;' />"
									+ "<input type='text' name='category' value='" + json.list[i].category + "'  style='display:none;' />";
							console.log("file : " + json.list[i].file);
							console.log("category : " + json.list[i].category);
						}
						$("#data-push-form").html($("#data-push-form").html() + values);
						jQuery("#data-push-submit").click();
					},
					error: function () {
						console.log("error");
					}
				});
		    }
		});
		</script>
	</head>
    <body class="d-flex flex-column h-100">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Header-->
            <header class="bg-dark">
                <div class="container">
                    <div class="row align-items-center justify-content-center">
	                    <div class="my-2">
	                        <h1 class="display-5 fw-bolder text-white mb-2 text-center">SmarTrash</h1>
	                    </div>
                    </div>
                    <div class="row align-items-center justify-content-center" align="center">
						<div class="my-2">
							<form id="upload-file-form">
								<div id=drop-zone class="text-white d-flex align-items-center justify-content-center user-select-none">Drop & Click</div>
								<input id="upload-file-input" type="file" name="uploadfile" style="display:none;" />
								<input type="submit" id="upload-file-submit" name="submit" style="display:none;" />
							</form>
							<form id="data-push-form" action="dataPush.do" method="post">
								<input type="submit" id="data-push-submit" name="submit" style="display:none;" />
							</form>
						</div>
                    </div>
                    <div class="row align-items-center justify-content-center">
						<div class="my-4 text-center">
						</div>
                    </div>
                </div>
            </header>
            
            <!-- Features section-->
			<section class="bg-light">
                <div class="container px-5">
                    <div class="text-center py-3">
                        <h1 class="fs-4">최근 분류된 쓰레기</h1>
                    </div>
                    <div class="row justify-content-center">
                        <!-- Pricing card free-->
                        <c:forEach items="${ requestScope.trash_list }" var="t">
							<div style="width:120px;" class="mx-1 pb-3 justify-content-center">
								<div style="width:96px; height:96px; background-image: url('${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }'); background-position: center; background-size: 100% 100%;" class="align-items-center d-flex justify-content-center rounded-circle">
									${ status.count }								</div>
								<div class="pt-1 user-select-none text-center">
									<fmt:formatDate value="${ t.trash_date }" pattern="yy-MM-dd" />
									<br>
									<fmt:formatDate value="${ t.trash_date }" pattern="HH:mm:ss" />
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
            </section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
