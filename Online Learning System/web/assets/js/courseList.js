// ====== DOM Elements ======
const container = document.querySelector(".subject-container");
const noCourseMessage = document.getElementById("noCourseMessage");
const pagination = document.querySelector(".pagination");
const paginationNav = document.querySelector("nav[aria-label='Subject pagination']");

const coursePerPageInput = document.getElementById("coursePerPage");
const priceRangeInput = document.getElementById("priceRange");
const priceRangeValue = document.getElementById("priceRangeValue");

const searchForm = document.getElementById("searchForm");
const searchInput = document.getElementById("searchInput");

const infoAll = document.getElementById("info-all");
const infoFilter = document.querySelectorAll("input[id^='info-']:not(#info-all)");

const catAll = document.getElementById("cat-all");
const catFilter = document.querySelectorAll("input[id^='cat-']:not(#cat-all)");

const applyBtn = document.getElementById("applyFilter");
const clearBtn = document.getElementById("clearFilter");

const categoryLinks = document.querySelectorAll(".category-sidebar");

// ====== State ======
let sortStatus = "updated";
let currentMaxPrice = parseInt(priceRangeInput?.value) || 2000000;
let currentPage = 1;
let coursePerPage = parseInt(coursePerPageInput?.value || 4);
let searchKeyword = "";
let displayFields = new Set(); //Set giá trị hiển thị của 1 course
let selectedCategories = new Set(); //Set giá trị chứa category

// ====== Original course list ======
const originalCourses = Array.from(container.querySelectorAll(".course-item"));

// ====== Init ======
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("reset")?.addEventListener("click", resetAllFilters); //nút reset
    const urlParams = new URLSearchParams(window.location.search);
    searchKeyword = urlParams.get("search")?.trim().toLowerCase() || "";  //search bar bên ngoài
    if (searchKeyword)
        searchInput.value = searchKeyword;
    const searchCategory = urlParams.get("category")?.trim().toLowerCase();  // category bên ngoài
    if (searchCategory) {
        selectedCategories = new Set([searchCategory]);
        // Cập nhật checkbox
        catAll.checked = false;
        catFilter.forEach(cb => {
            const val = cb.value.trim().toLowerCase();
            cb.checked = selectedCategories.has(val);
        });
    }
    // Hiển thị thanh custom display
    document.getElementById("optionCustom")?.addEventListener("click", () => {
        const content = document.getElementById("optionContent");
        content.style.display = content.style.display === "block" ? "none" : "block";
    });

    initCheckboxGroup(infoAll, infoFilter);
    initCheckboxGroup(catAll, catFilter, selectedCategories);
    FilterEvents();
    SearchAndSortEvents();
    bindCategoryLinks();

    applyDisplaySettings();
});

// ====== Checkbox Group ======
function initCheckboxGroup(allCheckbox, groupCheckboxes, valueSet = null) {
    allCheckbox?.addEventListener("change", () => {
        if (allCheckbox.checked) {
            groupCheckboxes.forEach(cb => cb.checked = false);
            valueSet?.clear();
            currentPage = 1;
            applyCourseFiltersAndSort();
        }
    });

    groupCheckboxes.forEach(cb => {
        cb.addEventListener("change", () => {
            const anyChecked = [...groupCheckboxes].some(c => c.checked);
            allCheckbox.checked = !anyChecked;

            if (valueSet) {
                valueSet.clear();
                groupCheckboxes.forEach(c => {
                    if (c.checked)
                        valueSet.add(c.value.trim().toLowerCase());
                });
            }
            currentPage = 1;
            applyCourseFiltersAndSort();
        });
    });
}

// ====== Filter Events ======
function FilterEvents() {
    //Course per page
    coursePerPageInput?.addEventListener("change", () => {
        coursePerPage = parseInt(coursePerPageInput.value);
        currentPage = 1;
        applyCourseFiltersAndSort();
    });
    //Price Range
    priceRangeInput?.addEventListener("input", () => {
        currentMaxPrice = parseInt(priceRangeInput.value);
        priceRangeValue.textContent = new Intl.NumberFormat("vi-VN").format(currentMaxPrice) + " ₫";
        currentPage = 1;
        applyCourseFiltersAndSort();
    });

    applyBtn?.addEventListener("click", applyDisplaySettings);

    clearBtn?.addEventListener("click", () => {
        infoAll.checked = true;
        infoFilter.forEach(cb => cb.checked = false);

        catAll.checked = true;
        catFilter.forEach(cb => cb.checked = false);
        selectedCategories.clear();
        searchInput.value = "";
        coursePerPageInput.value = coursePerPage = 4;
        currentPage = 1;
        applyDisplaySettings();
    });
}

