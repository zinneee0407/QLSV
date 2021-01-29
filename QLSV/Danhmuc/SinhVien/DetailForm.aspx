<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailForm.aspx.cs" Inherits="QLSV.Danhmuc.SinhVien.DetailForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            //button lưu dữ liệu
            $("#btnSave").click(function () {
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
            debugger;
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
                        max: 2000000000,
                        number: true
                    },
                    txtTenSV: {
                        required: true,
                        //regex: /^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$/
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
                        //required: true
                        maxlength: 50
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
                        //regex: "Tên không hợp lệ"
                    },
                    txtNamsinh: {
                        required: "Nhập ngày sinh",
                        date: "ngày sinh không hợp lệ",
                        min: "Ngày sinh không hợp lệ",
                        max: "Không thể nhập quá ngày hiện tại"
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
                        regex: "Số điện thoại không hợp lệ"
                    },
                    txtDiachi: {
                        //required: "Nhập địa chỉ"
                        maxlength :"Nhập tên thành phố"
                    }
                }
            });

        }
        // gửi các input để kiểm tra nếu có lỗi trả về thông báo lỗi
        function checkExists() {
            var urlAction = "ActionHandler.aspx";
            var dataPostBack = $("#frmStudent").find("input,textarea,select,hidden").not("#__VIEWSTATE,#__EVENTVALIDATION,#__VIEWSTATEGENERATOR").serialize();
            $.post(urlAction, dataPostBack, function (errorResponse) {
                if (errorResponse.length > 0) {
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
    <form id="frmDetail" class="form-horizontal" runat="server" style="width: 95%">
        <input type="hidden" name="do" value="<%=doAction %>" />
        <input type="hidden" name="ItemID" value="<%=itemID %>" />
        <table class="tblform" id="tblInput">
            <tr class="header">
                <td colspan="2">
                    <p class="validation">
                        Các trường có dấu <span class="star">*</span> yêu cầu phải nhập.
                    </p>
                </td>
            </tr>
            <%--<tr>
                <td style="height: 5px;"></td>
            </tr>--%>
            <tr>
                <td colspan="2">
                    <p style="text-align:center;"><b>Nhập thông tin sinh viên</b></p>
                </td>
            </tr>
            <tr>
                <td class="label" >Mã sinh viên:(<span class="star">*</span>)</td>
                <td >
                    <input type="number" id="txtMasv" name="txtMasv" value="<%= tbl_Sinhviens.Masv%>" class="controls"/>
                </td>
            </tr>
            <tr>
                <td class="label">Tên sinh viên:(<span class="star">*</span>)</td>
                <td >
                    <input type="text" id="txtTenSV" name="txtTenSV" value="<%=tbl_Sinhviens.TenSV %>" class="controls" />
                </td>
            </tr>
            <tr>
                <td class="label">Năm sinh: (<span class="star">*</span>)</td>
                <td >
                     <input type="date" id="dtpNamsinh" name="dtpNamsinh" value="<%= Convert.ToDateTime(tbl_Sinhviens.Namsinh).ToString("yyyy-MM-dd") %>" class="controls" />
                </td>
            </tr>
            <tr>
                <td class="label">Giới tính:</td>
                <td >
                    <input type="radio" id="male" name="rdoGioittinh" value="false" <%= (tbl_Sinhviens.Gioittinh == false ? "checked":"") %> /><label for="male">&nbsp;Nam</label>
                    <input type="radio" id="female" name="rdoGioittinh" value="true" <%= (tbl_Sinhviens.Gioittinh == true ? "checked":"")%>/><label for="female">&nbsp;Nữ</label>
                </td>
            </tr>
            <tr>
                <td class="label" >Khoá:(<span class="star">*</span>)</td>
                <td >
                     <input type="number" id="txtKhoa" name="txtKhoa"  value="<%=tbl_Sinhviens.Khoa %>" class="controls" />
                </td>
            </tr>
            <tr>
                <td class="label">Chuyên ngành:(<span class="star">*</span>)
                </td>
                <td >
                    <select id="ddlChuyennganh" name="ddlChuyennganh" class="controls">
                    <% foreach (var item in tbl_Chuyennganhs)
                        {%>
                    <option value="<%=item.Macn %>" <%= (tbl_Sinhviens.Chuyennganh == item.Macn ? "selected" : "") %>><%= item.Tencn %></option>
                    <% } %>
                </select>
                </td>
            </tr>
            <tr>
                <td class="label">Email:(<span class="star">*</span>)
                </td>
                <td >
                     <input type="email" id="txtEmail" name="txtEmail" value="<%=tbl_Sinhviens.Email %>" class="controls"  />
                </td>
            </tr>
            <tr>
                <td class="label">Điện thoại:(<span class="star">*</span>)</td>
                <td >
                        <input type="text" id="txtDienthoai" name="txtDienthoai" value="<%=tbl_Sinhviens.Dienthoai %>" class="controls" />
                </td>
            </tr>
            <tr>
                <td class="label">Địa chỉ:</td>
                <td >
                     <textarea id="txtDiachi" name="txtDiachi" rows="4" cols="50" class="controls" style=" resize: none;"><%=tbl_Sinhviens.Diachi %></textarea>
                </td>
            </tr>
            <tr>
                <td class="label"> </td>
                <td >
                     <%--<input type="checkbox" id="cboTotnghiep" name="cboTotnghiep"  <%tbl_Sinhviens.Totnghiep == true ?"checked":"" %> value="true" />&nbsp;--%> 
                    <input type="checkbox" name="cboTotnghiep"  <%= (tbl_Sinhviens.Totnghiep == true ? "checked ":"") %>  onchange="$(this).val(this.checked?'true': 'false');"  value="true" /><label> Đã tốt nghiệp</label>
                </td>
            </tr>
            <tr class="submit">
                <td> </td>
                <td>
                     <button type="button" id="btnSave">LƯU LẠI</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
