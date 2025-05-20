<%@ page session="false" %>

<%
    // Menghapus session pengguna dan mengarahkan ke login.jsp
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
