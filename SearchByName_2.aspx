<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="SearchByName_2.aspx.vb" Inherits="LeaveSoftware.SearchByName_2" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
<h2>صفحة البحـث</h2>
<table >
        <tr>
          <td>
    <table class="SearchByNameTable">
        <tr align="center">
            <td>
                <asp:DropDownList ID="DDLAction" runat="server" Height="25px" Font-Bold="True" 
                    Font-Names="Times New Roman" Font-Size="Large">
                  
                    <asp:ListItem Value="1">الاجازات الاعتيادية</asp:ListItem>
                    <asp:ListItem Value="3">المرضية براتب تام</asp:ListItem>
                    <asp:ListItem Value="4">المرضية بنصف راتب</asp:ListItem>
                    <asp:ListItem Value="2">الاجازات الزمنية</asp:ListItem>
                    <asp:ListItem Value="5">التقارير</asp:ListItem>
                    <asp:ListItem Value="6">التقرير الشامل</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="textboxName" runat="server" Width="250px"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="SearchName" runat="server" Text="بحث" width="60px" 
                    Font-Bold="True" Font-Size="Large"/>
            </td>
             <td>
                <asp:Button ID="passValue" runat="server" Text="بحث متقدم" width="120px" 
                    Font-Bold="True" Font-Size="Large"/>
            </td>
             </tr>
          </table>
         </td>
        </tr>  
        
        <tr>
        <td>
       <table class ="GV_Name" >
        <tr>
        
       
        <td>
         <asp:panel ID="PanelGV_Name" runat="server" ScrollBars ="Vertical"
          style="height: 300px; width: 600px;" Visible="False" >
        
            <asp:GridView ID="GVEmpName" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="BatchNumber" CellPadding="4" Height="174px" Style="margin-left: 0px"
                        GridLines="None" Width="600px" HorizontalAlign="Center" 
                 ForeColor="#333333">
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="BatchNumber" HeaderText="رقم الباج" />
                            <asp:BoundField DataField="Department" HeaderText="القـسـم" />
                            <asp:BoundField DataField="Name" HeaderText="الاسم" />
                            <asp:CommandField ShowSelectButton="True" SelectText="الاختيار" />
                        </Columns>
                        <FooterStyle BackColor="#5D7B9D" ForeColor="White" HorizontalAlign="Center" 
                            Font-Bold="True" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                            BackColor="#999999" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                 
            </asp:GridView>
            
            
           </asp:panel>
            
         </td>
        
        </tr>
    </table>
     
        </td>
     </tr>
    
    

    </table>
</asp:Content>
