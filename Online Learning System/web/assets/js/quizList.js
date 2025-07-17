document.addEventListener('DOMContentLoaded', () => {
    // Lấy các phần tử DOM cần thiết
    const deleteModal = document.getElementById('deleteModal');
    const cancelDeleteBtn = document.getElementById('cancelDelete');
    const modalQuizId = document.getElementById('modalQuizId');
    const resetFiltersBtn = document.getElementById('resetFilters');
    const filterForm = document.querySelector('form[method="GET"]');

    const tableView = document.getElementById('tableView');
    const quizTableBody = document.getElementById('quizTableBody'); // Lấy tbody của bảng
    const quizRows = Array.from(document.querySelectorAll('#quizTableBody .quiz-row')); // Lấy tất cả các hàng quiz
    const noQuizMessage = document.querySelector('.no-quiz-message'); // Lấy thông báo không có quiz

    // --- Thêm các biến DOM cho chức năng ẩn/hiện cột ---
    const optionCustomBtn = document.getElementById('optionCustom');
    const optionContentDiv = document.getElementById('optionContent');
    const infoAllCheckbox = document.getElementById('info-all');
    const infoCheckboxes = document.querySelectorAll('.info-checkbox');

    // --- Thêm biến DOM cho chức năng hàng mỗi trang ---
    const rowsPerPageSelect = document.getElementById('rowsPerPage');
    const paginationNav = document.getElementById('pagination-nav'); // Element cho các nút phân trang
    const paginationInfoStart = document.getElementById('pagination-info-start');
    const paginationInfoEnd = document.getElementById('pagination-info-end');
    const paginationInfoTotal = document.getElementById('pagination-info-total');

    // --- Biến trạng thái ---
    let visibleColumns = new Set([0, 1, 2, 3, 4, 5, 6, 7, 8]); // Ban đầu, tất cả các cột đều hiển thị
    let currentPage = 1;
    let rowsPerPage = parseInt(rowsPerPageSelect.value); // Lấy giá trị ban đầu từ select
    let allQuizzes = quizRows; // Giữ một bản sao của tất cả các hàng ban đầu để lọc/phân trang
    let filteredQuizzes = []; // Danh sách các quiz sau khi lọc
    let currentSearchName = document.getElementById('searchName').value.toLowerCase();
    let currentSubject = document.getElementById('subject').value.toLowerCase();
    let currentQuizType = document.getElementById('quizType').value.toLowerCase();

    // Export function to global scope if needed by other inline scripts or dynamically loaded content
    window.showDeleteModal = function(quizId) {
        modalQuizId.value = quizId;
        deleteModal.classList.remove('hidden');
    };

    function hideDeleteModal() {
        deleteModal.classList.add('hidden');
        modalQuizId.value = '';
    }

    cancelDeleteBtn.addEventListener('click', hideDeleteModal);

    // --- Hàm Reset Filters (đã sửa đổi để tương thích với JavaScript) ---
    resetFiltersBtn.addEventListener('click', () => {
        document.getElementById('searchName').value = '';
        document.getElementById('subject').value = '';
        document.getElementById('quizType').value = '';
        
        // Reset các tùy chọn hiển thị cột
        infoAllCheckbox.checked = true;
        infoCheckboxes.forEach(c => c.checked = false);
        visibleColumns = new Set([0, 1, 2, 3, 4, 5, 6, 7, 8]);

        // Reset số hàng mỗi trang
        rowsPerPageSelect.value = "5"; // Giá trị mặc định
        rowsPerPage = 5;
        
        currentPage = 1; // Reset về trang 1
        applyAllFiltersAndPagination(); // Áp dụng lại tất cả
    });

    // --- HÀM MỚI: Áp dụng tất cả các bộ lọc và phân trang ---
    function applyAllFiltersAndPagination() {
        // 1. Lọc dữ liệu
        currentSearchName = document.getElementById('searchName').value.toLowerCase();
        currentSubject = document.getElementById('subject').value.toLowerCase();
        currentQuizType = document.getElementById('quizType').value.toLowerCase();

        filteredQuizzes = allQuizzes.filter(quizRow => {
            const quizName = quizRow.querySelector('td[data-col-index="1"]').textContent.toLowerCase();
            const subject = quizRow.querySelector('td[data-col-index="2"]').textContent.toLowerCase();
            const quizType = quizRow.querySelector('td[data-col-index="7"]').textContent.toLowerCase();

            const matchesSearch = !currentSearchName || quizName.includes(currentSearchName);
            const matchesSubject = !currentSubject || subject === currentSubject;
            const matchesQuizType = !currentQuizType || quizType === currentQuizType;

            return matchesSearch && matchesSubject && matchesQuizType;
        });
        
        // 2. Xây dựng phân trang dựa trên filteredQuizzes
        buildPagination(Math.ceil(filteredQuizzes.length / rowsPerPage));
        
        // 3. Render các hàng cho trang hiện tại
        renderQuizRows();
        
        // 4. Áp dụng hiển thị cột
        applyColumnVisibility();
    }

    // --- Hàm áp dụng hiển thị cột (không đổi) ---
    function applyColumnVisibility() {
        const quizTable = document.getElementById('quizTable');
        if (!quizTable) return;

        const headers = quizTable.querySelectorAll('thead th[data-col-index]');
        const rows = quizTable.querySelectorAll('tbody tr'); // Lấy tất cả các hàng, kể cả ẩn

        headers.forEach(header => {
            const colIndex = parseInt(header.dataset.colIndex);
            header.classList.toggle('hidden-column', !(visibleColumns.has(colIndex)));
        });

        rows.forEach(row => {
            // Bỏ qua hàng "không tìm thấy"
            if (row.classList.contains('no-quiz-message')) return;

            const cells = row.querySelectorAll('td[data-col-index]');
            cells.forEach(cell => {
                const colIndex = parseInt(cell.dataset.colIndex);
                cell.classList.toggle('hidden-column', !(visibleColumns.has(colIndex)));
            });
        });
    }

    // --- Hàm render các hàng cho trang hiện tại ---
    function renderQuizRows() {
        quizTableBody.innerHTML = ''; // Xóa tất cả các hàng hiện có

        if (filteredQuizzes.length === 0) {
            // Hiển thị thông báo không có quiz
            if (noQuizMessage) {
                const clonedNoMessage = noQuizMessage.cloneNode(true);
                clonedNoMessage.classList.remove('hidden-column'); // Đảm bảo nó hiện
                quizTableBody.appendChild(clonedNoMessage);
            }
            paginationNav.classList.add('hidden'); // Ẩn phân trang
            paginationInfoStart.textContent = 0;
            paginationInfoEnd.textContent = 0;
            paginationInfoTotal.textContent = 0;
            return;
        }

        paginationNav.classList.remove('hidden');

        const start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;
        if (rowsPerPage === 'all' || end > filteredQuizzes.length) {
            end = filteredQuizzes.length;
        }
        
        const pageRows = filteredQuizzes.slice(start, end);

        pageRows.forEach(row => {
            quizTableBody.appendChild(row);
        });

        // Cập nhật thông tin phân trang
        paginationInfoStart.textContent = filteredQuizzes.length > 0 ? (start + 1) : 0;
        paginationInfoEnd.textContent = end;
        paginationInfoTotal.textContent = filteredQuizzes.length;
    }

    // --- Hàm xây dựng phân trang ---
    function buildPagination(totalPages) {
        paginationNav.innerHTML = ''; // Xóa các nút phân trang cũ

        if (totalPages <= 1) {
            paginationNav.classList.add('hidden');
            return;
        }
        paginationNav.classList.remove('hidden');

        // Nút Previous
        const prevLink = document.createElement('a');
        prevLink.href = "#";
        prevLink.className = `relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 ${currentPage == 1 ? 'opacity-50 cursor-not-allowed' : ''}`;
        prevLink.innerHTML = `<span class="sr-only">Previous</span><i class="fas fa-chevron-left"></i>`;
        prevLink.onclick = (e) => {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                applyAllFiltersAndPagination();
            }
        };
        paginationNav.appendChild(prevLink);

        // Các nút số trang
        for (let i = 1; i <= totalPages; i++) {
            const pageLink = document.createElement('a');
            pageLink.href = "#";
            pageLink.className = `relative inline-flex items-center px-4 py-2 border text-sm font-medium ${i == currentPage ? 'active' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'}`;
            pageLink.textContent = i;
            pageLink.onclick = (e) => {
                e.preventDefault();
                if (i !== currentPage) {
                    currentPage = i;
                    applyAllFiltersAndPagination();
                }
            };
            paginationNav.appendChild(pageLink);
        }

        // Nút Next
        const nextLink = document.createElement('a');
        nextLink.href = "#";
        nextLink.className = `relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 ${currentPage == totalPages ? 'opacity-50 cursor-not-allowed' : ''}`;
        nextLink.innerHTML = `<span class="sr-only">Next</span><i class="fas fa-chevron-right"></i>`;
        nextLink.onclick = (e) => {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                applyAllFiltersAndPagination();
            }
        };
        paginationNav.appendChild(nextLink);
    }

    // --- Event Listeners cho chức năng ẩn/hiện cột ---
    optionCustomBtn?.addEventListener("click", () => {
        optionContentDiv.style.display = optionContentDiv.style.display === "block" ? "none" : "block";
    });

    infoAllCheckbox.addEventListener("change", () => {
        if (infoAllCheckbox.checked) {
            infoCheckboxes.forEach(c => c.checked = false);
            visibleColumns = new Set([0, 1, 2, 3, 4, 5, 6, 7, 8]);
        }
        applyColumnVisibility();
    });

    infoCheckboxes.forEach((cb) => {
        cb.addEventListener("change", () => {
            const checkedValues = Array.from(infoCheckboxes)
                                            .filter(c => c.checked)
                                            .map(c => parseInt(c.value));

            if (checkedValues.length === 0) {
                infoAllCheckbox.checked = true;
                visibleColumns = new Set([0, 1, 2, 3, 4, 5, 6, 7, 8]);
            } else {
                infoAllCheckbox.checked = false;
                visibleColumns = new Set(checkedValues);
            }
            applyColumnVisibility();
        });
    });

    // --- Event Listener cho input hàng mỗi trang ---
    rowsPerPageSelect.addEventListener("change", () => {
        rowsPerPage = rowsPerPageSelect.value === 'all' ? 'all' : parseInt(rowsPerPageSelect.value);
        currentPage = 1; // Reset về trang 1 khi thay đổi số hàng mỗi trang
        applyAllFiltersAndPagination();
    });

    // --- Event Listener cho Form Search/Filter (sử dụng logic JS thay vì submit form) ---
    filterForm.addEventListener("submit", (e) => {
        e.preventDefault(); // Ngăn chặn form submit mặc định
        currentPage = 1; // Reset về trang 1 khi có bộ lọc mới
        applyAllFiltersAndPagination();
    });
    
    // --- Chạy khi DOM tải xong ---
    tableView.classList.remove('hidden'); // Đảm bảo bảng luôn hiển thị
    
    // Khởi tạo rowsPerPage từ giá trị mặc định của select
    rowsPerPage = parseInt(rowsPerPageSelect.value);

    // Lấy tất cả hàng ban đầu
    allQuizzes = Array.from(document.querySelectorAll('#quizTableBody .quiz-row'));

    // Áp dụng tất cả bộ lọc và phân trang lần đầu
    applyAllFiltersAndPagination();
});