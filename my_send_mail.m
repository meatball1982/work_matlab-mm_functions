function []=my_send_mail(mail_tit,mail_con) 
mail = 'lyan09265@gmail.com'; 
password = 'Liyan09265'; 
setpref('Internet','E_mail',mail); 
setpref('Internet','SMTP_Server','smtp.gmail.com'); 
setpref('Internet','SMTP_Username',mail); 
setpref('Internet','SMTP_Password',password); 
props = java.lang.System.getProperties; 
props.setProperty('mail.smtp.auth','true'); 
props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory'); 
props.setProperty('mail.smtp.socketFactory.port','465'); 
% sendmail('meatball1982@163.com','The pro has been done','The por has been done.') 
% sendmail('lyan09265@gmail.com','The pro has been done','The por has been done.') 

sendmail('meatball1982@163.com',mail_tit,mail_con)
