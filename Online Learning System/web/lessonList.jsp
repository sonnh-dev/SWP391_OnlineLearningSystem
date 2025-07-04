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
        .pagination { margin-top: 10px; }
        .pagination form { display: inline; }
        .pagination button { padding: 5px 10px; margin-right: 5px; }

        .settings-icon {
            position: fixed;
            bottom: 20px;
            right: 20px;
            cursor: pointer;
            width: 24px;
            height: 24px;
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

        .settings-panel input[type="checkbox"] {
            width: 14px;
            height: 14px;
        }

        .settings-panel input[type="number"] {
            width: 50px;
        }
    </style>
</head>
<body>

<h2>Subject Lessons</h2>
<p>Subject name: &lt;<%= request.getAttribute("subjectName") != null ? request.getAttribute("subjectName") : "Name of Subject" %>&gt;</p>

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

    boolean showLesson = request.getParameter("showLesson") == null || "true".equals(request.getParameter("showLesson"));
    boolean showStatus = request.getParameter("showStatus") == null || "true".equals(request.getParameter("showStatus"));
    boolean showAction = request.getParameter("showAction") == null || "true".equals(request.getParameter("showAction"));
    boolean showOrder = request.getParameter("showOrder") != null;
    boolean showType = request.getParameter("showType") != null;

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
        <% if (showLesson) { %><input type="hidden" name="showLesson" value="true"/><% } %>
        <% if (showStatus) { %><input type="hidden" name="showStatus" value="true"/><% } %>
        <% if (showAction) { %><input type="hidden" name="showAction" value="true"/><% } %>
        <% if (showOrder) { %><input type="hidden" name="showOrder" value="true"/><% } %>
        <% if (showType) { %><input type="hidden" name="showType" value="true"/><% } %>
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
        <% if (showLesson) { %><th>Lesson</th><% } %>
        <% if (showOrder) { %><th>Order</th><% } %>
        <% if (showType) { %><th>Type</th><% } %>
        <% if (showStatus) { %><th>Status</th><% } %>
        <% if (showAction) { %><th>Action</th><% } %>
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
            <% if (showLesson) { %><td><%= item.getName() %></td><% } %>
            <% if (showOrder) { %><td><%= item.getOrder() %></td><% } %>
            <% if (showType) { %><td><%= item.getType() %></td><% } %>
            <% if (showStatus) { %><td><%= item.isStatus() ? "Active" : "Inactive" %></td><% } %>
            <% if (showAction) { %>
            <td>
                <a href="EditLessonServlet?id=<%= item.getId() %>">Edit</a>
                <a href="ToggleLessonStatusServlet?id=<%= item.getId() %>&subjectId=<%= subjectId %>&page=<%= currentPage %>" class="<%= item.isStatus() ? "inactive" : "" %>">
                    <%= item.isStatus() ? "Inactive" : "Activate" %>
                </a>
            </td>
            <% } %>
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

<div class="pagination">
    <% for (int i = 1; i <= totalPages; i++) { %>
        <form method="get" action="LessonListServlet">
            <input type="hidden" name="page" value="<%= i %>"/>
            <input type="hidden" name="subjectId" value="<%= subjectId %>"/>
            <input type="hidden" name="statusFilter" value="<%= statusFilter %>"/>
            <input type="hidden" name="lessonGroup" value="<%= selectedGroup %>"/>
            <input type="hidden" name="search" value="<%= search %>"/>
            <input type="hidden" name="rowsPerPage" value="<%= rowsPerPage %>"/>
            <% if (showLesson) { %><input type="hidden" name="showLesson" value="true"/><% } %>
            <% if (showStatus) { %><input type="hidden" name="showStatus" value="true"/><% } %>
            <% if (showAction) { %><input type="hidden" name="showAction" value="true"/><% } %>
            <% if (showOrder) { %><input type="hidden" name="showOrder" value="true"/><% } %>
            <% if (showType) { %><input type="hidden" name="showType" value="true"/><% } %>
            <button type="submit"><%= i %></button>
        </form>
    <% } %>
</div>

<div class="settings-panel" id="settingsPanel">
    <form method="get" action="LessonListServlet">
        <strong>Col</strong><br/>
        <label><input type="checkbox" checked disabled> ID</label>
        <label><input type="checkbox" name="showLesson" value="true" <%= showLesson ? "checked" : "" %>> Lesson</label>
        <label><input type="checkbox" name="showOrder" value="true" <%= showOrder ? "checked" : "" %>> Order</label>
        <label><input type="checkbox" name="showType" value="true" <%= showType ? "checked" : "" %>> Type</label>
        <label><input type="checkbox" name="showStatus" value="true" <%= showStatus ? "checked" : "" %>> Status</label>
        <label><input type="checkbox" name="showAction" value="true" <%= showAction ? "checked" : "" %>> Action</label>
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

<img src="gear-icon.png" class="settings-icon" onclick="toggleSettings()" alt="Settings"/>

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
        alert("TODO: Show add lesson form here.");
    }
</script>

</body>
</html>
