<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.LessonHierarchyDao.LessonItem" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Subject Lessons</title>
    <style>
        body { font-family: Arial, sans-serif; position: relative; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #aaa; padding: 8px; text-align: left; }
        .inactive { color: red; }
        .active { color: green; }
        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .filters {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            flex-grow: 1;
        }
        .pagination { margin-top: 10px; text-align: center; }
        .pagination form { display: inline; }
        .pagination button {
            padding: 5px 10px;
            margin-right: 5px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            cursor: pointer;
        }
        .pagination button:disabled {
            background-color: #ccc;
            cursor: default;
        }
        .settings-icon {
            position: fixed;
            bottom: 20px;
            right: 20px;
            cursor: pointer;
            font-size: 24px;
            background: white;
            padding: 5px 8px;
            border-radius: 50%;
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
            text-align: center;
            line-height: 1;
            z-index: 200;
        }
        .settings-panel {
            position: fixed;
            bottom: 60px;
            right: 20px;
            border: 2px solid black;
            border-radius: 10px;
            padding: 10px;
            background: white;
            display: none;
            z-index: 100;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        .settings-panel label {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
            gap: 8px;
        }
        .settings-panel input[type="checkbox"] { width: 14px; height: 14px; }
        .settings-panel input[type="number"] { width: 50px; }
    </style>
</head>
<body>

<h2>Subject Lessons</h2>
<p>Subject name: <<%= request.getAttribute("subjectName") != null ? request.getAttribute("subjectName") : "Name of Subject" %>></p>

<%
    List<String> lessonGroups = (List<String>) request.getAttribute("lessonGroups");
    List<LessonItem> lessons = (List<LessonItem>) request.getAttribute("lessonList");
    int subjectId = (int) request.getAttribute("subjectId");

    String selectedGroup = request.getParameter("lessonGroup") != null ? request.getParameter("lessonGroup") : "all";
    String statusFilter = request.getParameter("statusFilter") != null ? request.getParameter("statusFilter") : "all";
    String search = request.getParameter("search") != null ? request.getParameter("search") : "";
    int rowsPerPage = 10;
    int currentPage = 1;

    try { rowsPerPage = Integer.parseInt(request.getParameter("rowsPerPage")); } catch (Exception ignored) {}
    try { currentPage = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}

    boolean showLesson = true;
    boolean showStatus = true;
    boolean showAction = true;
    boolean showOrder = true;
    boolean showType = true;

    int totalItems = lessons != null ? lessons.size() : 0;
    int totalPages = (int) Math.ceil((double) totalItems / rowsPerPage);
    int start = (currentPage - 1) * rowsPerPage;
    int end = Math.min(start + rowsPerPage, totalItems);
%>

<div class="top-actions">
    <form class="filters" method="get" action="LessonListServlet">
        <select name="lessonGroup" onchange="this.form.submit()">
            <option value="all" <%= "all".equals(selectedGroup) ? "selected" : "" %>>All lesson groups</option>
            <%
                if (lessonGroups != null) {
                    for (String group : lessonGroups) {
            %>
            <option value="<%= group %>" <%= group.equals(selectedGroup) ? "selected" : "" %>><%= group %></option>
            <%
                    }
                }
            %>
        </select>

        <select name="statusFilter" onchange="this.form.submit()">
            <option value="all" <%= "all".equals(statusFilter) ? "selected" : "" %>>All statuses</option>
            <option value="active" <%= "active".equals(statusFilter) ? "selected" : "" %>>Active</option>
            <option value="inactive" <%= "inactive".equals(statusFilter) ? "selected" : "" %>>Inactive</option>
        </select>

        <input type="text" name="search" placeholder="Type lesson name to search" value="<%= search %>" />
        <input type="hidden" name="subjectId" value="<%= subjectId %>" />
        <input type="hidden" name="page" value="1" />
        <input type="hidden" name="rowsPerPage" value="<%= rowsPerPage %>" />
        <input type="hidden" name="showLesson" value="true"/>
        <input type="hidden" name="showStatus" value="true"/>
        <input type="hidden" name="showAction" value="true"/>
        <input type="hidden" name="showOrder" value="true"/>
        <input type="hidden" name="showType" value="true"/>
        <button type="submit">🔍</button>
    </form>

    <div style="margin-left: 10px;">
        <button onclick="openLessonForm()">➕ Add Lesson</button>
    </div>
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
    <tbody>
    <%
        if (lessons != null && !lessons.isEmpty()) {
            for (int i = start; i < end; i++) {
                LessonItem item = lessons.get(i);
    %>
        <tr>
            <td><%= item.getId() %></td>
            <td><%= item.getName() %></td>
            <td><%= item.getOrder() %></td>
            <td><%= item.getType() %></td>
            <td><%= item.isStatus() ? "Active" : "Inactive" %></td>
            <td>
                <a href="EditLessonServlet?id=<%= item.getId() %>&type=<%= item.getType().toLowerCase() %>&subjectId=<%= subjectId %>">Edit</a> |
                <a href="ToggleLessonStatusServlet?id=<%= item.getId() %>&subjectId=<%= subjectId %>&status=<%= item.isStatus() ? 0 : 1 %>&page=<%= currentPage %>" class="<%= item.isStatus() ? "inactive" : "active" %>">
                    <%= item.isStatus() ? "Inactive" : "Activate" %>
                </a>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="6">No lessons found.</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Pagination -->
<div class="pagination">
    <% for (int i = 1; i <= totalPages; i++) { %>
        <form method="get" action="LessonListServlet">
            <input type="hidden" name="page" value="<%= i %>"/>
            <input type="hidden" name="rowsPerPage" value="<%= rowsPerPage %>"/>
            <input type="hidden" name="subjectId" value="<%= subjectId %>"/>
            <input type="hidden" name="lessonGroup" value="<%= selectedGroup %>"/>
            <input type="hidden" name="statusFilter" value="<%= statusFilter %>"/>
            <input type="hidden" name="search" value="<%= search %>"/>
            <input type="hidden" name="showLesson" value="true"/>
            <input type="hidden" name="showStatus" value="true"/>
            <input type="hidden" name="showAction" value="true"/>
            <input type="hidden" name="showOrder" value="true"/>
            <input type="hidden" name="showType" value="true"/>
            <button type="submit" <%= i == currentPage ? "disabled" : "" %>><%= i %></button>
        </form>
    <% } %>
</div>

<!-- Settings Panel -->
<div class="settings-panel" id="settingsPanel">
    <form method="get" action="LessonListServlet">
        <strong>Col</strong><br/>
        <label><input type="checkbox" checked disabled> ID</label>
        <label><input type="checkbox" name="showLesson" value="true" checked> Lesson</label>
        <label><input type="checkbox" name="showOrder" value="true" checked> Order</label>
        <label><input type="checkbox" name="showType" value="true" checked> Type</label>
        <label><input type="checkbox" name="showStatus" value="true" checked> Status</label>
        <label><input type="checkbox" name="showAction" value="true" checked> Action</label>
        <br/>
        <strong>Row</strong><br/>
        <input type="number" name="rowsPerPage" min="1" max="100" value="<%= rowsPerPage %>"/>
        <input type="hidden" name="subjectId" value="<%= subjectId %>"/>
        <input type="hidden" name="lessonGroup" value="<%= selectedGroup %>"/>
        <input type="hidden" name="statusFilter" value="<%= statusFilter %>"/>
        <input type="hidden" name="search" value="<%= search %>"/>
        <input type="hidden" name="page" value="1"/>
        <br/><br/>
        <button type="submit">Apply</button>
    </form>
</div>

<div class="settings-icon" onclick="toggleSettings()">⚙️</div>

<script>
    function toggleSettings() {
        const panel = document.getElementById("settingsPanel");
        panel.style.display = panel.style.display === "block" ? "none" : "block";
    }

    document.addEventListener("click", function(event) {
        const panel = document.getElementById("settingsPanel");
        const icon = document.querySelector(".settings-icon");
        if (!panel.contains(event.target) && !icon.contains(event.target)) {
            panel.style.display = "none";
        }
    });

    function openLessonForm() {
        window.location.href = "AddLessonServlet?subjectId=<%= subjectId %>";
    }
</script>

</body>
</html>