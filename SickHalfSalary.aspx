<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="SickHalfSalary.aspx.vb"
    Inherits="LeaveSoftware.SickHalfSalary" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    <h2 dir="rtl">
        صفحة الاجازات المرضية بنصف راتب</h2>
        
          <table class ="first" >
        <tr class="fourBlocks" dir="rtl" valign="top">
        <td >
             <asp:DetailsView ID="DetailsViewBalance" runat="server" Height="50px" Width="227px" 
            AutoGenerateRows="False" DataSourceID="SDSBalance" CellPadding="4" 
                 GridLines="Horizontal" BackColor="White" BorderColor="#E7E7FF" 
                 BorderStyle="None" BorderWidth="1px">
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <Fields>
                <asp:BoundField DataField="BatchNumber" HeaderText="رقم الباج" 
                    SortExpression="BatchNumber" />
                <asp:BoundField DataField="Balance" HeaderText="الرصيد الكلي" 
                    SortExpression="Balance" />
                <asp:BoundField DataField="ActualLeaves" HeaderText="ايام الاجازات" 
                    SortExpression="ActualLeaves" />
                <asp:BoundField DataField="RemainingLeaves" HeaderText="المتبقي من الرصيد" 
                    SortExpression="RemainingLeaves" />
                <asp:BoundField DataField="LeaveTypeID" HeaderText="رقم الاجازة" 
                    SortExpression="LeaveTypeID" />
            </Fields>
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:DetailsView>
        
            
       
        </td>
        <td dir="rtl" valign="top">
        
        <asp:DetailsView ID="DtlViewEmployeeInfo" runat="server" Height="85px" 
            Width="250px" DataSourceID="SDSEmployee" DataKeyNames="ID" CellPadding="4" 
                  AutoGenerateRows="False" GridLines="Horizontal" BackColor="White" 
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px">
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <Fields>
                <asp:BoundField DataField="الاسـم" HeaderText="الاسـم" 
                    SortExpression="الاسـم" />
                <asp:BoundField DataField="رقم الباج" HeaderText="رقم الباج" 
                    SortExpression="رقم الباج" Visible="False" />
                <asp:BoundField DataField="تاريخ المباشرة" HeaderText="تاريخ المباشرة" 
                    SortExpression="تاريخ المباشرة" DataFormatString="{0:d}" 
                    HtmlEncode="False" />
                <asp:BoundField DataField="الدائرة/القسم" HeaderText="الدائرة/القسم" 
                    SortExpression="الدائرة/القسم" />
                <asp:BoundField DataField="حالة الموظف" HeaderText="حالة الموظف" 
                    SortExpression="حالة الموظف" />
                <asp:BoundField DataField="تاريخ ترك الوظيفة" HeaderText="تاريخ ترك الوظيفة" 
                    SortExpression="تاريخ ترك الوظيفة" DataFormatString="{0:d}" 
                    HtmlEncode="False" />
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" 
                    ReadOnly="True" ShowHeader="False" SortExpression="ID" Visible="False" />
            </Fields>
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:DetailsView>
  </td>
  <td dir="rtl">
        
 
   <asp:DetailsView ID="DetailsViewInsert" runat="server" Height="147px" 
           Width="421px" AutoGenerateRows="False" DataSourceID="SDSLeaveInfo" 
           DefaultMode="Insert" 
           Font-Bold="True" CellPadding="4" GridLines="None" ForeColor="#333333" 
           Visible="False">
           <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
           <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
           <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
           <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
           <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
           <Fields>
               <asp:TemplateField HeaderText="التأريخ">
                  
                   <InsertItemTemplate>
                       <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date", "{0:d}") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVDate" runat="server" ErrorMessage="*" ControlToValidate="TextBox2" Display="Dynamic"></asp:RequiredFieldValidator>
                     <asp:CompareValidator ID="CompareValidator_checkDate" runat="server" 
                                    ErrorMessage="أدخل تاريخ فقط" ControlToValidate="TextBox2" Display="Dynamic" 
                                    Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                   
                   </InsertItemTemplate>
                   
               </asp:TemplateField>
               <asp:TemplateField HeaderText="المدة">
                  
                   <InsertItemTemplate>
                       <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Duration") %>'></asp:TextBox>
                       
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="رقم صحيح فقط" ValidationExpression="^\d+$" ControlToValidate="TextBox1" Display="Dynamic"></asp:RegularExpressionValidator>
                       <asp:RequiredFieldValidator ID="RFVDuration" runat="server" ErrorMessage="*" ControlToValidate="TextBox1" Display="Dynamic"></asp:RequiredFieldValidator>
                   </InsertItemTemplate>
                   
               </asp:TemplateField>
               <asp:BoundField DataField="Notes" HeaderText="الملاحظات" />
               <asp:BoundField DataField="OfficialOrderNumber" 
                   HeaderText="رقم الامر الاداري" />
               <asp:CommandField ShowInsertButton="True" CancelText="الغاء" 
                   InsertText="اضافة" />
           </Fields>
           <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
           <AlternatingRowStyle BackColor="White" />
       </asp:DetailsView>
       
       
       </td>
       <td>
       
    
 <asp:Panel ID="Panel1" runat="server" GroupingText="بحث رقم الباج" 
                Height="100px" Width="360px">
                <asp:Label ID="Label1" runat="server" Text="رقم الباج"></asp:Label>
                <asp:TextBox ID="TextBoxBatch" runat="server"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RFVTextBoxBatch" runat="server" ErrorMessage="?" ControlToValidate="TextBoxBatch" Display="Dynamic"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="رقم صحيح فقط" ValidationExpression="^\d+$" ControlToValidate="TextBoxBatch" Display="Static"></asp:RegularExpressionValidator>
                <asp:Button ID="Button1" runat="server" Text="بحث" />
                
            </asp:Panel>
        
    </td>
    </tr>
    </table>
    <table  class="GV">
    <tr>
    <td dir="rtl" >
  
    <asp:panel ID="GVPanel" runat="server" ScrollBars ="Vertical"
     style="height: 550px; width: 903px;" Visible="False" >
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ID" DataSourceID="SDSLeaveInfo" CellPadding="3" Height="174px" 
            style="margin-left: 0px" GridLines="Horizontal" 
            Width="903px" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" 
            BorderWidth="1px" HorizontalAlign="Center">
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" DeleteText="الغاء" />
                <asp:BoundField DataField="Duration" HeaderText="المدة" 
                    SortExpression="Duration" />
                <asp:BoundField DataField="Date" HeaderText="التاريخ" SortExpression="Date" 
                    DataFormatString="{0:d}" HtmlEncode="False" />
                <asp:BoundField DataField="Notes" HeaderText="الملاحظات" 
                    SortExpression="Notes" />
                <asp:BoundField DataField="OfficialOrderNumber" 
                    HeaderText="رقم الامر الاداري" SortExpression="OfficialOrderNumber" />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" HorizontalAlign="Center" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:GridView>
        </asp:panel> 
        
        
       
        
        </td>
    </tr>
        </table>
        
    <asp:SqlDataSource ID="SDSLeaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT LeaveInfo.ID, LeaveInfo.Date, LeaveInfo.Duration, LeaveInfo.LeaveTypeID, LeaveInfo.Notes, LeaveInfo.OfficialOrderNumber, Employee.BatchNumber, LeaveInfo.EmployeeID FROM LeaveInfo INNER JOIN Employee ON LeaveInfo.EmployeeID = Employee.ID WHERE (LeaveInfo.LeaveTypeID = 4) AND (Employee.BatchNumber = @BatchNumber)"
        DeleteCommand="DELETE FROM LeaveInfo WHERE (ID = @ID)" InsertCommand="INSERT INTO LeaveInfo(Date, Duration, LeaveTypeID, EmployeeID, Notes, OfficialOrderNumber) VALUES (@Date, @Duration,4, @EmployeeID, @Notes, @OfficialOrderNumber)"
        UpdateCommand="UPDATE LeaveInfo SET Date = @Date, Duration = @Duration, OfficialOrderNumber = @OfficialOrderNumber, Notes = @Notes WHERE (ID = @ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="DataKeys(0)" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Date" />
            <asp:Parameter Name="Duration" />
            <asp:Parameter Name="OfficialOrderNumber" />
            <asp:Parameter Name="Notes" />
            <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="DataKeys(0)" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Date" DbType="DateTime" />
            <asp:Parameter Name="Duration" />
            <asp:ControlParameter ControlID="DtlViewEmployeeInfo" Name="EmployeeID" PropertyName="DataKey(0)" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="OfficialOrderNumber" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT Employee.Name AS [الاسـم], Employee.BatchNumber AS [رقم الباج], Employee.StartDate AS [تاريخ المباشرة], Department.Name AS [الدائرة/القسم], Employee.QuitDate AS [تاريخ ترك الوظيفة], Employee.EmployeeStatus AS [حالة الموظف], Employee.ID FROM Employee INNER JOIN Department ON Employee.DepartmentID = Department.ID WHERE (Employee.BatchNumber = @BatchNumber)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT LeaveBalance.Balance, LeaveBalance.ActualLeaves, LeaveBalance.RemainingLeaves, LeaveBalance.LeaveTypeID, Employee.BatchNumber FROM LeaveBalance INNER JOIN LeaveType ON LeaveBalance.LeaveTypeID = LeaveType.ID INNER JOIN Employee ON LeaveBalance.EmployeeID = Employee.ID WHERE (LeaveBalance.LeaveTypeID =4) AND (Employee.BatchNumber = @BatchNumber)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSInsertLeaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        InsertCommand="INSERT INTO LeaveInfo(Date, Duration, LeaveTypeID, EmployeeID, Notes, OfficialOrderNumber) VALUES (@Date, @Duration,4, @EmployeeID, @Notes, @OfficialOrderNumber)"
        SelectCommand="SELECT [Date], [Duration], [LeaveTypeID], [EmployeeID], [Notes], [OfficialOrderNumber] FROM [LeaveInfo] WHERE (([EmployeeID] = @EmployeeID) AND ([LeaveTypeID] = @LeaveTypeID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="EmployeeID" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="LeaveTypeID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="Date" DbType="DateTime" />
            <asp:Parameter Name="Duration" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="OfficialOrderNumber" />
            <asp:ControlParameter ControlID="DtlViewEmployeeInfo" Name="EmployeeID" PropertyName="DataKey(0)" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
