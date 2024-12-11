<div class="tm-categories-container mb-5">
    <ul class="nav tm-category-list">
    	<li class="nav-item tm-category-item"><a href="/SOF3012_PY00047_ASM/index" class="nav-link tm-category-link">All</a></li>
        <c:forEach var="category" items="${categories}">
            <li class="nav-item tm-category-item">
                <a href="/SOF3012_PY00047_ASM/category/${category.id}" class="nav-link tm-category-link">${category.name}</a>
            </li>
        </c:forEach>
    </ul>
</div>   

<style>
.tm-categories-container {
    margin-bottom: 30px;
    text-align: center;
}

.tm-categories-text {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
    text-transform: uppercase;
}

.tm-category-list {
    list-style-type: none;
    padding: 0;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
}

.tm-category-item {
    display: inline-block;
}

.tm-category-link {
    text-decoration: none;
    color: #007BFF;
    font-size: 18px;
    padding: 10px 20px;
    border: 2px solid #007BFF;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.tm-category-link:hover {
    background-color: #007BFF;
    color: white;
    transform: scale(1.1);
}

</style>