// ====== Search & Sort ======
function SearchAndSortEvents() {
    //search bar
    searchForm?.addEventListener("submit", (e) => {
        e.preventDefault();
        searchKeyword = searchInput.value.trim().toLowerCase();
        currentPage = 1;
        applyCourseFiltersAndSort();
    });
    //sort button
    document.querySelectorAll(".sort-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            document.querySelectorAll(".sort-btn").forEach(b => b.classList.remove("active"));
            this.classList.add("active");
            sortStatus = this.dataset.sort;
            currentPage = 1;
            applyCourseFiltersAndSort();
        });
    });
}

// ====== Category Sidebar Clicks ======
function bindCategoryLinks() {
    categoryLinks.forEach(link => {
        link.addEventListener("click", (e) => {
            e.preventDefault();
            const selected = link.textContent.trim().toLowerCase();
            selectedCategories = new Set([selected]);

            catAll.checked = false;
            catFilter.forEach(cb => {
                const val = cb.value.trim().toLowerCase();
                cb.checked = selectedCategories.has(val);
            });

            currentPage = 1;
            applyCourseFiltersAndSort();
        });
    });
}

// ====== Display Settings ======
function applyDisplaySettings() {
    displayFields.clear();
    if (infoAll.checked) {
        displayFields.add("all");
    } else {
        infoFilter.forEach(cb => cb.checked && displayFields.add(cb.value));
    }
    applyCourseFiltersAndSort();
}

// ====== Main Filter + Sort Logic ======
function applyCourseFiltersAndSort() {
    const filtered = originalCourses.filter(course => {
        const price = parseInt(course.dataset.price);
        const title = course.querySelector(".course-title")?.textContent.toLowerCase() || "";
        const desc = course.querySelector(".course-description")?.textContent.toLowerCase() || "";
        const cat = course.dataset.category?.toLowerCase() || "";
        return (price <= currentMaxPrice) &&
                (title.includes(searchKeyword) || desc.includes(searchKeyword)) &&
                (selectedCategories.size === 0 || selectedCategories.has(cat));
    });
    filtered.sort((a, b) => {
        const getPrice = (course) => {
            const newPriceEl = course.querySelector(".new-price");
            const rawText = newPriceEl.textContent.trim().replace(/[^\d]/g, "");
            return parseInt(rawText, 10) || 0;
        };
        const priceA = getPrice(a);
        const priceB = getPrice(b);
        switch (sortStatus) {
            case "price-asc":
                return priceA - priceB;
            case "price-desc":
                return priceB - priceA;
            case "popular":
                return b.dataset.enrolled - a.dataset.enrolled;
            case "updated":
                return b.dataset.updated - a.dataset.updated;
            case "recommend":
                return b.dataset.rating - a.dataset.rating;
            default:
                return 0;
        }
    });
    container.innerHTML = "";
    if (filtered.length === 0) {
        noCourseMessage.style.display = "block";
        paginationNav.style.display = "none";
        return;
    } else {
        noCourseMessage.style.display = "none";
    }

    const totalPages = Math.ceil(filtered.length / coursePerPage);
    const pagedCourses = filtered.slice((currentPage - 1) * coursePerPage, currentPage * coursePerPage);
    pagedCourses.forEach(course => {
        const fieldMap = {
            title: ".course-title",
            category: ".course-category",
            lectures: ".course-lecture",
            imageurl: ".course-thumbnail",
            courseshortdescription: ".course-description",
            updatedate: ".course-updateDate",
            totalenrollment: ".course-enroll",
            rating: ".course-rating",
            coursepackage: ".course-package"
        };
        for (const [key, selector] of Object.entries(fieldMap)) {
            course.querySelector(selector).classList.toggle("d-none", !(displayFields.has("all") || displayFields.has(key)));
        }

        // ===== Update Price and Discount Badge =====
        const select = course.querySelector(".course-package");
        const oldPriceEl = course.querySelector(".old-price");
        const newPriceEl = course.querySelector(".new-price");
        const saleRateEl = course.querySelector(".sale-rate");
        const discountBadge = course.querySelector(".discount-badge");
        const updatePrice = () => {
            const selected = select?.selectedOptions[0];
            const oldPrice = parseFloat(selected.dataset.price || "0");
            const salePrice = parseFloat(selected.dataset.sale || "0");
            const saleRate = parseFloat(selected.dataset.salerate || "0");
            discountBadge.textContent = `${saleRate}% OFF`;
            discountBadge.style.display = "inline-block";
            oldPriceEl.textContent = new Intl.NumberFormat("vi-VN").format(oldPrice) + " ₫";
            newPriceEl.textContent = new Intl.NumberFormat("vi-VN").format(salePrice) + " ₫";
        };
        select.addEventListener("change", updatePrice);
        updatePrice();
        container.appendChild(course); //chuyển course đã sửa giá xuống cuối contenter (không thêm mới)
    });
    updatePagination(totalPages);
}

