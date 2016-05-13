using System.Collections.Generic;
using System;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Net.Mail;
using System.Net.Mime;
using System.Security.Cryptography;

namespace Unico
{

	public static class SiteUtils
	{
		public static void SendMail(string fromAddr, string fromName, Dictionary<string, string> toAddr,
			string mailSubj, string mailBody, bool htmlBody, HttpFileCollection attachedFiles = null)
		{
			try
			{
				MailMessage m = new MailMessage();
				m.BodyEncoding = Encoding.UTF8;

				if (!string.IsNullOrEmpty(fromAddr))
					m.From = new MailAddress(fromAddr, fromName);

				foreach (KeyValuePair<string, string> kvp in toAddr)
				{
					if (!string.IsNullOrEmpty(kvp.Key))
						m.To.Add(new MailAddress(kvp.Key, kvp.Value));
				}

				m.Subject = mailSubj;

				m.IsBodyHtml = htmlBody;
				m.Body = mailBody;

				if (attachedFiles != null)
				{
					foreach (string af in attachedFiles.AllKeys)
					{
						if (!string.IsNullOrEmpty(attachedFiles[af].FileName) && attachedFiles[af].ContentLength > 0)
							m.Attachments.Add(new Attachment(attachedFiles[af].InputStream, attachedFiles[af].FileName));
					}
				}

				SmtpClient smtp = new SmtpClient();
				smtp.Send(m);
			}
			catch
			{
				throw;
			}
		}

		public static void SendMail(string fromAddr, string fromName, string toAddr, string toName,
			string mailSubj, string mailBody, bool htmlBody, HttpFileCollection attachedFiles = null)
		{
			if (!string.IsNullOrEmpty(toAddr))
			{
				Dictionary<string, string> toAddrColl = new Dictionary<string, string>();

				toAddrColl.Add(toAddr, toName);
				SendMail(fromAddr, fromName, toAddrColl, mailSubj, mailBody, htmlBody, attachedFiles);
			}
		}

		public static void SendMail(string fromAddr, string fromName, Dictionary<string, string> toAddr,
			string mailSubj, string mailBody, bool htmlBody, string filePath)
		{
			if (!string.IsNullOrEmpty(filePath) && File.Exists(filePath))
			{
				try
				{
					MailMessage m = new MailMessage();
					m.BodyEncoding = Encoding.UTF8;

					if (!string.IsNullOrEmpty(fromAddr))
						m.From = new MailAddress(fromAddr, fromName);

					foreach (KeyValuePair<string, string> kvp in toAddr)
					{
						if (!string.IsNullOrEmpty(kvp.Key))
							m.To.Add(new MailAddress(kvp.Key, kvp.Value));
					}

					m.Subject = mailSubj;

					m.IsBodyHtml = htmlBody;
					m.Body = mailBody;

					MemoryStream ms = new MemoryStream(File.ReadAllBytes(filePath));
					if (ms.Length > 0)
						m.Attachments.Add(new Attachment(ms, Path.GetFileName(filePath)));

					SmtpClient smtp = new SmtpClient();
					smtp.Send(m);
				}
				catch
				{
					throw;
				}
			}
		}

		public static void SendMail(string fromAddr, string fromName, string toAddr, string toName,
			string mailSubj, string mailBody, bool htmlBody, string filePath)
		{
			if (!string.IsNullOrEmpty(toAddr))
			{
				Dictionary<string, string> toAddrColl = new Dictionary<string, string>();

				toAddrColl.Add(toAddr, toName);
				SendMail(fromAddr, fromName, toAddrColl, mailSubj, mailBody, htmlBody, filePath);
			}
		}

		public static string CreateMD5Hash(string toHash)
		{
			MD5 md5 = new MD5CryptoServiceProvider();
			byte[] input = Encoding.UTF8.GetBytes(toHash);
			byte[] output = md5.ComputeHash(input);
			StringBuilder sb = new StringBuilder();
			foreach (byte b in output)
			{
				sb.Append(b.ToString("x2"));
			}
			return sb.ToString();
		}

