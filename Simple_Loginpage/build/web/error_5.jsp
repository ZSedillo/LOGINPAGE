<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <header>
    </header>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <link href="errorStyles.css" rel="stylesheet" type="text/css"/>
    </head>
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

h2{
    margin:20px auto;
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
}

.btn:hover {
  background-color: red;
  color: white;
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
    </style>
    <body>
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setHeader("Expires","0"); //Proxies           
        %>
        <div class="content-container">
            <form action="Return">
                <h1>Login Not Successful!</h1>
                <h2 style="padding-left:30px;">Username is blank please try again!</h2>   
                 <button class="btn">Return</button>
            </form>
        </div>
        <footer class="footer">
        </footer>
    </body>
</html>