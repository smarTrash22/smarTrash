<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
						
						dropZone.innerHTML = ""
						
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
			            	dropZone.innerHTML = ""
			            	
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
		    	
				$(dropZone).html("업로드한 쓰레기사진을 분류중입니다. <br> 잠시만 기달려 주세요");
		    	
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
            <section class="py-5" id="features">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">${ line }</h2></div>
                        <div class="col-lg-8">
                            <div class="row gx-5 row-cols-1 row-cols-md-2">
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-collection"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-building"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col mb-5 mb-md-0 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Testimonial section-->
            <div class="py-5 bg-light">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-10 col-xl-7">
                            <div class="text-center">
                                <div class="fs-4 mb-4 fst-italic">"Working with Start Bootstrap templates has saved me tons of development time when building new projects! Starting with a Bootstrap template just makes things easier!"</div>
                                <div class="d-flex align-items-center justify-content-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="fw-bold">
                                        Tom Ato
                                        <span class="fw-bold text-primary mx-1">/</span>
                                        CEO, Pomodoro
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Blog preview section-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <div class="text-center">
                                <h2 class="fw-bolder">From our blog</h2>
                                <p class="lead fw-normal text-muted mb-5">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eaque fugit ratione dicta mollitia. Officiis ad.</p>
                            </div>
                        </div>
                    </div>
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="https://dummyimage.com/600x350/ced4da/6c757d" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Blog post title</h5></a>
                                    <p class="card-text mb-0">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Kelly Rowan</div>
                                                <div class="text-muted">March 12, 2021 &middot; 6 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">Media</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Another blog post title</h5></a>
                                    <p class="card-text mb-0">This text is a bit longer to illustrate the adaptive height of each card. Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Josiah Barclay</div>
                                                <div class="text-muted">March 23, 2021 &middot; 4 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="https://dummyimage.com/600x350/6c757d/343a40" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">The last blog post title is a little bit longer than the others</h5></a>
                                    <p class="card-text mb-0">Some more quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Evelyn Martinez</div>
                                                <div class="text-muted">April 2, 2021 &middot; 10 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Call to action-->
                    <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                        <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                            <div class="mb-4 mb-xl-0">
                                <div class="fs-3 fw-bold text-white">New products, delivered to you.</div>
                                <div class="text-white-50">Sign up for our newsletter for the latest updates.</div>
                            </div>
                            <div class="ms-xl-4">
                                <div class="input-group mb-2">
                                    <input class="form-control" type="text" placeholder="Email address..." aria-label="Email address..." aria-describedby="button-newsletter" />
                                    <button class="btn btn-outline-light" id="button-newsletter" type="button">Sign up</button>
                                </div>
                                <div class="small text-white-50">We care about privacy, and will never share your data.</div>
                            </div>
                        </div>
                    </aside>
                </div>
            </section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
