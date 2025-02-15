<%-- 
    Document   : search
    Created on : 24-Jan-2023, 1:11:37 pm
    Author     : RISHAV DUTTA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.exavalu.services.RoleService"%>
<%@page import="com.exavalu.services.DepartmentService"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Search</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/menu_css.css" rel="stylesheet">
        <link href="css/product.css" rel="stylesheet">
        <link rel="stylesheet" href="css/search_css.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css"/>
        <style>
            #example_wrapper{
                width: 75%;
                display: block;
                margin: auto;
            }
        </style>
    </head>
    <body>
        <script>
            // Get the form and submit button elements
            var form = document.getElementById("search_form");
            var submitBtn = document.getElementById("submitBtn");
            var responseDiv = document.getElementById("responseDiv");

            // Add a click event listener to the submit button
            submitBtn.addEventListener("click", function (event) {
                document.getElementById("form_body").style.display = 'none';
                // Prevent the default form submission behavior
                event.preventDefault();

                // Create a new XMLHttpRequest object
                var xhr = new XMLHttpRequest();

                // Set the request method and URL
                xhr.open("POST", "SearchEmployee", true);

                // Set the request headers (if needed)
//                xhr.setRequestHeader("Content-Type", "application/json");

                // Set the callback function to handle the response
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // Do something with the response (if needed)
                        console.log(xhr.responseText);
                        responseDiv.innerHTML = xhr.responseText;
//                        document.body.innerHTML = xhr.responseText;
                    }
                };

                // Get the form data and send the request
                var formData = new FormData(form);
                xhr.send(formData);
            });
        </script>
        <div id="form_body">
            <jsp:include page="menu.jsp"></jsp:include>
                <h1>Search Employee</h1>
                <form action="SearchEmployee" method="post" class="form_style" id="search_form">
                    <div class="filed_style">
                        <label for="floatingInput">First Name</label>
                        <input type="text" class="" id="floatingInput" placeholder="Search FirstName wise" name="firstName">

                    </div>
                    <div class="filed_style">
                        <label for="floatingInput">Last Name</label>
                        <input type="text" class="" id="floatingInput" placeholder="Search LastName wise" name="lastName" value="">
                    </div>
                    <div class="filed_style">
                        <label for="floatingInput">Gender</label>
                        <input type="text" class="" id="floatingInput" placeholder="Search Gender wise" name="gender">
                    </div>

                    <div class="filed_style">
                        <label for="departmentId">Department</label>
                        <select name="departmentId" class="form-select" id="departmentId">
                            <option value="0">Select Department </option>
                        <c:forEach items="${DepartmentService.getAllDepartment()}" var="dept">   
                            <option value="${dept.getDepartmentId()}" > <c:out value="${dept.getDepartmentName()}"/> </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filed_style">
                    <label for="floatingInput">Role</label>
                    <select name="roleId" class="form-select" id="roleId">
                        <option value="0">Select Role </option>
                        <c:forEach items="${RoleService.getAllRole()}" var="role">   
                            <option value="${role.getRoleId()}" > <c:out value="${role.getRoleName()}"/>  </option>
                        </c:forEach>
                    </select>
                </div>
                <button class="filed_style" type="submit" id="submitBtn" >Search</button>
            </form>



            <c:set var="empList" value="${ShowEmpList}" />
            <c:if test="${empList!=null}">
                <table id="example" class="table table-striped border">
                    <thead>
                        <tr class="backgroud_colorha">
                            <th>
                                Employee Id
                            </th>
                            <th>
                                First Name
                            </th>
                            <th>
                                Last Name
                            </th>
                            <th>
                                Phone Number
                            </th>
                            <th>
                                Gender
                            </th>
                            <th>
                                Age
                            </th>
                            <th>
                                Department Name
                            </th>
                            <th>
                                Role Name
                            </th>
                            <th>
                                Basic Salary
                            </th>
                            <th>
                                Special Allowance
                            </th>
                            <th>
                                Car Allowance
                            </th>
                            <th>
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${ShowEmpList}" var="emp">
                            <tr>
                                <td>
                                    <c:out value="${emp.getId()}"/>
                                </td>
                                <th scope="row">
                                    <c:out value="${emp.getFirstName()}"/>
                                </th>
                                <th scope="row">
                                    <c:out value="${emp.getLastName()}"/>
                                </th>
                                <td>
                                    <c:out value="${emp.getPhoneNumber()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getGender()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getAge()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getDeptName()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getRoleName()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getBasicSalary()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getSpecialAllowance()}"/>
                                </td>
                                <td>
                                    <c:out value="${emp.getCarAllowance()}"/>
                                </td>
                                <td> 
                                    <a href=EditEmployee?id=${emp.getId()}>
                                        Edit</a>                     
                                </td>
                            </tr>

                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <div id="responseDiv">

        </div>

    </body>
</html>
