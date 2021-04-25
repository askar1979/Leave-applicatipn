<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="SearchByName.aspx.vb"
    Inherits="LeaveSoftware.SearchByName" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
<h2>بحث حسب الاسم</h2>
    <table class="SearchByNameTable">
        <tr align="center">
            <td>
                <asp:DropDownList ID="DDLAction" runat="server" Height="25px" Font-Bold="True" 
                    Font-Names="Times New Roman" Font-Size="Large">
                   <asp:ListItem Value ="">------------------</asp:ListItem>
                    <asp:ListItem Value="1">الاجازات الاعتيادية</asp:ListItem>
                    <asp:ListItem Value="3">المرضية براتب تام</asp:ListItem>
                    <asp:ListItem Value="4">المرضية بنصف راتب</asp:ListItem>
                    <asp:ListItem Value="2">الاجازات الزمنية</asp:ListItem>
                    <asp:ListItem Value="5">التقارير</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="textboxName" runat="server" Width="200px"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="SearchName" runat="server" Text="بحث" width="60px" 
                    Font-Bold="True" Font-Size="Large"/>
            </td>
        </tr>
    </table>
</asp:Content>
