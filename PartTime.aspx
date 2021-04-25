<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PartTime.aspx.vb"
    Inherits="LeaveSoftware.PartTime" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    <h2>
        صفحة الاجازات الزمنية</h2>
    <table class="firstPT">
        <tr class="threeBlocks" dir="rtl">
            <td>
                <asp:Panel ID="Panel1" runat="server" GroupingText="بحث رقم الباج" Height="120px"
                    Width="360px">
                    <asp:Label ID="Label1" runat="server" Text="رقم الباج"></asp:Label>
                    <asp:TextBox ID="TextBoxBatch" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RFVTextBoxBatch" runat="server" ErrorMessage="?" ControlToValidate="TextBoxBatch" Display="Dynamic"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="رقم صحيح فقط" ValidationExpression="^\d+$" ControlToValidate="TextBoxBatch" Display="Static"></asp:RegularExpressionValidator>
                    <asp:Button ID="Button1" runat="server" Text="بحث" />
                </asp:Panel>
            </td>
            <td>
                <asp:DetailsView ID="DetailsViewInsert" runat="server" Height="147px" Width="421px"
                    AutoGenerateRows="False" DataSourceID="SDSLeaveInfo" DefaultMode="Insert" CaptionAlign="Right"
                    BackColor="White" Font-Bold="True" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" GridLines="Horizontal" Visible="False">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <Fields>
                        <asp:TemplateField HeaderText="التأريخ">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date") %>'></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RFVDate" runat="server" ErrorMessage="*" ControlToValidate="TextBox2" Display="Dynamic" ForeColor="Yellow"></asp:RequiredFieldValidator>
                               <asp:CompareValidator ID="CompareValidator_checkDate" runat="server" 
                                    ErrorMessage="أدخل تاريخ فقط" ControlToValidate="TextBox2" Display="Dynamic" 
                                    Operator="DataTypeCheck" Type="Date" ForeColor="Yellow"></asp:CompareValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="المدة">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Duration") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="رقم صحيح فقط"
                                    ValidationExpression="^\d+$" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="Yellow"></asp:RegularExpressionValidator>
                           <asp:RequiredFieldValidator ID="RFVDuration" runat="server" ErrorMessage="*" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="Yellow"></asp:RequiredFieldValidator>
                           
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Notes" HeaderText="الملاحظات" />
                        <asp:BoundField DataField="OfficialOrderNumber" HeaderText="رقم الامر الاداري" />
                        <asp:CommandField ShowInsertButton="True" CancelText="الغاء" 
                            InsertText="اضافة" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:DetailsView>
            </td>
            <td>
                <asp:DetailsView ID="DtlViewEmployeeInfo" runat="server" Height="50px" Width="250px"
                    DataSourceID="SDSEmployee" DataKeyNames="ID" BackColor="White" BorderColor="#E7E7FF"
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateRows="False"
                    GridLines="Horizontal">
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
                        <asp:BoundField DataField="تاريخ ترك الوظيفة" HeaderText="تاريخ ترك الوظيفة" SortExpression="تاريخ ترك الوظيفة" />
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                            ShowHeader="False" SortExpression="ID" Visible="False" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <table class="GV">
        <tr dir="rtl">
            <td>
             <asp:panel ID="GVPanel" runat="server" ScrollBars ="Vertical"
                style="height: 550px; width: 903px;" Visible="False" >
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                    DataSourceID="SDSLeaveInfo" BackColor="White" BorderColor="#E7E7FF"
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" 
                     Width="899px">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" DeleteText="الغاء" />
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="ID" Visible="False" />
                        <asp:BoundField DataField="Date" HeaderText="التاريخ" SortExpression="Date" DataFormatString="{0:d}"
                            HtmlEncode="False" />
                        <asp:BoundField DataField="Duration" HeaderText="المدة" SortExpression="Duration" />
                        <asp:BoundField DataField="Notes" HeaderText="الملاحظات" SortExpression="Notes" />
                        <asp:BoundField DataField="OfficialOrderNumber" HeaderText="رقم الامر الاداري" SortExpression="OfficialOrderNumber" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                 </asp:panel> 
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SDSEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT Employee.Name AS [الاسـم], Employee.BatchNumber AS [رقم الباج], Employee.StartDate AS [تاريخ المباشرة], Department.Name AS [الدائرة/القسم], Employee.QuitDate AS [تاريخ ترك الوظيفة], Employee.EmployeeStatus AS [حالة الموظف], Employee.ID FROM Employee INNER JOIN Department ON Employee.DepartmentID = Department.ID WHERE (Employee.BatchNumber = @BatchNumber)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT LeaveBalance.Balance, LeaveBalance.ActualLeaves, LeaveBalance.RemainingLeaves, LeaveBalance.LeaveTypeID, Employee.BatchNumber FROM LeaveBalance INNER JOIN LeaveType ON LeaveBalance.LeaveTypeID = LeaveType.ID INNER JOIN Employee ON LeaveBalance.EmployeeID = Employee.ID WHERE (LeaveBalance.LeaveTypeID = 2) AND (Employee.BatchNumber = @BatchNumber)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSInsertLeaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        InsertCommand="INSERT INTO LeaveInfo(Date, Duration, LeaveTypeID, EmployeeID, Notes, OfficialOrderNumber) VALUES (@Date, @Duration, 2, @EmployeeID, @Notes, @OfficialOrderNumber)"
        SelectCommand="SELECT [Date], [Duration], [LeaveTypeID], [EmployeeID], [Notes], [OfficialOrderNumber] FROM [LeaveInfo] WHERE (([EmployeeID] = @EmployeeID) AND ([LeaveTypeID] = @LeaveTypeID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="EmployeeID" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter DefaultValue="2" Name="LeaveTypeID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="Date" DbType="DateTime" />
            <asp:Parameter Name="Duration" />
            <asp:ControlParameter ControlID="DtlViewEmployeeInfo" Name="EmployeeID" PropertyName="DataKey(0)" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="OfficialOrderNumber" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSLeaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT LeaveInfo.ID, LeaveInfo.Date, LeaveInfo.Duration, LeaveInfo.LeaveTypeID, LeaveInfo.Notes, LeaveInfo.OfficialOrderNumber, Employee.BatchNumber, LeaveInfo.EmployeeID FROM LeaveInfo INNER JOIN Employee ON LeaveInfo.EmployeeID = Employee.ID WHERE (LeaveInfo.LeaveTypeID = 2) AND (Employee.BatchNumber = @BatchNumber)"
        DeleteCommand="DELETE FROM LeaveInfo WHERE (ID = @ID)" InsertCommand="INSERT INTO LeaveInfo(Date, Duration, LeaveTypeID, EmployeeID, Notes, OfficialOrderNumber) VALUES (@Date, @Duration,2, @EmployeeID, @Notes, @OfficialOrderNumber)"
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
</asp:Content>
