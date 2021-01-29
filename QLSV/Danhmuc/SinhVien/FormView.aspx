<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormView.aspx.cs" Inherits="QLSV.Danhmuc.SinhVien.FormView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .label{
            color :#333;
            float:left;
            font-size:14px;
        }
        td{
            margin :10px;
        }
        .controls{
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="tblform" id="tblInput">
            <tr class="header">
                <td colspan="2">
                    <p style="text-align: center; font-size: 25px">
                        Chi tiết sinh viên
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Mã sinh viên:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Masv.ToString()) %>
                </td>
            </tr>
            <tr>
                <td class="label">Tên sinh viên:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.TenSV.ToString()) %>
                </td>
            </tr>
            <tr>
                <td class="label">Năm sinh: </td>
                <td>
                    <%=Server.HtmlEncode( Convert.ToDateTime(tbl_Sinhviens.Namsinh).ToString("dd/MM/yyyy")) %>
                </td>
            </tr>
            <tr>
                <td class="label">Giới tính:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Gioittinh == true ? "Nữ" : "Nam")  %>
                </td>
            </tr>
            <tr>
                <td class="label">Khoá:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Khoa.ToString())  %>
                </td>
            </tr>
            <tr>
                <td class="label">Chuyên ngành:
                </td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Chuyennganh.ToString() )  %>
                </td>
            </tr>
            <tr>
                <td class="label">Email:
                </td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Email )  %>
                </td>
            </tr>
            <tr>
                <td class="label">Điện thoại:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Dienthoai )  %>
                </td>
            </tr>
            <tr>
                <td class="label">Địa chỉ:</td>
                <td>
                    <%=Server.HtmlEncode(tbl_Sinhviens.Diachi)  %>
                </td>
            </tr>
            <tr>
                <td class="label">Tốt nghiệp</td>
                <td>
                    <%=tbl_Sinhviens.Totnghiep == true?"Đã tốt nghiệp": "Chưa tốt nghiệp" %>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
