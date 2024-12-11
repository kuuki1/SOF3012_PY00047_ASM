<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Catalog</title>
    <%@ include file="/common/head.jsp" %>
    <style>
        .tm-catalog-item-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: start;
        }

        .tm-catalog-item {
            flex: 1 1 calc(33.33% - 20px);
            max-width: calc(33.33% - 20px);
            display: flex;
            flex-direction: column;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .tm-catalog-item:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .tm-thumbnail-container {
            position: relative;
            width: 100%;
            height: 250px;
            overflow: hidden;
        }

        .tm-catalog-item-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
        }

        .tm-img-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 48px;
            color: white;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .tm-thumbnail-container:hover .tm-img-overlay {
            opacity: 1;
        }

        .tm-catalog-item-description {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            flex-grow: 1;
        }

        .tm-text-primary {
            color: #007bff;
        }

        .tm-text-gray {
            color: #6c757d;
        }

        .tm-tex-gray-light {
            color: #adb5bd;
        }

        @media (max-width: 768px) {
            .tm-catalog-item {
                flex: 1 1 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .tm-catalog-item {
                flex: 1 1 100%;
                max-width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="tm-page-wrap mx-auto">
        <%@ include file="/common/header.jsp" %>
        <%@ include file="/common/Categories.jsp" %>
        <div class="container-fluid">
            <div id="content" class="mx-auto tm-content-container">
                <main>
                    <div class="row">
                        <div class="col-12">
                            <h2 class="tm-page-title mb-4">Our Video Catalog</h2>
                        </div>
                    </div>

                    <div class="tm-catalog-item-list">
                        <c:forEach items="${videos}" var="video">
                            <div class="tm-catalog-item">
                                <div class="tm-thumbnail-container">
                                    <img src="<c:url value='/${video.poster}'/>" alt="${video.title}" class="img-fluid tm-catalog-item-img">
                                    <a href="<c:url value='/video?action=watch&id=${video.videoUrl}'/>"
                                       class="tm-img-overlay">
                                        <i class="fas fa-play-circle"></i>
                                    </a>
                                </div>
                                <div class="tm-catalog-item-description">
                                    <h3 class="tm-text-primary mb-3">${video.title}</h3>
                                    <p>${video.description}</p>
                                    <div class="d-flex justify-content-between tm-text-gray">
                                        <span class="tm-tex-gray-light">${video.shareCount} Share</span>
                                        <span>${video.viewCount} Views</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div>
                        <ul class="nav tm-paging-links">
                            <c:forEach varStatus="i" begin="1" end="${maxPage}">
                                <li class="nav-item ${currentPage == i.index ? 'active' : ''}">
                                    <a href="/SOF3012_PY00047_ASM/index?page=${i.index}" class="nav-link tm-paging-link">${i.index}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </main>
            </div>
        </div>
        <%@ include file="/common/footer.jsp"%>
    </div>
</body>

</html>
