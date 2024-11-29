<div class="tm-categories-container mb-5">
    <h3 class="tm-text-primary tm-categories-text">Categories:</h3>
    <ul class="nav tm-category-list">
    	<li class="nav-item tm-category-item"><a href="/SOF3012_PY00047_ASM/index" class="nav-link tm-category-link">All</a></li>
        <c:forEach var="category" items="${categories}">
            <li class="nav-item tm-category-item">
                <a href="/SOF3012_PY00047_ASM/category/${category.id}" class="nav-link tm-category-link">${category.name}</a>
            </li>
        </c:forEach>
    </ul>
</div>   