// ====== Pagination Builder ======
function updatePagination(totalPages) {
    pagination.innerHTML = "";
    paginationNav.style.display = totalPages > 1 ? "block" : "none";
    //tạo <li> <a>
    const createItem = (label, page, disabled = false, active = false) => {
        const li = document.createElement("li");
        li.className = `page-item${disabled ? " disabled" : ""}${active ? " active" : ""}`;
        const a = document.createElement("a");
        a.className = "page-link";
        a.href = "#";
        a.textContent = label;
        a.addEventListener("click", (e) => {
            e.preventDefault();
            currentPage = page;
            applyCourseFiltersAndSort();
        });
        li.appendChild(a);
        return li;
    };

    const addDotPage = () => {
        const li = document.createElement("li");
        li.className = "page-item disabled";
        li.innerHTML = `<span class="page-link">...</span>`;
        pagination.appendChild(li);
    };
    pagination.appendChild(createItem("Prev", currentPage - 1, currentPage === 1));
    if (totalPages <= 5) {
        for (let i = 1; i <= totalPages; i++) {
            pagination.appendChild(createItem(i, i, false, i === currentPage));
        }
    } else {
        switch (true) {
            // page 1-2-3
            case (currentPage <= 3):
                for (let i = 1; i <= 3; i++) {
                    pagination.appendChild(createItem(i, i, false, i === currentPage));
                }
                addDotPage();
                pagination.appendChild(createItem(totalPages, totalPages));
                break;
                // Page at last
            case (currentPage >= totalPages - 1):
                pagination.appendChild(createItem(1, 1));
                addDotPage();
                for (let i = totalPages - 2; i <= totalPages; i++) {
                    pagination.appendChild(createItem(i, i, false, i === currentPage));
                }
                break;
                // middle
            default:
                pagination.appendChild(createItem(1, 1));
                addDotPage();
                for (let i = currentPage - 1; i <= currentPage + 1; i++) {
                    pagination.appendChild(createItem(i, i, false, i === currentPage));
                }
                addDotPage();
                pagination.appendChild(createItem(totalPages, totalPages));
                break;
        }
    }
    pagination.appendChild(createItem("Next", currentPage + 1, currentPage === totalPages));
}

// ====== Reset Filters ======
function resetAllFilters() {
    searchKeyword = "";
    searchInput.value = "";
    currentMaxPrice = parseInt(priceRangeInput?.max) || 2000000;
    priceRangeInput.value = currentMaxPrice;
    priceRangeValue.textContent = new Intl.NumberFormat("vi-VN").format(currentMaxPrice) + " ₫";
    infoAll.checked = true;
    infoFilter.forEach(cb => cb.checked = false);
    catAll.checked = true;
    catFilter.forEach(cb => cb.checked = false);
    selectedCategories.clear();
    coursePerPage = 4;
    coursePerPageInput.value = 4;
    sortStatus = "updated";
    currentPage = 1;
    document.querySelectorAll(".sort-btn").forEach(btn =>
        btn.classList.toggle("active", btn.dataset.sort === "updated")
    );
    applyDisplaySettings();
}
