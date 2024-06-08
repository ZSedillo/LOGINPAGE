<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<html  xmlns="http://www.w3.org/1999/xhtml">
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
        <div class="content-container">
            <form action="Return">
                <h1>Error 404!</h1>
                <h2 style="padding-left:110px;">Invalid Path Name</h2>   
            </form>
        </div>
    </body>
</html>
