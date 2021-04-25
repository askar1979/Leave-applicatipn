<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="InsertNewEmployee.aspx.vb" Inherits="LeaveSoftware.InsertNewEmployee" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">


<h2>صفحة اضافة موظف جديد</h2>

<div class ="DetailsViewInsertNewEmployee" >
<asp:DetailsView ID="DetailsViewInsertNewEmployee" runat="server" Height="49px" Width="456px" 
        DataSourceID="SDSInsertNewEmployee" AutoGenerateRows="False" 
        DataKeyNames="ID" DefaultMode="Insert" 
        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
        CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <Fields>
          
             <asp:TemplateField HeaderText="الاسم" SortExpression="BatchNumber">
                 
                 <InsertItemTemplate>
                     <asp:TextBox ID="TextBox1" Width ="200px" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>                  
                       <asp:RequiredFieldValidator ID="RFVName" runat="server" ErrorMessage="*" 
                                    ControlToValidate ="TextBox1" Display="Dynamic" ForeColor="Yellow"></asp:RequiredFieldValidator>
                 </InsertItemTemplate>
                    
             </asp:TemplateField>
             
             <asp:TemplateField HeaderText="رقم الباج" SortExpression="BatchNumber">
                
                 <InsertItemTemplate>
                     <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("BatchNumber") %>'></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVBatchNumber" runat="server" ErrorMessage="*" 
                                    ControlToValidate ="TextBox2" Display="Dynamic" ForeColor="Yellow"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="رقم صحيح فقط" ValidationExpression="^\d+$" Display="Dynamic" ForeColor="Yellow" ControlToValidate="TextBox2"></asp:RegularExpressionValidator>
                 </InsertItemTemplate>
                
             </asp:TemplateField>
             <asp:TemplateField HeaderText="تاريخ المباشرة" SortExpression="StartDate">
                 <InsertItemTemplate>
                     <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
                     
                       <asp:RequiredFieldValidator ID="RFVStartDate" runat="server" ErrorMessage="*" 
                                    ControlToValidate ="TextBox3" Display="Dynamic" ForeColor="Yellow"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator_StartDate" runat="server" 
                                    ErrorMessage="أدخل تاريخ فقط" ControlToValidate="TextBox3" Display="Dynamic" 
                                    Operator="DataTypeCheck" Type="Date" ForeColor="Yellow"></asp:CompareValidator>
                     
                  </InsertItemTemplate>                   
                 <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />          
             </asp:TemplateField>
                                
              <asp:TemplateField HeaderText="القسم/الدائرة" SortExpression="Name">
                
                <InsertItemTemplate>
              
                    <asp:DropDownList ID="DDLDepartments" runat="server" 
                        DataSourceID="SDSDepartments" DataTextField="Name" DataValueField="ID" 
                        SelectedValue='<%# Bind("DepartmentID") %>'>
                    </asp:DropDownList>
                   
                </InsertItemTemplate>
                
            </asp:TemplateField>
            
             <asp:TemplateField HeaderText="تاريخ ترك الوظيفة" SortExpression="QuitDate">
                
                 <InsertItemTemplate>
                     <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("QuitDate") %>'></asp:TextBox>
                   <asp:CompareValidator ID="CompareValidator_QuitDate" runat="server" 
                                    ErrorMessage="أدخل تاريخ فقط" ControlToValidate="TextBox4" Display="Dynamic" 
                                    Operator="DataTypeCheck" Type="Date" ForeColor="Yellow"></asp:CompareValidator>
                
                 </InsertItemTemplate>
                
             </asp:TemplateField>
           
             <asp:TemplateField HeaderText="حالة الموظف" SortExpression="EmployeeStatus">
                 
                 <InsertItemTemplate>
                 
                 <asp:DropDownList ID="DDLEmpStatus" runat="server" Height="25px" 
                         SelectedValue='<%# Bind("EmployeeStatus") %>' Width="75px">
                         <asp:ListItem>مستمر</asp:ListItem>
                         <asp:ListItem>غير مستمر</asp:ListItem>
                     </asp:DropDownList>        
                   
                 </InsertItemTemplate>                    
                 
             </asp:TemplateField>
               <asp:CommandField ShowInsertButton="True" CancelText="الغاء" 
                   InsertText="اضافة" />
        </Fields>
    
        
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:DetailsView>

  </div>
 
    <asp:SqlDataSource ID="SDSInsertNewEmployee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>" 
        
        SelectCommand="SELECT [ID], [Name], [BatchNumber], [StartDate], [DepartmentID], [QuitDate], [EmployeeStatus] FROM [Employee]" 
        InsertCommand="INSERT INTO [Employee] ([Name], [BatchNumber], [StartDate], [DepartmentID], [QuitDate], [EmployeeStatus]) VALUES (@Name, @BatchNumber, @StartDate, @DepartmentID, @QuitDate, @EmployeeStatus)" 
        DeleteCommand="DELETE FROM [Employee] WHERE [ID] = @ID" 
        UpdateCommand="UPDATE [Employee] SET [Name] = @Name, [BatchNumber] = @BatchNumber, [StartDate] = @StartDate, [DepartmentID] = @DepartmentID, [QuitDate] = @QuitDate, [EmployeeStatus] = @EmployeeStatus WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="BatchNumber" Type="Int32" />
            <asp:Parameter DbType="DateTime" Name="StartDate" />
            <asp:Parameter Name="DepartmentID" Type="Int16" />
            <asp:Parameter DbType="DateTime" Name="QuitDate" />
            <asp:Parameter Name="EmployeeStatus" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="BatchNumber" Type="Int32" />
            <asp:Parameter Name="StartDate" DbType="DateTime" />
            <asp:Parameter Name="DepartmentID" Type="Int16" />
            <asp:Parameter Name="QuitDate" DbType="DateTime" />
            <asp:Parameter Name="EmployeeStatus" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SDSDepartments" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>" 
        SelectCommand="SELECT * FROM [Department]"></asp:SqlDataSource>


    <br />
    <br />


</asp:Content>
