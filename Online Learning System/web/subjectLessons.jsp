<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Subject Lessons</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: blue;
            cursor: pointer;
        }
        .filter-bar {
            margin-bottom: 10px;
        }
        .filter-bar input[type="text"] {
            padding: 5px;
            width: 200px;
        }
        .filter-bar select {
            padding: 5px;
        }
        .add-lesson {
            float: right;
            margin-left: 20px;
        }
    </style>
</head>
<body>

<h2>Subject Lessons</h2>

<div class="filter-bar">
    Subject name: &lt;&lt;Name of Subject&gt;&gt;
    <select id="lessonGroupFilter" onchange="renderTable()">
        <option value="All">All lesson groups</option>
    </select>

    <select id="statusFilter" onchange="renderTable()">
        <option value="All">All statuses</option>
        <option value="Active">Active</option>
        <option value="Inactive">Inactive</option>
    </select>

    <input type="text" id="searchInput" placeholder="Type lesson name to search" />
    <button onclick="renderTable()">🔍</button>

    <a class="add-lesson" href="#">Add Lesson</a>
</div>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Lesson</th>
        <th>Order</th>
        <th>Type</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody id="lessonTableBody">
        <tr><td colspan="6">Loading...</td></tr>
    </tbody>
</table>

<script>
let globalData = [];

function loadData() {
    fetch("<%=request.getContextPath()%>/lessonhierarchy?courseId=1")
        .then(response => response.json())
        .then(data => {
            globalData = data;
            populateLessonGroups(data);
            renderTable();
        })
        .catch(error => {
            console.error("Error loading data:", error);
            document.getElementById("lessonTableBody").innerHTML =
                "<tr><td colspan='6'>Failed to load data</td></tr>";
        });
}

function populateLessonGroups(data) {
    const groupSelect = document.getElementById("lessonGroupFilter");
    groupSelect.innerHTML = `<option value="All">All lesson groups</option>`;
    data.forEach(chapter => {
        groupSelect.innerHTML += `<option value="${chapter.id}">${chapter.title}</option>`;
    });
}

function renderTable() {
    const statusFilter = document.getElementById("statusFilter").value;
    const groupFilter = document.getElementById("lessonGroupFilter").value;
    const searchText = document.getElementById("searchInput").value.toLowerCase();
    const tableBody = document.getElementById("lessonTableBody");

    tableBody.innerHTML = "";
    let rowId = 1;

    globalData.forEach(chapter => {
        const isMatchChapter = (groupFilter === "All" || String(chapter.id) === groupFilter);
        if (!isMatchChapter) return;

        tableBody.innerHTML += `
            <tr>
                <td>${rowId++}</td>
                <td>${chapter.title}</td>
                <td>${chapter.order}</td>
                <td>Subject Topic</td>
                <td>Active</td>
                <td><a href="#">Edit</a> | <a href="javascript:void(0)">Inactivate</a></td>
            </tr>
        `;

        chapter.lessons.forEach(lesson => {
            const lessonStatus = lesson.status === 1 ? 'Active' : 'Inactive';
            const lessonTitle = lesson.title.toLowerCase();
            const matchLesson = (statusFilter === 'All' || statusFilter === lessonStatus) &&
                                (searchText === "" || lessonTitle.includes(searchText));

            if (matchLesson) {
                const lessonAction = lessonStatus === 'Active' ? 'Inactivate' : 'Activate';
                tableBody.innerHTML += `
                    <tr>
                        <td>${rowId++}</td>
                        <td>&nbsp;&nbsp;-- ${lesson.title}</td>
                        <td>${lesson.order}</td>
                        <td>Lesson</td>
                        <td>${lessonStatus}</td>
                        <td><a href="#">Edit</a> | 
                            <a href="javascript:void(0)" onclick="toggleStatus('lesson', ${lesson.id}, '${lessonStatus}')">${lessonAction}</a>
                        </td>
                    </tr>
                `;
            }

            lesson.quizzes.forEach(quiz => {
                const quizStatus = quiz.status === 1 ? 'Active' : 'Inactive';
                const quizName = quiz.name.toLowerCase();
                const matchQuiz = (statusFilter === 'All' || statusFilter === quizStatus) &&
                                  (searchText === "" || quizName.includes(searchText));

                if (matchQuiz) {
                    const quizAction = quizStatus === 'Active' ? 'Inactivate' : 'Activate';
                    tableBody.innerHTML += `
                        <tr>
                            <td>${rowId++}</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;-- ${quiz.name}</td>
                            <td>${quiz.order}</td>
                            <td>Quiz</td>
                            <td>${quizStatus}</td>
                            <td><a href="#">Edit</a> | 
                                <a href="javascript:void(0)" onclick="toggleStatus('quiz', ${quiz.id}, '${quizStatus}')">${quizAction}</a>
                            </td>
                        </tr>
                    `;
                }
            });
        });
    });

    if (tableBody.innerHTML.trim() === "") {
        tableBody.innerHTML = "<tr><td colspan='6'>No data found</td></tr>";
    }
}

function toggleStatus(type, id, currentStatus) {
    const newStatus = currentStatus === 'Active' ? 'Inactive' : 'Active';

    fetch("<%=request.getContextPath()%>/toggleLessonStatus", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            type: type,
            id: id,
            status: newStatus
        })
    })
    .then(response => {
        if (!response.ok) throw new Error("Failed to toggle status");
        return response.text();
    })
    .then(result => {
        console.log("Status update:", result);
        loadData();
    })
    .catch(error => {
        alert("Error updating status: " + error.message);
    });
}

document.addEventListener("DOMContentLoaded", () => {
    loadData();
    document.getElementById("searchInput").addEventListener("keydown", function(event) {
        if (event.key === "Enter") {
            event.preventDefault();
            renderTable();
        }
    });
});
</script>

</body>
</html>
