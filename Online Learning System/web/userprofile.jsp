<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 1px solid #aaa;
            object-fit: cover;
        }
        .profile-label {
            font-weight: bold;
            width: 140px;
        }
        .left-panel {
            border-right: 1px solid #ccc;
            text-align: center;
        }
        .right-panel {
            padding-left: 30px;
        }
        .profile-box {
            border: 1px solid #ccc;
            padding: 25px;
            border-radius: 8px;
            background-color: #fff;
        }
        .edit-link {
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="row profile-box">
            <!-- Left Column -->
            <div class="col-md-3 left-panel">
                <img src="uploads/${user.avatarUrl}" class="avatar mb-2" data-bs-toggle="modal" data-bs-target="#editAvatarModal" title="" />
                <div class="edit-link" data-bs-toggle="modal" data-bs-target="#editAvatarModal">Edit</div>
                <div class="mt-3"><strong>${user.firstName} ${user.lastName}</strong></div>
                <div class="mt-4 text-start"><strong>Uid:</strong> ${user.user_id}</div>
            </div>

            <!-- Right Column -->
            <div class="col-md-9 right-panel">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5><strong>My Profile</strong></h5>
                    <button class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal">Edit</button>
                </div>
                <hr>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Name:</div>
                    <div class="col-sm-8">${user.firstName} ${user.lastName}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Email:</div>
                    <div class="col-sm-8">${user.email}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Phone number:</div>
                    <div class="col-sm-8">${user.phoneNumber}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Date of birth:</div>
                    <div class="col-sm-8">${user.dateOfBirth}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Gender:</div>
                    <div class="col-sm-8">${user.gender}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-4 profile-label">Address:</div>
                    <div class="col-sm-8">${users.address}</div>
                </div>
                <div class="text-end mt-3">
                    <a href="change-password.jsp">Change password</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Edit Info -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <form class="modal-content" method="post" action="user" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Profile</h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body row g-3 px-4">
                    <input type="hidden" name="user_id" value="${user.user_id}"/>
                    <div class="col-md-6">
                        <label class="form-label">First Name</label>
                        <input name="first_name" class="form-control" value="${user.firstName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last Name</label>
                        <input name="last_name" class="form-control" value="${user.lastName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone Number</label>
                        <input name="phone_number" class="form-control" value="${user.phoneNumber}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Date of Birth</label>
                        <input name="date_of_birth" type="date" class="form-control" value="${user.dateOfBirth}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select">
                            <option ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                            
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Address</label>
                        <input name="address" class="form-control" value="${user.address}">
                    </div>
                    <div class="col-12">
                        <label class="form-label text-muted">Email (not editable)</label>
                        <input class="form-control" value="${user.email}" disabled>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Save Changes</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal Edit Avatar -->
    <div class="modal fade" id="editAvatarModal" tabindex="-1">
        <div class="modal-dialog">
            <form class="modal-content" method="post" action="user" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Update Avatar</h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body px-4">
                    <input type="hidden" name="user_id" value="${user.user_id}">
                    <div class="mb-3">
                        <label class="form-label">Select New Avatar</label>
                        <input type="file" name="avatar" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success">Save</button>
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
