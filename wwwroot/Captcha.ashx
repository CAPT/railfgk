<%@ WebHandler Language="C#" Class="Handler" %>

using System; 
using System.Web; 
using System.Web.SessionState; 
using System.Drawing; 
using System.Drawing.Imaging; 

public class Handler : IHttpHandler,IRequiresSessionState 
{ 
    public void ProcessRequest(HttpContext context) 
    { 
        using (Bitmap b = new Bitmap(100, 25)) 
        { 
            Font f = new Font("Arial", 14F); 
            Graphics g = Graphics.FromImage(b); 
            SolidBrush whiteBrush = new SolidBrush(Color.LightGray); 
            SolidBrush blackBrush = new SolidBrush(Color.DarkRed); 
            RectangleF canvas = new RectangleF(0, 0, 100, 25); 
                      g.FillRectangle(whiteBrush, canvas);            
            context.Session["Captcha"] = GetRandomString(); 
            g.DrawString(context.Session["Captcha"].ToString(), f, blackBrush, canvas); 
            context.Response.ContentType = "image/gif"; 
            b.Save(context.Response.OutputStream, ImageFormat.Gif); 
        } 
    } 
    
    public bool IsReusable 
    { 
        get 
        { 
            return false; 
        } 
    } 
    
    private string GetRandomString() 
    { 
        string []arrStr = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,Y,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,gj,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0".Split(",".ToCharArray()); 
        string strDraw = string.Empty; 
        Random r = new Random();         
         for(int i = 0; i < 5 ; i++) 
         { 
              strDraw += arrStr[r.Next(0,arrStr.Length-1)]; 
         }        
        return strDraw; 
    } 
} 