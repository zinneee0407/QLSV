using Newtonsoft.Json;
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
    public partial class GridInfo : System.Web.UI.Page
    {
        string doAction = "";
        int itemID = 0;
        int page = 1;
        BaiTH5Entities db;
        SinhvienDAO sinhvienDAO;
        protected void Page_Load(object sender, EventArgs e)
        {
            db = new BaiTH5Entities();
            doAction = string.IsNullOrEmpty(Request["do"]) ? "" : Request["do"].ToLower();
            itemID = Convert.ToInt32(Request["itemid"]);
            page = Convert.ToInt32(Request["page"]);
            sinhvienDAO = new SinhvienDAO(db);

            switch (doAction)
            {
                case "loaddata":
                    LoadData();
                    break;
                case "search":
                    Search();
                    break;
                default:
                    break;
            }
        }

        private void LoadData()
        {
            List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.getPage(page, 15);

            string json = JsonConvert.SerializeObject(tbl_Sinhviens);
            Response.ContentType = "json";
            Response.Write(json);
            Response.End();
        }

        private void Search()
        {
            string valueSearch = string.IsNullOrEmpty(Request["value"]) ? "" : Request["value"].ToLower();
            string locChuyennganh = string.IsNullOrEmpty(Request["loccn"]) ? "" : Request["loccn"].ToString();
            List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.search(valueSearch, locChuyennganh, page, 15);
            string json = JsonConvert.SerializeObject(tbl_Sinhviens);
            Response.ContentType = "json";
            Response.Write(json);
            Response.End();
        }

    }
}