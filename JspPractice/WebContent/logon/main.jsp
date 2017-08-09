<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page import="java.net.*"%>
 <html xmlns="http://www.w3.org/1999/xhtml">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
 
 <title>메인</title>
 <link href="css/style.css" rel="stylesheet" type="text/css">
  </head>
 <body onLoad="focusIt();">
    <%
    try{
    if(session.getAttribute("memId")==null){
    %>
    <script type="text/javascript">
       function focusIt() {
          document.inform.id.focus();
       }
       
       function checkIt() {
          inputForm = eval("document.inform");
          if (!inputForm.id.value) {
             alert("아이디를 입력하세요..");
             inputForm.id.focus();
             return false;
          }
          if (!inputForm.passwd.value) {
             alert("아이디를 입력하세요..");
             inputForm.passwd.focus();
             return false;
          }
       }
    </script>
    
    <div id="LoginWrap">
       <h1>Member Login</h1>
       <form name="inform" method="post" action="loginPro.jsp"
          onSubmit="return checkIt();">
          <fieldset>
             <legend>로그인</legend>
             <dl>
             <%
             Cookie[] cookie = request.getCookies();
             String id = "";
             if(cookie!=null){
                for(Cookie cookies : cookie){
                   if(cookies.getName().equals("id"))
                      id = cookies.getValue();
                   }
             }
             %>
             <dt>Id</dt>
                <dd>
                   <input type="text" name="id" maxlength="10" value="<%=id %>" />
                </dd>
                <dt>Password</dt>
                <dd>
                   <input type="password" name="passwd" maxlength="10" />
                </dd>
             </dl>
             <div class="btnArea">
                <input type ="submit" name="Submit" value="Ok" />
                <input type ="button" value = "Join" onclick="javascript:window.location='inputForm.jsp'" />
                <input type ="button" value = "Find id" onclick="javascript:window.location='findIdForm.jsp'" />
                <input type ="button" value = "Find pw" onclick="javascript:window.location='findPwForm.jsp'" />
                <input type ="button" value = "MemberList" onclick="javascript:window.location='list.jsp'" /> 
             </div>
          </fieldset>
       </form>
    </div>
    <%}else{%>
    <!-- after login -->
    <div id="LoginWrap">
       <h1>Hello World!</h1>
       <div class="afterLogin">
          <p>
             <strong><%=session.getAttribute("memId") %></strong>님 환영합니다.
          </p>
       <form action="logout.jsp" method="post">
             <div class="btnArea">
                <input type ="submit" name = "Submit" value="Logout" />
                <input type ="button" value = "Modify" onclick="javascript:window.location='modifyForm.jsp'" />
                <input type ="button" value = "MemberList" onclick="javascript:window.location='list.jsp'" /> 
             </div>
          </form>
          
          <a href="../board/list.jsp" >게시판</a>
          <a href="../JspPracProject3/list.jsp">방명록</a>
    </div>
    <% }
    } catch(NullPointerException e) {}%>
  </body>
  </html>