<%@ WebHandler Language="C#" Class="Captcha" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Security.Cryptography;
using System.Web.SessionState;
using uCaptcha.Web;

public class Captcha : IRequiresSessionState, IHttpHandler
{
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public void ProcessRequest(HttpContext context)
    {
        Handler handler = new Handler();

        handler.GenerateCaptcha(context);
    }
}