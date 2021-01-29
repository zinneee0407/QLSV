﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace TestForm
{
    class Program
    {
        static void Main(string[] args)
        {
            readHtmlPage("http://qlsv.local.simax/danhmuc/sinhvien/actionhandler.aspx");
        }

        private static String readHtmlPage(string url)
        {

            //setup some variables

            String username = "demo";
            String password = "password";
            String firstname = "John";
            String lastname = "Smith";

            //setup some variables end

            String result = "";
            String strPost = "username=" + username + "&password=" + password + "&firstname=" + firstname + "&lastname=" + lastname;
            StreamWriter myWriter = null;

            HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(url);
            objRequest.Method = "POST";
            objRequest.ContentLength = strPost.Length;
            objRequest.ContentType = "application/x-www-form-urlencoded";

            try
            {
                myWriter = new StreamWriter(objRequest.GetRequestStream());
                myWriter.Write(strPost);
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                myWriter.Close();
            }

            HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
            using (StreamReader sr =
               new StreamReader(objResponse.GetResponseStream()))
            {
                result = sr.ReadToEnd();

                // Close and clean up the StreamReader
                sr.Close();
            }
            return result;
        }
    }
}
