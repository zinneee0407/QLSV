using SVModel;
using SVModel.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLSV.Danhmuc.SinhVien
{
    public partial class MainForm1 : System.Web.UI.Page
    {
        public List<tbl_chuyennganhEntity> tbl_Chuyennganhs = new List<tbl_chuyennganhEntity>();
        public string doAction = "";
        public int itemID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            BaiTH5Entities dbcontext = new BaiTH5Entities();
            ChuyennganhDAO chuyennganhDAO = new ChuyennganhDAO(dbcontext);
            tbl_Chuyennganhs.AddRange(chuyennganhDAO.getALL());
        }
    }
}