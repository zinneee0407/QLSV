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
    public partial class DetailForm : System.Web.UI.Page
    {
        public tbl_sinhvien tbl_Sinhviens = new tbl_sinhvien();
        public List<tbl_chuyennganhEntity> tbl_Chuyennganhs = new List<tbl_chuyennganhEntity>();
        public string doAction = "";
        public int itemID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            BaiTH5Entities dbcontext = new BaiTH5Entities();
            SinhvienDAO sinhvienDAO = new SinhvienDAO(dbcontext);
            ChuyennganhDAO chuyennganhDAO = new ChuyennganhDAO(dbcontext);
            doAction = !string.IsNullOrEmpty(Request["do"]) ? Request["do"].ToString() : "";
            itemID = Convert.ToInt32(Request["itemid"]);
            if (itemID != 0)
            {
                tbl_Sinhviens = sinhvienDAO.getbyId(itemID);
            }
            tbl_Chuyennganhs.AddRange(chuyennganhDAO.getALL());
        }
    }
}