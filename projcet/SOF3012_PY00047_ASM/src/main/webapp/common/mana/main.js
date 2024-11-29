// main.js
document.querySelectorAll('.btn-delete').forEach(button => {
    button.addEventListener('click', (event) => {
        const confirmDelete = confirm("Bạn có chắc chắn muốn xóa người dùng này?");
        if (!confirmDelete) {
            event.preventDefault();
        }
    });
});

document.querySelector('.btn-reset').addEventListener('click', (event) => {
    const confirmReset = confirm("Bạn có muốn đặt lại thông tin?");
    if (!confirmReset) {
        event.preventDefault();
    }
});
document.addEventListener("DOMContentLoaded", function () {
    // Xác nhận khi xóa video
    const deleteButtons = document.querySelectorAll(".btn-delete");
    deleteButtons.forEach((button) => {
        button.addEventListener("click", function (event) {
            const confirmDelete = confirm("Are you sure you want to delete this video?");
            if (!confirmDelete) {
                event.preventDefault();
            }
        });
    });
});
