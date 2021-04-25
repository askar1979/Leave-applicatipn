<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="All_Leaves_Report.aspx.vb"
    Inherits="LeaveSoftware.All_Leaves_Report" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    <h2>
        صفحة كل الاجازات لموظف
    </h2>
    <table class="firstReport" align="center">
        <tr>
            <td dir="rtl" valign="top">
                <asp:DetailsView ID="DtlViewEmployeeInfo" runat="server" Height="72px" Width="250px"
                    DataSourceID="SDSEmployee" DataKeyNames="ID" CellPadding="3" AutoGenerateRows="False"
                    GridLines="Horizontal" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"
                    BorderWidth="1px">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <Fields>
                        <asp:BoundField DataField="الاسـم" HeaderText="الاسـم" SortExpression="الاسـم" />
                        <asp:BoundField DataField="رقم الباج" HeaderText="رقم الباج" SortExpression="رقم الباج"
                            Visible="False" />
                        <asp:BoundField DataField="تاريخ المباشرة" HeaderText="تاريخ المباشرة" SortExpression="تاريخ المباشرة"
                            DataFormatString="{0:d}" HtmlEncode="False" />
                        <asp:BoundField DataField="الدائرة/القسم" HeaderText="الدائرة/القسم" SortExpression="الدائرة/القسم" />
                        <asp:BoundField DataField="حالة الموظف" HeaderText="حالة الموظف" SortExpression="حالة الموظف" />
                        <asp:BoundField DataField="تاريخ ترك الوظيفة" HeaderText="تاريخ ترك الوظيفة" SortExpression="تاريخ ترك الوظيفة"
                            DataFormatString="{0:d}" HtmlEncode="False" />
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                            ShowHeader="False" SortExpression="ID" Visible="False" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:DetailsView>
            </td>
           
            <td bgcolor="#E7E7FF" valign="bottom" align="right">
                <asp:Panel ID="Panel1" runat="server" Height="100px" Width="350px" HorizontalAlign="Center">
                    <asp:Label ID="Label1" runat="server" Text="رقم الباج" Font-Size="Large"></asp:Label>
                 
                 <asp:TextBox ID="TextBoxBatch" runat="server" Height="23px" AutoPostBack="false"></asp:TextBox>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator_TextBoxBatch" runat="server" ErrorMessage="رقم صحيح فقط"
                    ValidationExpression="^\d+$" ControlToValidate="TextBoxBatch" Display="Dynamic" ForeColor="Red" Font-Bold="true"></asp:RegularExpressionValidator>
                     <asp:RequiredFieldValidator ID="RFV_TextBoxBatch" runat="server" ErrorMessage="*" 
                    ControlToValidate ="TextBoxBatch" Display="Dynamic" ForeColor ="Red"></asp:RequiredFieldValidator>
                   
                    <asp:Button ID="Button1" runat="server" Text="بحث" Font-Size="Large"/>
                   
                   
                   
                    <asp:Button ID="btnShowreport" runat="server" Text="اظهارالاجازات" Font-Size="Large"
                        Width="104px" />
                    <asp:Button ID="btnExcel" runat="server" Text="اكسل" Font-Size="Large" Width="75px" />
                    
                    </asp:Panel>
               </td>
            
        </tr>
    </table>
    
    <table class="GV_AllLeaves">
        <tr>
            <td dir="rtl">
                <asp:Panel ID="GVPanel" runat="server" ScrollBars="Vertical" Style="height: 550px;
                    width: 1000px;" Visible="False">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                        CellPadding="3" Height="174px" Style="margin-left: 0px" GridLines="Horizontal"
                        Width="950px" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center" Visible="False">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="الاسم" />
                            <asp:BoundField DataField="نوع الاجازة" HeaderText="نوع الاجازة" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="التاريخ" HtmlEncode="False"
                                SortExpression="Date" />
                            <asp:BoundField DataField="Duration" HeaderText="المدة" SortExpression="Duration" />
                            <asp:BoundField DataField="OfficialOrderNumber" HeaderText="رقم الامر الاداري" SortExpression="OfficialOrderNumber" />
                            <asp:BoundField DataField="BatchNumber" HeaderText="رقم الباج" />
                            <asp:BoundField DataField="Notes" HeaderText="الملاحظات" SortExpression="Notes" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SDSLeaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT LeaveInfo.Date, LeaveInfo.Duration, LeaveInfo.Notes, LeaveInfo.OfficialOrderNumber, Employee.BatchNumber, LeaveInfo.EmployeeID FROM LeaveInfo INNER JOIN Employee ON LeaveInfo.EmployeeID = Employee.ID WHERE (LeaveInfo.LeaveTypeID = 1) AND (Employee.BatchNumber = @BatchNumber)"
        DeleteCommand="DELETE FROM LeaveInfo WHERE (ID = @ID)" InsertCommand="INSERT INTO LeaveInfo(Date, Duration, LeaveTypeID, EmployeeID, Notes, OfficialOrderNumber) VALUES (@Date, @Duration, 1, @EmployeeID, @Notes, @OfficialOrderNumber)"
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
            <asp:Parameter Name="Date" />
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
</asp:Content>
