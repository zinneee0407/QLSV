using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLSV.Share
{
    public class CatChuoi
    {
        public string getName(string temp)
        {
            return temp.Remove(0, 3);
        }
    }
}