	    public static string SetAbsoluteImgSrc(string message)
	    {
            var matchString = Regex.Match(message, "<img.+?src=[\"'](.+?)[\"'].+?>", RegexOptions.IgnoreCase).ToString();
	        if (!string.IsNullOrEmpty(matchString))
	        {
	            var mString = matchString.Insert(matchString.IndexOf("src=\"/") + 5,
	                                             "http://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"]);
	            return Regex.Replace(message, "<img.+?src=[\"'](.+?)[\"'].+?>", mString);
	        }
	        return message;
	    }
	}

	//http://haacked.com/archive/2009/01/14/named-formats-redux.aspx
	public static class Formatter
	{

		public static string NamedFormat(this string format, object source)
		{
			if (format == null)
			{
				throw new ArgumentNullException("format");
			}

			StringBuilder result = new StringBuilder(format.Length * 2);

			using (var reader = new StringReader(format))
			{
				StringBuilder expression = new StringBuilder();
				int @char = -1;

				State state = State.OutsideExpression;
				do
				{
					switch (state)
					{
						case State.OutsideExpression:
							@char = reader.Read();
							switch (@char)
							{
								case -1:
									state = State.End;
									break;
								case '{':
									state = State.OnOpenBracket;
									break;
								case '}':
									state = State.OnCloseBracket;
									break;
								default:
									result.Append((char)@char);
									break;
							}
							break;
						case State.OnOpenBracket:
							@char = reader.Read();
							switch (@char)
							{
								case -1:
									throw new FormatException();
								case '{':
									result.Append('{');
									state = State.OutsideExpression;
									break;
								default:
									expression.Append((char)@char);
									state = State.InsideExpression;
									break;
							}
							break;
						case State.InsideExpression:
							@char = reader.Read();
							switch (@char)
							{
								case -1:
									throw new FormatException();
								case '}':
									result.Append(OutExpression(source, expression.ToString()));
									expression.Length = 0;
									state = State.OutsideExpression;
									break;
								default:
									expression.Append((char)@char);
									break;
							}
							break;
						case State.OnCloseBracket:
							@char = reader.Read();
							switch (@char)
							{
								case '}':
									result.Append('}');
									state = State.OutsideExpression;
									break;
								default:
									throw new FormatException();
							}
							break;
						default:
							throw new InvalidOperationException("Invalid state.");
					}
				} while (state != State.End);
			}

			return result.ToString();
		}

		private static string OutExpression(object source, string expression)
		{
			string format = "";

			int colonIndex = expression.IndexOf(':');
			if (colonIndex > 0)
			{
				format = expression.Substring(colonIndex + 1);
				expression = expression.Substring(0, colonIndex);
			}

			try
			{
				if (String.IsNullOrEmpty(format))
				{
					return (DataBinder.Eval(source, expression) ?? "").ToString();
				}
				return DataBinder.Eval(source, expression, "{0:" + format + "}") ?? "";
			}
			catch (HttpException)
			{
				throw new FormatException();
			}
		}

		private enum State
		{
			OutsideExpression,
			OnOpenBracket,
			InsideExpression,
			OnCloseBracket,
			End
		}
	}

	public static class Declination
	{
		public static string getCommentTxt(int number) 
		{	
			if(number == 0) return "нет комментариев";
			else if(number == 1 || (number % 10 == 1 && number != 11) ) return "комментарий";
				else if(number % 10 > 1 && number % 10 < 5 && number % 100 != 12 && number % 100 != 13 && number % 100 != 14) return "комментария";
					else return "комментариев";	
		}
		public static string getFeedbackTxt(int number) 
		{	
			if(number == 0) return "нет отзывов";
			else if(number == 1 || (number % 10 == 1 && number != 11) ) return "отзыв";
				else if(number % 10 > 1 && number % 10 < 5 && number % 100 != 12 && number % 100 != 13 && number % 100 != 14) return "отзыва";
					else return "отзывов";	
		}
	}


}