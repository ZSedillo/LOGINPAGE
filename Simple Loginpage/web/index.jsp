<%@ page import="controller.CaptchaServlet" %>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    String captcha = (String) session.getAttribute("captchaGenerated");
    captcha = CaptchaServlet.generateCaptcha(6); 
    session.setAttribute("captchaGenerated", captcha);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet"   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script>

            function refreshCaptcha() {
                fetch('CaptchaServlet?' + new Date().getTime())
                        .then(response => response.text())
                        .then(text => {
                            document.getElementById('captchaText').textContent = text;
                    
            
                        })
                        .catch(error => console.error('Failed to refresh captcha:', error));
                window.location.reload();
                                
            }
            
                    

        </script>
    </head>
    <style>
        body {
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

        .login-container {
            width: 420px;
            background: rgba(0, 0, 0, 0.6); /* semi-transparent background */
            border: 2px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            color: #fff;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .login-container h1 {
            margin-bottom: 20px;
        }

        .input-box {
            width: 100%;
            margin: 10px 0;
        }

        .input-box input {
            width: 100%;
            height: 40px;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.5);
            border-radius: 20px;
            font-size: 16px;
            color: #fff;
            padding: 0 15px;
        }

        .input-box input:hover, .input-box input:focus {
            border-color: red;
        }

        .input-box input::placeholder {
            color: #ddd;
        }

        .input-box-captcha {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }

        .captchaGenerated {
            padding: 10px 15px;
            background-image: url("images/captcha-bg.png");
            border-radius: 10px;
            margin-right: 10px;
            display: inline-block;
            font-size: 24px;
            color: darkgrey; /* Change text color to dark grey */
            user-select: none; /* Prevents text from being selectable */
        }


        .refresh-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 20px;
            border-radius: 10px;
        }

        .btn {
            width: 100%;
            height: 45px;
            background: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            color: #333;
            margin-top: 10px;
        }
    </style>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            session.removeAttribute("username");
            session.setAttribute("isLogin", false);

//            String prevUrl = (String) session.getAttribute("previousUrl");
//            if (prevUrl != null) {
//                session.removeAttribute("previousUrl");
//                response.sendRedirect(prevUrl);
//                return;
//            }
        %>
        <header>
            <h2>${initParam.Subject} / ${initParam.Section} / ${initParam.GroupMembers}</h2>
        </header>
        <div class="login-container">
            <form action="LoginServlet" method="POST">
                <h1>Login</h1>
                <div class="input-box">
                    <input type="text" name="username" placeholder="Username" value="<%= (String) session.getAttribute("usernamePrev") != null ? (String) session.getAttribute("usernamePrev") : ""%>">
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password" value="<%= (String) session.getAttribute("passwordPrev") != null ? (String) session.getAttribute("passwordPrev") : ""%>">
                </div>
                <div class="input-box-captcha">
                    <div class="captchaGenerated" onselectstart="return false" ondragstart="return false"><%= request.getSession().getAttribute("captchaGenerated")%></div>
                    <input type="text" name="captcha" placeholder="Input Captcha">
                </div>

                <button type="submit" class="btn">Login</button>
            </form>
            <button class="refresh-btn" onclick="refreshCaptcha()"><i class="fa fa-refresh"></i></button>
        </div>
        <footer>
            <h2><%= getServletContext().getAttribute("time")%> | ${initParam.MP}</h2>
        </footer>
    </body>
</html>