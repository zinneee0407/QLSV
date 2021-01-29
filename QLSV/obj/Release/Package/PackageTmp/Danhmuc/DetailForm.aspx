<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailForm.aspx.cs" Inherits="QLSV.Danhmuc.DetailForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            //button lưu dữ liệu
            $("#btnSave1").click(function () {
                valdateForm();
                var isvalid = $("#frmStudent").valid();
                if ($('[name="do"]').val().toLowerCase() == "delete") {
                    SubmitForm();
                }
                else {
                    if (isvalid) {
                        checkExists();
                    }
                }
            });
            //khi update form ngăn sửa ID
            if ($('[name="do"]').val().toLowerCase() == "edit") {
                $("#txtMasv").attr('readonly', true);
            }
            valdateForm();
            
        });

        function SubmitForm() {
            var urlAction = "ActionHandler.aspx";
            var dataPostBack = $("#frmStudent").find("input,textarea,select,hidden").not("#__VIEWSTATE,#__EVENTVALIDATION,#__VIEWSTATEGENERATOR").serialize();
            $.post(urlAction, dataPostBack, function (data) {
                if (data.Erros) {
                    alert(data.Message);
                    $("#jdialog", window.parent.document).scrollTop(0);
                }
                else {
                    $("#jdialog").html("").dialog('close');
                    loadData();
                }
            });
        }

        //jquery validate form
        function valdateForm() {
            $.validator.addMethod(
                "regex",
                function (value, element, regexp) {
                    return this.optional(element) || regexp.test(value);
                },
                "Please check your input."
            );


            $("#frmStudent").validate({
                rules: {
                    txtMasv: {
                        required: true,
                        minlength: 10,
                        maxlength: 10,
                        max:2000000000,
                        number: true
                    },
                    txtTenSV: {
                        required: true,
                        regex: /^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$/
                    },
                    txtNamsinh: {
                        required: true,
                        date: true,
                        min: "1900-01-01",
                        max: "2020-12-31"
                    },
                    txtKhoa: {
                        required: true,
                        max: 64,
                        min: 47
                    },
                    txtEmail: {
                        required: true,
                        email: true
                        //regex:/^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/
                    },
                    txtDienthoai: {
                        required: true,
                        regex: /^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/
                    },
                    txtDiachi: {
                        required: true
                    }
                },
                messages: {
                    txtMasv: {
                        required: "Nhập mã sinh viên",
                        minlength: "Nhập 10 kí tự",
                        maxlength: "Nhập 10 kí tự",
                        max: "Msv không hợp lệ",
                        number: "Msv không hợp lệ"
                    },
                    txtTenSV: {
                        required: "Nhập tên sinh viên",
                        regex: "Tên không hợp lệ"
                    },
                    txtNamsinh: {
                        required: "Nhập ngày sinh",
                        date:"ngày sinh không hợp lệ",
                        min: "Ngày sinh không hợp lệ",
                        max:"Không thể nhập quá ngày hiện tại"
                    },
                    txtKhoa: {
                        required: "Nhập khoá học",
                        max: "Chọn khoá học trong khoảng từ K47-K64",
                        min: "Chọn khoá học trong khoảng từ K47-K64"
                    },
                    txtEmail: {
                        required: "Nhập email",
                        email: "Email không hợp lệ"
                    },
                    txtDienthoai: {
                        required: "Nhập số điện thoại",
                        regex : "Số điện thoại không hợp lệ"
                    },
                    txtDiachi: {
                        required: "Nhập địa chỉ"
                    }
                }
            });
            
        }
        // gửi các input để kiểm tra nếu có lỗi trả về thông báo lỗi
        function checkExists() {
            var urlAction = "ActionHandler.aspx";
            var dataPostBack = $("#frmStudent").find("input,textarea,select,hidden").not("#__VIEWSTATE,#__EVENTVALIDATION,#__VIEWSTATEGENERATOR").serialize();
            $.post(urlAction, dataPostBack, function (errorResponse) {
                debugger;
                if (errorResponse.length >0) {
                    for (var i = 0; i < errorResponse.length; i++) {
                        $("#txt" + errorResponse[i].key).after("<label style='color: red;' id='error_ " + errorResponse[i].key + "'>" + errorResponse[i].errors + "</label>");
                    }
                }
                else {
                    SubmitForm();
                    $("#jdialog").html("").dialog('close');
                    loadData();
                }
            });
        }
    </script>
</head>
<body>
    <form id="frmStudent" class="form-horizontal" runat="server">
        <%--<div id="">--%>
        <input type="hidden" name="do" value="<%=doAction %>" />
        <input type="hidden" name="ItemID" value="<%=itemID %>" />
        <div class="form-group">
            <label class="control-label col-sm-3">Mã sinh viên :</label>
            <div class="col-sm-9">
                <input type="number" id="txtMasv" name="txtMasv" value="<%= tbl_Sinhviens.Masv%>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Tên sinh viên</label>
            <div class="col-sm-9">
                <input type="text" id="txtTenSV" name="txtTenSV" value="<%=tbl_Sinhviens.TenSV %>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Năm sinh</label>
            <div class="col-sm-9">
                <input type="date" id="txtNamsinh" name="txtNamsinh" value="<%= Convert.ToDateTime(tbl_Sinhviens.Namsinh).ToString("yyyy-MM-dd") %>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Giới tính</label>
            <div class="col-sm-9">
                <div class="form-check form-check-inline">
                    <label for="male" class="radio-inline">
                        <input type="radio" id="male" name="rdoGioittinh" value="false" <%= (tbl_Sinhviens.Gioittinh == false ? "checked":"") %> />Nam
                    </label>
                    <label for="female" class="radio-inline">
                        <input type="radio" id="female" name="rdoGioittinh" value="true" <%= (tbl_Sinhviens.Gioittinh == true ? "checked":"")%> />Nữ
                    </label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-3">Khoá</label>
            <div class="col-sm-9">
                <input type="number" id="txtKhoa" name="txtKhoa" value="<%=tbl_Sinhviens.Khoa %>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Chuyên ngành</label>
            <div class="col-sm-9">
                <select id="ddlChuyennganh" name="ddlChuyennganh" class="form-control">
                    <% foreach (var item in tbl_Chuyennganhs)
                        {%>
                    <option value="<%=item.Macn %>" <%= (tbl_Sinhviens.Chuyennganh == item.Macn ? "selected" : "") %>><%= item.Tencn %></option>
                    <% } %>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Email</label>
            <div class="col-sm-9">
                <input type="email" id="txtEmail" name="txtEmail" value="<%=tbl_Sinhviens.Email %>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Điện thoại</label>
            <div class="col-sm-9">
                <input type="text" id="txtDienthoai" name="txtDienthoai" value="<%=tbl_Sinhviens.Dienthoai %>" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-3">Địa chỉ</label>
            <div class="col-sm-9">
                <textarea id="txtDiachi" name="txtDiachi" class="form-control" rows="5" cols="50" required=""><%=tbl_Sinhviens.Diachi %></textarea>
            </div>
        </div>
        <%--<textarea class="ckeditor" name="editor" cols="80" rows="10"><p>Hello <strong>CKEditor</strong></p></textarea>--%>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9">
                <button type="button" id="btnSave1">LƯU LẠI</button>
            </div>
        </div>
        <%--</div>--%>
    </form>
</body>
</html>
