document.addEventListener("DOMContentLoaded", function () {
// ====== DOM Elements ======
    const container = document.querySelector(".subject-container");
    const noMsg = document.getElementById("noCourseMessage");
    const pagination = document.querySelector(".pagination");
    const nav = document.querySelector("nav[aria-label='Subject pagination']");

    const perPageInput = document.getElementById("coursePerPage");
    const priceInput = document.getElementById("priceRange");
    const priceValue = document.getElementById("priceRangeValue");

    const searchForm = document.getElementById("searchForm");
    const searchInput = document.getElementById("searchInput");

    const infoAll = document.getElementById("info-all");
    const infoChecks = document.querySelectorAll("input[id^='info-']:not(#info-all)");

    const catAll = document.getElementById("cat-all");
    const catChecks = document.querySelectorAll("input[id^='cat-']:not(#cat-all)");

    const sortBtns = document.querySelectorAll(".sort-btn");
    const catLinks = document.querySelectorAll(".category-sidebar");

    const applyBtn = document.getElementById("applyFilter");
    const clearBtn = document.getElementById("clearFilter");
    const resetBtn = document.getElementById("reset");

    const optionBtn = document.getElementById("optionCustom");
    const optionContent = document.getElementById("optionContent");

    optionBtn?.addEventListener("click", () => {
        optionContent.style.display = optionContent.style.display === "block" ? "none" : "block";
    });
// ====== State ======
    let courses = Array.from(container.querySelectorAll(".course-item"));
    let filtered = [];
    let searchKey = new URLSearchParams(window.location.search).get("search")?.trim().toLowerCase() || "";
    let categories = new Set();
    const catParam = new URLSearchParams(window.location.search).get("category")?.trim().toLowerCase();
    if (catParam)
        categories.add(catParam);
    let sortKey = "updated";
    let displayFields = new Set(["all"]);
    let MaxPrice = parseInt(priceInput.value) || 2000000;
    let currentPage = 1;
    let perPage = parseInt(perPageInput.value) || 4;

    if (searchKey)
        searchInput.value = searchKey;
    if (catParam) {
        catAll.checked = false;
        catChecks.forEach(c => c.checked = c.value.toLowerCase() === catParam);
    }
    // ===== Event Binding =====
    // ===== Course Per Page =====
    perPageInput.addEventListener("change", () => {
        perPage = +perPageInput.value;
        currentPage = 1;
        applyFilters();
    });

    // ===== Price Range =====
    priceInput.addEventListener("input", () => {
        MaxPrice = +priceInput.value;
        priceValue.textContent = new Intl.NumberFormat("vi-VN").format(MaxPrice) + " ₫";
        applyFilters();
    });
    // ===== Search Form =====
    searchForm.addEventListener("submit", (e) => {
        e.preventDefault();
        searchKey = searchInput.value.trim().toLowerCase();
        currentPage = 1;
        applyFilters();
    });
    // ===== Sider sorting =====
    sortBtns.forEach((btn) => {
        btn.addEventListener("click", function () {
            sortBtns.forEach((b) => b.classList.remove("active"));
            this.classList.add("active");
            sortKey = this.dataset.sort;
            currentPage = 1;
            applyFilters();
        });
    });
    // ===== Info box =====
    infoAll.addEventListener("change", () => {
        if (infoAll.checked)
            infoChecks.forEach(c => c.checked = false);
        applyFilters();
    });
    infoChecks.forEach((cb) => {
        cb.addEventListener("change", () => {
            const checked = Array.from(infoChecks).filter(c => c.checked);
            if (checked.length === 0) {
                infoAll.checked = true;
                displayFields = new Set(["all"]);
            } else {
                infoAll.checked = false;
                displayFields = new Set(checked.map(c => c.value));
            }
            applyFilters();
        });
    });
    // ===== Cat box =====
    catAll.addEventListener("change", () => {
        if (catAll.checked) {
            categories.clear();
            catChecks.forEach((c) => (c.checked = false));
            applyFilters();
        }
    });

    catChecks.forEach((cb) => {
        cb.addEventListener("change", () => {
            categories.clear();
            catChecks.forEach((c) => {
                if (c.checked)
                    categories.add(c.value.toLowerCase());
            });
            catAll.checked = categories.size === 0;
            applyFilters();
        });
    });
    // ===== Category from sider =====
    catLinks.forEach((link) => {
        link.addEventListener("click", (e) => {
            e.preventDefault();
            const cat = link.textContent.trim().toLowerCase();
            categories = new Set([cat]);
            catChecks.forEach((c) => (c.checked = c.value.toLowerCase() === cat));
            catAll.checked = false;
            applyFilters();
        });
    });
    // ===== Button =====
    applyBtn.addEventListener("click", applyFilters);
    clearBtn.addEventListener("click", clearAll);
    resetBtn.addEventListener("click", resetAll);

    // ===== Help Func =====
    // ===== Get Course Price base on sale at the selected package =====
    function getCoursePrice(course) {
        const priceEl = course.querySelector(".new-price");
        return parseInt(priceEl?.textContent.replace(/\D/g, "") || "0", 10);
    }
    // ===== Display the sale rate and Price after sale base on the coursePackage =====
    function updatePrice(course) {
        const sel = course.querySelector(".course-package");
        const badge = course.querySelector(".discount-badge");
        const oldP = course.querySelector(".old-price");
        const newP = course.querySelector(".new-price");
        const d = sel.selectedOptions[0].dataset;
        badge.textContent = `${d.salerate}% OFF`;
        oldP.textContent = new Intl.NumberFormat("vi-VN").format(d.price) + " ₫";
        newP.textContent = new Intl.NumberFormat("vi-VN").format(d.sale) + " ₫";
        badge.style.display = "inline-block";
    }
    // ===== Core Func =====
    // ===== Filter =====
    function applyFilters() {
        filtered = courses
                .filter((c) => {
                    const price = getCoursePrice(c);
                    const title = c.querySelector(".course-title").textContent.toLowerCase();
                    const desc = c.querySelector(".course-description").textContent.toLowerCase();
                    const cat = c.dataset.category.toLowerCase();
                    return (
                            price <= MaxPrice &&
                            (!searchKey || title.includes(searchKey) || desc.includes(searchKey)) &&
                            (categories.size === 0 || categories.has(cat))
                            );
                })
                .sort((a, b) => {
                    const priceA = getCoursePrice(a);
                    const priceB = getCoursePrice(b);
                    switch (sortKey) {
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
                    }
                });
        buildPagination(Math.ceil(filtered.length / perPage));
        renderCourses();
    }
    // ===== Custom Display of Course Card =====
    function renderCourses() {
        container.innerHTML = "";
        if (!filtered.length) {
            noMsg.style.display = "block";
            pagination.style.display = "none";
            return;
        }
        noMsg.style.display = "none";
        const start = (currentPage - 1) * perPage;
        const pageItems = filtered.slice(start, start + perPage);
        const fieldMap = {
            title: ".course-title",
            category: ".course-category",
            lectures: ".course-lecture",
            imageurl: ".course-thumbnail",
            courseshortdescription: ".course-description",
            updatedate: ".course-updateDate",
            totalenrollment: ".course-enroll",
            rating: ".course-rating",
            coursepackage: ".course-package"};
        pageItems.forEach((course) => {
            Object.entries(fieldMap).forEach(([key, selector]) => {
                const element = course.querySelectorAll(selector);
                element.forEach((el) => {
                    el.classList.toggle("d-none", !(displayFields.has("all") || displayFields.has(key)));
                });
            });
            // ===== Select package =====
            const selected = course.querySelector(".course-package");
            if (!selected.hasListener) {
                selected.addEventListener("change", () => updatePrice(course));
                selected.hasListener = true;
            }
            updatePrice(course);
            container.appendChild(course);
        });
    }
    // ===== Pagination =====
    function buildPagination(totalPages) {
        pagination.innerHTML = "";
        nav.style.display = totalPages > 1 ? "block" : "none";
        // Make <li><a> to make page.
        function makeItem(label, page, disabled, active) {
            const li = document.createElement("li");
            li.className = "page-item" + (disabled ? " disabled" : "") + (active ? " active" : "");
            const a = document.createElement("a");
            a.className = "page-link";
            a.href = "#";
            a.textContent = label;
            a.onclick = (e) => {
                e.preventDefault();
                if (!disabled && page >= 1 && page <= totalPages) {
                    currentPage = page;
                    applyFilters();
                }
            };
            li.appendChild(a);
            pagination.appendChild(li);
        }
        makeItem("Prev", currentPage - 1, currentPage === 1);
        for (let i = 1; i <= totalPages; i++) {
            makeItem(i, i, false, i === currentPage);
        }
        makeItem("Next", currentPage + 1, currentPage === totalPages);
    }
    function clearAll() {
        categories.clear();
        displayFields = new Set(["all"]);
        currentPage = 1;
        perPage = 4;
        infoAll.checked = true;
        infoChecks.forEach((c) => (c.checked = false));
        catAll.checked = true;
        catChecks.forEach((c) => (c.checked = false));
        perPageInput.value = perPage;
        applyFilters();
    }
    function resetAll() {
        searchKey = "";
        categories.clear();
        sortKey = "updated";
        displayFields = new Set(["all"]);
        currentPage = 1;
        perPage = 4;

        searchInput.value = "";
        MaxPrice = 2000000;
        priceInput.value = MaxPrice;
        priceValue.textContent = new Intl.NumberFormat("vi-VN").format(MaxPrice) + " ₫";
        infoAll.checked = true;
        infoChecks.forEach((c) => (c.checked = false));
        catAll.checked = true;
        catChecks.forEach((c) => (c.checked = false));
        perPageInput.value = perPage;
        sortBtns.forEach((b) => b.classList.toggle("active", b.dataset.sort === "updated"));

        applyFilters();
    }
    applyFilters();
// ===== END =====
});


