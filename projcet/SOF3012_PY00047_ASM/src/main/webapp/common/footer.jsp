<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <footer class="footer mt-auto py-4 bg-dark text-white text-center">
	    <div class="container">
	        <p class="mb-0">ASM_SOF3012_PY00047 &copy; 2024 - All Rights Reserved</p>
	    </div>
	</footer>

	<style>
		.footer {
		    background-color: #343a40;
		    color: #f8f9fa;
		    border-top: 2px solid #007bff;
		}
		
		.footer p {
		    font-size: 14px;
		    letter-spacing: 0.5px;
		}
		
		.footer a {
		    color: #007bff;
		    text-decoration: none;
		}
		
		.footer a:hover {
		    color: #0056b3;
		    text-decoration: underline;
		}
				
	</style>

    <script src="<c:url value='/templates/user/js/jquery-3.4.1.min.js'/>"></script>
    <script src="<c:url value='/templates/user/js/bootstrap.min.js'/>"></script>
    <script>
        function setVideoSize() {
            const vidWidth = 1920;
            const vidHeight = 1080;
            let windowWidth = window.innerWidth;
            let newVidWidth = windowWidth;
            let newVidHeight = windowWidth * vidHeight / vidWidth;
            let marginLeft = 0;
            let marginTop = 0;
            if (newVidHeight < 500) {
                newVidHeight = 500;
                newVidWidth = newVidHeight * vidWidth / vidHeight;
            }
            if(newVidWidth > windowWidth) {
                marginLeft = -((newVidWidth - windowWidth) / 2);
            }
            if(newVidHeight > 720) {
                marginTop = -((newVidHeight - $('#tm-video-container').height()) / 2);
            }
            const tmVideo = $('#tm-video');
            tmVideo.css('width', newVidWidth);
            tmVideo.css('height', newVidHeight);
            tmVideo.css('margin-left', marginLeft);
            tmVideo.css('margin-top', marginTop);
        }
        $(document).ready(function () {
            setVideoSize();
            let timeout;
            window.onresize = function () {
                clearTimeout(timeout);
                timeout = setTimeout(setVideoSize, 100);
            };
            const btn = $("#tm-video-control-button");
            btn.on("click", function (e) {
                const video = document.getElementById("tm-video");
                $(this).removeClass();
                if (video.paused) {
                    video.play();
                    $(this).addClass("fas fa-pause");
                } else {
                    video.pause();
                    $(this).addClass("fas fa-play");
                }
            });
        })
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>