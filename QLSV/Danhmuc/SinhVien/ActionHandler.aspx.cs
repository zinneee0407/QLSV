using SVModel;
using SVModel.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using NPOI.XSSF.UserModel;
using Xceed.Document.NET;
using Xceed.Words.NET;
using System.Diagnostics;
using System.IO;

namespace QLSV.Danhmuc.SinhVien
{
    public partial class ActionHandler : System.Web.UI.Page
    {
        string doAction = "";
        int itemID = 0;
        int page = 1;
        BaiTH5Entities db;
        SinhvienDAO sinhvienDAO;
        PropertyInfo[] propertyInfos;
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
                    //LoadData();
                    break;
                case "edit":
                    checkFormUpdate();
                    break;
                case "add":
                    //checkFormAdd();
                    AddItem();
                    break;
                case "delete":
                    Delete();
                    break;
                case "exporttoword":
                    ExportWord();
                    break;
                case "exporttoexcel":
                    ExportToExcel();
                    break;
                case "updatetable":
                    UpdateTable();
                    break;
                case "search":
                    //Search();
                    break;
                default:
                    break;
            }

        }

        //private void LoadData()
        //{
        //    List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.getPage(page, 15);

        //    string json = JsonConvert.SerializeObject(tbl_Sinhviens);
        //    Response.ContentType = "json";
        //    Response.Write(json);
        //    Response.End();
        //}

        //private void Search()
        //{
        //    string valueSearch = string.IsNullOrEmpty(Request["value"]) ? "" : Request["value"].ToLower();
        //    string locChuyennganh = string.IsNullOrEmpty(Request["loccn"]) ? "" : Request["loccn"].ToString();
        //    List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.search(valueSearch, locChuyennganh , page, 15);
        //    string json = JsonConvert.SerializeObject(tbl_Sinhviens);
        //    Response.ContentType = "json";
        //    Response.Write(json);
        //    Response.End();
        //}

        private void AddItem()
        {
            tbl_sinhvien sv = new tbl_sinhvien();
            propertyInfos = typeof(tbl_sinhvien).GetProperties();
            int stt = 2;
            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                if (!propertyInfo.GetGetMethod().IsVirtual)
                {
                    var objRequest = Request[Request.Form.AllKeys[stt]];
                    propertyInfo.SetValue(sv, Convert.ChangeType(objRequest, propertyInfo.PropertyType), null);
                    stt++;
                }

            }
            sinhvienDAO.AddStudent(sv);
        }

        private void UpdateTable()
        {
            var errorList = new List<object>();
            string checkTenSV =  Request["txtTenSV"].ToString();
            if (string.IsNullOrEmpty(checkTenSV))
            {
                errorList.Add(new { key = "Tensv", errors = new string[] { "Tên sinh viên không hợp lệ. Cập nhật thất bại" } });
            }
            if (errorList.Count > 0)
            {
                RenderMessage(errorList);
            }
            else
            {
                tbl_sinhvien sv = sinhvienDAO.getbyId(itemID);
                sv.TenSV = checkTenSV;
                sinhvienDAO.Save();
                RenderMessage(errorList);
            }
        }


        private void Update()
        {
            tbl_sinhvien sv = sinhvienDAO.getbyId(itemID);
            PropertyInfo propertyInfo;

            int soREQUEST = Request.Form.AllKeys.Length;
            for (int i = 2; i < soREQUEST; i++)
            {
                var requestByName = Request.Form.AllKeys[i];
                var value = Request[requestByName];
                //cắt 3 ký tự đầu tiên của tên request
                string nameREQUEST = requestByName.Remove(0, 3);
                if (true)
                {
                    propertyInfo = typeof(tbl_sinhvien).GetProperty(nameREQUEST);
                    propertyInfo.SetValue(sv, Convert.ChangeType(value, propertyInfo.PropertyType), null);
                }
            }
            sinhvienDAO.Save();
        }

        private void Delete()
        {
            sinhvienDAO.DeleteItem(itemID);
        }

        // kiểm tra form 
        private bool checkFormAdd()
        {
            var errorList = new List<object>();
            bool status;
            //kiểm tra trùng trong bảng
            bool checkMasv = checkID(Convert.ToInt32(Request["txtMasv"]));
            if (!checkMasv)
            {
                if (doAction == "add")
                {
                    errorList.Add(new { key = "Masv", errors = new string[] { "Mã sinh viên đã tồn tại" } });
                }
            }
            bool check_email = checkEmail(Request["txtEmail"].ToString());
            if (!check_email)
            {
                errorList.Add(new { key = "Email", errors = new string[] { "Email đã tồn tại" } });
            }
            bool check_phone = checkPhone(Request["txtDienthoai"].ToString());
            if (!check_phone)
            {
                errorList.Add(new { key = "Dienthoai", errors = new string[] { "Số điện thoại đã tồn tại" } });
            }
            if (errorList.Count > 0)
            {
                RenderMessage(errorList);
                status = false;
            }
            else
            {
                AddItem();
                RenderMessage(errorList);
                status = true;
            }
            return status;
        }

        private bool checkFormUpdate()
        {
            var errorList = new List<object>();
            bool status;
            bool isEmailexist = checkEmail(Request["txtEmail"].ToString());

            //kiểm tra trùng trong bảng và bỏ qua khi trùng với sinh viên update
            tbl_sinhvien sv1 = sinhvienDAO.getbyId(Convert.ToInt32(Request["txtMasv"]));
            //Kiểm tra theo email
            tbl_sinhvien sv2;
            sv2 = sinhvienDAO.getbyEmail(Request["txtEmail"].ToString());
            if (!isEmailexist)
            {
                if (!sv1.Masv.Equals(sv2.Masv))
                {
                    errorList.Add(new { key = "Email", errors = new string[] { "Email đã tồn tại" } });
                }
            }
            //kiểm tra theo số điện thoại
            sv2 = sinhvienDAO.getbyPhone(Request["txtDienthoai"].ToString());
            bool isPhoneexist = checkPhone(Request["txtDienthoai"].ToString());
            if (!isPhoneexist)
            {
                if (!sv1.Masv.Equals(sv2.Masv))
                {
                    errorList.Add(new { key = "Dienthoai", errors = new string[] { "Số điện thoại đã tồn tại" } });
                }
            }
            if (errorList.Count > 0)
            {
                RenderMessage(errorList);
                status = false;
            }
            else
            {
                Update();
                RenderMessage(errorList);
                status = true;
            }
            return status;
        }


        private bool checkID(int id)
        {
            return sinhvienDAO.checkSV(id);
        }
        private bool checkEmail(string email)
        {
            return sinhvienDAO.checkSV(email);
        }
        private bool checkPhone(string phone)
        {
            return sinhvienDAO.checkSDT(phone);
        }

        private void RenderMessage<T>(T _object)
        {
            try
            {
                string json = JsonConvert.SerializeObject(_object);
                Response.ContentType = "json";
                Response.Write(json);
                this.Page.Response.End();
            }
            catch { }
        }

        //Export to word
        private void ExportWord()
        {
            string valueSearch = string.IsNullOrEmpty(Request["value"]) ? "" : Request["value"].ToLower();
            string locChuyennganh = string.IsNullOrEmpty(Request["loccn"]) ? "" : Request["loccn"].ToString();

            string fileName;
            string FileTemplate = Server.MapPath("/AppFile/Sinhvien/Word/DSSV.docx");
            string urlFileSave = Server.MapPath("/AppFile/tmp/DSSVFILE.docx");
            fileName = "DSSVFILE.docx";

            DocX doc = DocX.Load(FileTemplate);
            List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.search(valueSearch, locChuyennganh);
            Xceed.Document.NET.Table tableSinhvien = doc.Tables[0];
            int tRow = 1;
            int stt = 1;
            DateTime convertNgaysinh;
            foreach (var item in tbl_Sinhviens)
            {
                //tableSinhvien.RowCount
                tableSinhvien.InsertRow(tRow);
                tableSinhvien.Rows[tRow].Cells[0].Paragraphs.First().Append(stt.ToString());
                tableSinhvien.Rows[tRow].Cells[1].Paragraphs.First().Append(item.Masv.ToString());
                tableSinhvien.Rows[tRow].Cells[2].Paragraphs.First().Append(item.TenSV.ToString());
                tableSinhvien.Rows[tRow].Cells[3].Paragraphs.First().Append(item.Gioittinh == true ? "Nữ" : "Nam");
                convertNgaysinh = Convert.ToDateTime(item.Namsinh);
                tableSinhvien.Rows[tRow].Cells[4].Paragraphs.First().Append(convertNgaysinh.ToString("dd/MM/yyyy"));
                tableSinhvien.Rows[tRow].Cells[5].Paragraphs.First().Append(item.Khoa.ToString());
                tableSinhvien.Rows[tRow].Cells[6].Paragraphs.First().Append(item.Chuyennganh.ToString());
                tRow += 1;
                stt++;
            }
            
            doc.ReplaceText("@danhmuc", "sinh viên");
            doc.ReplaceText("@date", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            doc.ReplaceTextWithObject("@table", tableSinhvien);
            doc.SaveAs(urlFileSave);

            Response.Buffer = true;
            Response.Expires = 0;
            Response.Clear();
            Response.ContentType = "application/msword";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "utf-8";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.TransmitFile(urlFileSave);
            Response.Flush();
            Response.Close();
            Response.End();
        }


        // tạo file excel
        private void ExportToExcel()
        {
            string valueSearch = string.IsNullOrEmpty(Request["value"]) ? "" : Request["value"].ToLower();
            string locChuyennganh = string.IsNullOrEmpty(Request["loccn"]) ? "" : Request["loccn"].ToString();

            string FileTemplate = Server.MapPath("/AppFile/Sinhvien/Excel/DSSV.xls");
            FileStream fs = new FileStream(FileTemplate, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            HSSFWorkbook hSSFWorkbook = new HSSFWorkbook(fs);
            HSSFSheet sheet = (HSSFSheet)hSSFWorkbook.GetSheetAt(0);
            IRow row = sheet.GetRow(0);
            ICell cell = row.GetCell(0);
            string value = cell.StringCellValue;
            value = value.Replace("@danhmuc", "sinh viên");
            value = value.Replace("@date", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            cell.SetCellValue(value);


            //List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.getALL();
            List<tbl_sinhvienEntity> tbl_Sinhviens = sinhvienDAO.search(valueSearch, locChuyennganh);

            ICellStyle style = hSSFWorkbook.CreateCellStyle();
            style.WrapText = true;
            style.BorderTop = NPOI.SS.UserModel.BorderStyle.Thin;
            style.BorderLeft = NPOI.SS.UserModel.BorderStyle.Thin;
            style.BorderRight = NPOI.SS.UserModel.BorderStyle.Thin;
            style.BorderBottom = NPOI.SS.UserModel.BorderStyle.Thin;
            int rowIndex = 2;
            int stt = 1;
            DateTime convertNgaysinh;
            foreach (var item in tbl_Sinhviens)
            {
                var newRow = sheet.GetRow(rowIndex);
                newRow.GetCell(0).SetCellValue(stt++);
                newRow.GetCell(1).SetCellValue(item.Masv);
                newRow.GetCell(2).SetCellValue(item.TenSV);
                newRow.GetCell(3).SetCellValue(item.Gioittinh == true ? "Nữ" : "Nam");
                convertNgaysinh = Convert.ToDateTime(item.Namsinh);
                newRow.GetCell(4).SetCellValue(convertNgaysinh.ToString("dd/MM/yyyy"));
                newRow.GetCell(5).SetCellValue(item.Khoa.ToString());
                newRow.GetCell(6).SetCellValue(item.Chuyennganh.ToString());
                newRow.GetCell(7).SetCellValue(item.Email.ToString());
                newRow.GetCell(8).SetCellValue(item.Dienthoai.ToString());
                newRow.GetCell(9).SetCellValue(item.Diachi.ToString());
                rowIndex++;

                for (int i = 0; i < 10; i++)
                {
                    newRow.GetCell(i).CellStyle = style;
                }
            }
            


            using (var exportData = new MemoryStream())
            {
                string filename = "DSSV" + DateTime.Now.ToString("ddMMyy") + ".xls";
                hSSFWorkbook.Write(exportData);
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", filename));
                Response.Clear();
                Response.BinaryWrite(exportData.GetBuffer());
                Response.End();
            }
        }
    }
}
