<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Success Page</title>
    </head>
    <header>
    </header>
    <style>
body{
     display: flex;
    background-image: url('images/wallpaper.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    justify-content: center;
    align-items: center;
    height: 100vh;
    width: 100%;
}


header {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    color: white;
    text-align: center;
    padding: 10px;
}

footer {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    color: white;
    text-align: center;
    padding: 10px;
}

span{
    color:#FF474C;
}

.content-container{
    width:420px;
    background:transparent;
    border:2px double rgba(255,255,255,0.2);
    box-shadow:0 0 10px rgba(0,0,0,0.2);
    border-radius:10px;
    color:#fff;
    padding:50px 50px;
    
}

.content-container h1, p{
    text-align:center;
}


.input-box{
    width:100%;
    height:50px;
    margin:30px 0;
}

.input-box input {
    width:100%;
    height:100%;
    background:transparent;
    border:none;
    outline:none;
    border: 2px solid rgba(255, 255, 255, 0.2);
    border-radius:40px;
    font-size:16px;
    color:#fff;
    padding:10px;
    box-sizing: border-box;
    transition: 0.3s;
}
.input-box input:hover{
    border:2px solid red;
}

.input-box input::placeholder{
    color:#fff;
}

.input-box input:focus::placeholder{
    color:red;
}

.btn{
    width:100%;
    height:45px;
    background:#fff;
    border:none;
    outline:none;
    border-radius:40px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
    cursor:pointer;
    font-size:16px;
    color:#333;
    transition:0.3s;
    margin:20px 0;
}
.btn-report{
    width:100%;
    height:45px;
    background:#fff;
    border:none;
    outline:none;
    border-radius:40px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
    cursor:pointer;
    font-size:16px;
    color:#333;
    transition:0.3s;
}

.btn:hover, .btn-report:hover{
  background-color: red;
  color: white;
}

    </style>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.setHeader("Expires", "0"); // Proxies.
            
           String currentUrl = request.getRequestURL().toString();
           session.setAttribute("previousUrl", currentUrl);
            
            if(session.getAttribute("username") == null){
                response.sendRedirect("error_session.jsp");
            }

        %>
        <div class="content-container">
            <form action="PDFServlet">
            <h1>Login Successful!</h1>
            
            <div class="welcome-message">
                <h1>Welcome!</h1>
                <h3><span style="color:#A62519 ;">User:</span> ${username}</h3>   
                <h3><span style="color:#A62519 ;">Your Role :</span>  ${role}</h3>  
            </div>
            
            <button class="btn">Generate <%= request.getSession().getAttribute("currentUser") %> Report</button>
            </form>
            <form action="Logout">
            <button class="btn-report">Logout</button>
            </form>
        </div>
            <br>
            <br>
        <footer class="footer">
        </footer>
        <script>
                        function refreshCaptcha() {
    fetch('CaptchaServlet?' + new Date().getTime())
        .then(response => response.text())
        .then(text => {
            document.getElementById('captchaText').textContent = text;
        })
        .catch(error => console.error('Failed to refresh captcha:', error));
window.location.reload();
            </script>
    </body>
</html>
