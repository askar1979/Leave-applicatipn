<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="Increments.aspx.vb"
    Inherits="LeaveSoftware.Increments" Title="واجهة تحديث الاجازات" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    <h2>
        صفحة تحديث الاجازات</h2>
    <table class ="increments" align="center">
     <tr>
            <td align="center">
                <asp:Label ID="lblNormalIncrementDate" runat="server" BackColor="#BBBBE4" 
                    BorderStyle="Double" Width="250px"></asp:Label>
            </td>
            <td>
                <asp:Button ID="normalIncrement" runat="server" Text="تحديث الاجازات الاعتيادية" Width ="150px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblSickIncrementsDate" runat="server" BackColor="#BBBBE4" 
                    BorderStyle="Double" Width="250px"></asp:Label>
            </td>
            <td>
                <asp:Button ID="sickIncrements" runat="server" Text="تحديث الاجازات المرضية" Width ="150px" />
            </td>
        </tr>
         
    </table>
    <asp:SqlDataSource ID="SDSIncrementNormalLeaves" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommandType="StoredProcedure" UpdateCommand="duration_incrementNormal"
        UpdateCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSIncrementSickLeaves" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Leave_DBConnectionString.ProviderName %>"
        UpdateCommand="duration_increment_Both_Sickness_Leaves" 
        UpdateCommandType="StoredProcedure" 
        SelectCommand="duration_increment_Both_Sickness_Leaves" 
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSIncrementDate" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>" 
        
        SelectCommand="SELECT TOP (1) LastUpdate FROM DurationUpdate ORDER BY ID DESC"></asp:SqlDataSource>
         
</asp:Content>
