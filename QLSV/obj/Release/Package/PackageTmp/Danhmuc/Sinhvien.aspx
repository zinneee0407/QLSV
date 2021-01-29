<%@ Page Title="" Language="C#" MasterPageFile="~/PageLayout/_MenuLeft.master" AutoEventWireup="true" CodeBehind="Sinhvien.aspx.cs" Inherits="QLSV.Danhmuc.Sinhvien" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        var urlAction = "ActionHandler.aspx";
        var urlForm = "DetailForm.aspx";
        var formWidth = 'auto';
        var formHeight ='auto';
        $(document).ready(function () {
            loadData();
            RegisterMainEvent();
        });

        function EditItem(itemID) {
            $.post(encodeURI(urlForm), { "do": "Edit", "itemid": itemID }, function (data) {
                $("#jdialog").html(data);

            });
            $("#jdialog").dialog({ title: "Sửa", width: formWidth, height: formHeight, resizable: false}).dialog("open");
        }

        function Delete(itemID) {
            $.post(encodeURI(urlForm), { "do": "Delete", "itemid": itemID }, function (data) {
                $("#jdialog").html(data);
            });
        }

        function AddItem() {
            $.post(encodeURI(urlForm), { "do": "add" }, function (data) {
                $("#jdialog").html(data);
            });
            $("#jdialog").dialog({ title: "Thêm mới", width: formWidth, height: formHeight, resizable: false}).dialog("open");
        }
        //load list sinhvien
        function loadData() {
            $.post(encodeURI(urlAction), { "do": "loaddata", "page": $("#pagenum").val() }, function (data) {
                var htmlData = "";
                debugger;
                for (var i = 0; i < data.length; i++) {
                    htmlData += "<tr>"
                        + "<td>" + (i+1) + "</td>"
                        + "<td>" + data[i].Masv + "</td>"
                        + "<td>" + data[i].TenSV + "</td>"
                        + "<td>" + data[i].Namsinh + "</td>"
                        + "<td>" + (data[i].Gioittinh == true ? "Nữ" : "Nam ") + "</td>"
                        + "<td>" + data[i].Khoa + "</td>"
                        + "<td>" + data[i].Chuyennganh + "</td>"
                        + "<td>" + data[i].Email + "</td>"
                        + "<td>" + data[i].Dienthoai + "</td>"
                        + "<td>" + data[i].Diachi + "</td>"
                        + "<td><a href=\"#\" onclick=\"EditItem(" + data[i].Masv + ");\">Sửa</a></td>"
                        //+ "<td><a href=\"#\" onclick=\"Delete(" + data[i].Masv + ");\">Xoá</a></td>"
                        + "<td><a href=\"#\" onclick=\"ConfirmDialog();\">Xoá</a></td>"
                        + "</tr>";
                }
                $("#dataList").html(htmlData);
            });
        }
        

        function RegisterMainEvent() {
            //button them sinh vien moi
            $("#btnAdd").click(function () {
                AddItem();
            });
            //button xuat word 
            $("#btnExportWord").click(function () {
                $.post(encodeURI(urlAction), { "do": "exporttoword" }, function () {
                    alert("Export to word");
                });
            });
            //button xuat excel
            $("#btnExportExcel").click(function () {
                $.post(encodeURI(urlAction), { "do": "exporttoexcel" }, function () {
                    alert("Export to Excel");
                });
            });
            //button nhap excel
            $("#btnImporttExcel").click(function () {
                $.post(encodeURI(urlAction), { "do": "importtoexcel" }, function () {
                    alert("Export to Excel");
                });
            });
            //phân trang
            $("#pagenum").change(function () {
                loadData();
            });
        }

        //form xác nhận xoá
        function ConfirmDialog() {
            $("#jdialog").dialog({
                    modal: true,
                    title: 'Delete message',
                    zIndex: 10000,
                    autoOpen: true,
                    width: 'auto',
                    resizable: false,
                    buttons: {
                        Yes: function () {

                            $('body').append('<h1>Confirm Dialog Result: <i>Yes</i></h1>');

                            $(this).dialog("close");
                        },
                        No: function () {
                            $('body').append('<h1>Confirm Dialog Result: <i>No</i></h1>');

                            $(this).dialog("close");
                        }
                    },
                    close: function (event, ui) {
                        $(this).remove();
                    }
            }).dialog("open");
        };

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="jdialog" style="background-color: wheat;"></div>
    <h5><strong>Danh sách sinh viên</strong></h5>
    <br />

    <button id="btnAdd">Add new</button>
    <button id="btnExportWord">Export Word</button>
    <button id="btnExportExcel">Export Excel</button>
    <%--<input type="file" id="fileExcel" name="fileExcel" />--%>
    <button id="btnImporttExcel">Import Excel</button>

    <table class="table">
        <thead>
            <tr>
                 <th>STT</th>
                <th>Mã sinh viên</th>
                <th>Tên sinh viên</th>
                <th>Năm sinh</th>
                <th>Giới tính</th>
                <th>Khóa</th>
                <th>Chuyên ngành</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Địa chỉ</th>
                <th>SỬA</th>
                <th>XOÁ</th>
            </tr>
        </thead>
        <tbody id="dataList">
        </tbody>
    </table>

    <select name="pagenum" id="pagenum">
        <option value="1">1 </option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
    </select>
</asp:Content>

