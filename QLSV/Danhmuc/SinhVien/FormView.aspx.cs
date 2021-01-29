using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SVModel;
using SVModel.DAO;

namespace QLSV.Danhmuc.SinhVien
{
    public partial class FormView : System.Web.UI.Page
    {

        public tbl_sinhvien tbl_Sinhviens = new tbl_sinhvien();
        public List<tbl_chuyennganhEntity> tbl_Chuyennganhs = new List<tbl_chuyennganhEntity>();
        public string doAction = "";
        public int itemID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            BaiTH5Entities dbcontext = new BaiTH5Entities();
            SinhvienDAO sinhvienDAO = new SinhvienDAO(dbcontext);
            doAction = !string.IsNullOrEmpty(Request["do"]) ? Request["do"].ToString() : "";
            itemID = Convert.ToInt32(Request["itemid"]);
            if (itemID != 0)
            {
                tbl_Sinhviens = sinhvienDAO.getbyId(itemID);
            }
        }

    }
}