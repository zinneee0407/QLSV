<%@ Page Title="" Language="C#" MasterPageFile="~/PageLayout/_MenuLeft.master" AutoEventWireup="true" CodeBehind="MainForm.aspx.cs" Inherits="QLSV.Danhmuc.SinhVien.MainForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        var urlAction = "ActionHandler.aspx";
        var urlForm = "DetailForm.aspx";
        var urlFormView = "FormView.aspx";
        var formWidth = '600';
        var formHeight = '600';
        $(document).ready(function () {
            loadData();
            RegisterMainEvent();
        });

        function EditItem(itemID) {
            $.post(encodeURI(urlForm), { "do": "Edit", "itemid": itemID }, function (data) {
                $("#jdialog").html(data);
            });
            $("#jdialog").dialog({ title: "Cập nhật sinh viên " + itemID, width: formWidth, height: formHeight }).dialog("open");
        }

        function Delete(itemID) {
            var messageDelete = "Bạn có muốn xoá sinh viên có mã " + itemID;
            $("#jdialog2").html('<div><h6>' + messageDelete + '?</h6></div>').dialog({
                auto: false,
                title: "Xoá",
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "Đồng ý": function () {
                        $.post(encodeURI(urlAction), { "do": "Delete", "itemid": itemID });
                        $(this).dialog("close");
                    },
                    "Huỷ": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

        function AddItem() {
            $.post(encodeURI(urlForm), { "do": "add" }, function (data) {
                $("#jdialog").html(data);
            });
            $("#jdialog").dialog({
                title: "Thêm mới sinh viên",
                modal: true,
                width: formWidth,
                height: formHeight,
                resizable: false

            }).dialog("open");
        }

        function FormView(itemID) {
            $.post(encodeURI(urlFormView), {"itemid": itemID }, function (data) {
                $("#jdialog").html(data);
            });
            $("#jdialog").dialog({ title: "Chi tiết sinh viên có mã " + itemID, width: formWidth, height: formHeight }).dialog("open");
        }

        function Search() {
            $.post(encodeURI("GridInfo.aspx"), {
                "do": "search",
                "value": $("#txtSearch").val(),
                "loccn": $("#ddlChuyennganh").val(),
                "page": $("#pagenum").val()
            }, function (data) {
                var htmlData = "";
                for (var i = 0; i < data.length; i++) {
                    htmlData += "<tr row_id=" + data[i].Masv + ">"
                        + "<td><a href=\"#\" onclick=\"FormView(" + data[i].Masv + ");\">" + data[i].Masv + "</a></td>"
                        + "<td class='row_data'>" + data[i].TenSV + "</td>"
                        + "<td>" + GetFormattedDate(data[i].Namsinh) + "</td>"
                        + "<td>" + (data[i].Gioittinh == true ? "Nữ" : "Nam ") + "</td>"
                        + "<td>" + data[i].Khoa + "</td>"
                        + "<td>" + data[i].Chuyennganh + "</td>"
                        + "<td>" + data[i].Dienthoai + "</td>"
                        + "<td><input type='checkbox'" + (data[i].Totnghiep == true ? "checked" : "") + " onclick='return false;'/></td>"
                        + "<td><a href=\"#\" onclick=\"EditItem(" + data[i].Masv + ");\">Sửa</a></td>"
                        + "<td><a href=\"#\" onclick=\"Delete(" + data[i].Masv + ");\">Xoá</a></td>"
                        + "</tr>";
                }
                $("#dataList").html(htmlData);
            });
        }
        //load list sinhvien
        function loadData() {
            $.post(encodeURI("GridInfo.aspx"), { "do": "loaddata", "page": $("#pagenum").val() }, function (data) {
                var htmlData = "";
                for (var i = 0; i < data.length; i++) {
                    htmlData += "<tr row_id=" + data[i].Masv +">"
                        + "<td><a href=\"#\" onclick=\"FormView(" + data[i].Masv + ");\">" + data[i].Masv + "</a></td>"
                        + "<td class='row_data'>" + data[i].TenSV + "</td>"
                        + "<td>" + GetFormattedDate(data[i].Namsinh) + "</td>"
                        + "<td>" + (data[i].Gioittinh == true ? "Nữ" : "Nam ") + "</td>"
                        + "<td>" + data[i].Khoa + "</td>"
                        + "<td>" + data[i].Chuyennganh + "</td>"
                        + "<td>" + data[i].Dienthoai + "</td>"
                        + "<td><input type='checkbox'" + (data[i].Totnghiep == true ? "checked" : "") + " onclick='return false;'/></td>"
                        + "<td><a href=\"#\" onclick=\"EditItem(" + data[i].Masv + ");\">Sửa</a></td>"
                        + "<td><a href=\"#\" onclick=\"Delete(" + data[i].Masv + ");\">Xoá</a></td>"
                        + "</tr>";
                }
                $("#dataList").html(htmlData);
            });
        }

        //fommatdate
        function GetFormattedDate(tempDatetime) {
            var date = new Date(tempDatetime);
            var month = (date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1));
            var day = (date.getDate() > 9) ? date.getDate() : ('0' + date.getDate());
            var year = date.getFullYear();
            return day + "/" + month + "/" + year;
        }

        function RegisterMainEvent() {
            //button them sinh vien moi
            $("#btnAdd").click(function () {
                AddItem();
            });
            //button search
            $("#btnSearch").click(function () {
                Search();
            });
            //button xuat word 
            $("#btnExportWord").click(function () {
                window.open("ActionHandler.aspx?do=exporttoword&value=" + $("#txtSearch").val() + "&loccn=" + $("#ddlChuyennganh").val(), "_blank");
            });
            //button xuat excel
            $("#btnExportExcel").click(function () {
                window.open("ActionHandler.aspx?do=exporttoexcel&value=" + $("#txtSearch").val() + "&loccn=" + $("#ddlChuyennganh").val(), "_blank");
            });
            //phân trang
            $("#pagenum").change(function () {
                loadData();
            });
            //update trong table
            //$("body").on("dblclick", "#dataList tr td", function () {
            //    var masv = $(this).parents("tr").find("td:eq(0)").text();
            //    var tensv = $(this).parents("tr").find("td:eq(1)").text();
            //    $(this).parents("tr").find("td:eq(1)").html('<input name="edit_TenSV" value="' + tensv + '" onfocusout="updateTable(' + masv + ')" />');
            //    $(this).parents("tr").find("input[name=\"edit_TenSV\"]").focus();
            //var tensv = $("#dataList tr td").parents("tr").find("input[name=\"edit_TenSV\"]").val();
            //});
            $(document).on('dblclick', '.row_data', function () {
                $(this).closest('td').attr('contenteditable', 'true');
                $(this).attr('original', $(this).html());
                $(this).focus();
            })	

            $(document).on('focusout', '.row_data', function () {
                var masv = $(this).parents("tr").find("td:eq(0)").text();
                var tensv = $(this).parents("tr").find("td:eq(1)").text();
                updateTable(masv, tensv);
                $(this).closest('td').removeAttr('contenteditable');
            })
        }

        function updateTable(itemID, tensv) {
            var messageDelete = "Bạn có muốn cập nhật <strong>" + tensv + "</strong> cho tên sinh viên có mã <strong>" + itemID +"</strong>";
            $("#jdialog2").html('<div><h6>' + messageDelete + '?</h6></div>').dialog({
                auto: false,
                title: "Cập nhật",
                height: "auto",
                width: 400,
                modal:true,
                buttons: {
                    "Đồng ý": function () {
                        $.post(encodeURI(urlAction), { "do": "updatetable", "itemid": itemID, "txtTenSV": tensv }, function (errorResponse) {
                            if (errorResponse.length > 0) {
                                debugger;
                                var findCellEdit = $("[row_id='" + itemID + "']").find("td.row_data");
                                findCellEdit.html($(".row_data").attr('original'));
                                $("#jdialog2").dialog("close");
                                alert(errorResponse[0].errors);
                                loadData();
                            }
                            else {
                                loadData();
                                $("#jdialog2").dialog("close");
                            }
                        });
                        
                    },
                    "Huỷ": function () {
                        // trả lại data cũ nếu không sửa
                        var findCellEdit = $("[row_id='" + itemID + "']").find("td.row_data");
                        findCellEdit.html($(".row_data").attr('original'));
                        $(this).dialog("close");
                    }
                }
            });
        }
    </script>
    <style>
        th {
            background: #eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h4><strong>Danh sách sinh viên</strong></h4>
    <br />
    <div class="">
        <div style="float: left;">
            <button id="btnAdd">Thêm mới học sinh</button>
            <button id="btnExportWord">Xuất file word</button>
            <button id="btnExportExcel">Xuất file Excel</button>
            
            <br />
        </div>
        <div style="float: right">
            <input type="text" name="txtSearch" id="txtSearch" value="" placeholder="Tìm kiếm theo tên hoặc mã sinh viên" style="width: 250px;" />
            <select id="ddlChuyennganh" name="ddlChuyennganh" style="padding: 3px; border: 1px solid #ccc; border-radius: 4px;">
                <option value=" ">Chọn chuyên ngành</option>
                <% foreach (var item in tbl_Chuyennganhs)
                    {%>
                <option value="<%=item.Tencn %>"><%= item.Tencn %></option>
                <% } %>
            </select>
            <button id="btnSearch">Tìm kiếm</button>
        </div>
    </div>
    <div class="clearfix"></div>


    <div class="tableFixHead">
        <table id="dtVerticalScrollExample" class="table table-striped table-bordered table-sm tableFixHead">
            <thead>
                <tr>
                    <th>Mã sinh viên</th>
                    <th>Tên sinh viên</th>
                    <th>Năm sinh</th>
                    <th>Giới tính</th>
                    <th>Khóa</th>
                    <th>Chuyên ngành</th>
                    <th>Số điện thoại</th>
                    <th>Tốt nghiệp</th>
                    <th>SỬA</th>
                    <th>XOÁ</th>
                </tr>
            </thead>
            <tbody id="dataList">
            </tbody>
        </table>
    </div>
    <select name="pagenum" id="pagenum">
        <option value="1">1 </option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
    </select>
    <div id="jdialog"></div>
    <div id="jdialog2"></div>
</asp:Content>
