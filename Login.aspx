<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="Login.aspx.vb" Inherits="LeaveSoftware.Login" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    
    
    <table class ="LoginDesign" >
    <tr>
    <td>
        <asp:Label ID="LoginStatus" runat="server" Text=""></asp:Label>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="Label1" runat="server" Text="اسم المستخدم"></asp:Label></td>
    <td>
    <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox> </td>
   </tr>
    <tr>
    <td>
    <asp:Label ID="Label2" runat="server" Text="كلمة المرور"></asp:Label></td>
    <td>
    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox></td>
    
    </tr>
    <tr>
    <td>
    <asp:Button ID="Submit" runat="server" Text="دخول" /></td>
    </tr>
    </table>

    
    
</asp:Content>
