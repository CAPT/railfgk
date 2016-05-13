<%@ WebHandler Language="C#" Class="CaptchaHandler1" %>

using System; 
using System.Web; 
using System.Web.SessionState; 
using System.Drawing; 
using System.Drawing.Imaging; 
using System.IO;
using System.Text;
using System.Drawing.Drawing2D;
using System.Security.Cryptography;
using uCaptcha.Web;

public class CaptchaHandler1 : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
          
        
   context.Response.ContentType = "text/plain";

   if (HttpContext.Current.Session["Captcha"].ToString() == HttpContext.Current.Request.QueryString[0]) 
 {
     context.Response.Write(1);
 }
 else
 {
     context.Response.Write(0);
 }
   
               
       
        
        //context.Response.Write(rv);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}