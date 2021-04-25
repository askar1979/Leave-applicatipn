<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="InsertInitialValues.aspx.vb"
    Inherits="LeaveSoftware.InsertInitialValues" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContent" runat="server">
    <h2>
        صفحة اضافة قيمة ابتدائية</h2>
    <table class="firstIIV" >
        <tr class="threeBlocks_initial" dir="rtl">
            <td>
                <asp:Panel ID="Panel1" runat="server" GroupingText="بحث رقم الباج" Height="100px"
                    Width="300px">
                    <asp:Label ID="Label1" runat="server" Text="رقم الباج"></asp:Label>
                    <asp:TextBox ID="TextBoxBatch" runat="server"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="بحث" />
                    <br />  
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                    <asp:Label ID="lblCheck" runat ="server" Text ="اجازة بدون راتب"></asp:Label>
                    <asp:Button ID="Checked" runat ="server" Text ="تغيير حالة" />
                    </asp:Panel>
              
            </td>
            <td>
                <asp:DetailsView ID="DtlViewEmployeeInfo" runat="server" Height="40px" Width="395px"
                    DataSourceID="SDSEmployee" DataKeyNames="ID" BackColor="White" BorderColor="#E7E7FF"
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateRows="False"
                    GridLines="Horizontal" Style="margin-right: 0px" Visible="False">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" VerticalAlign="Middle" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <Fields>
                        <asp:BoundField DataField="الاسـم" HeaderText="الاسـم" SortExpression="الاسـم" />
                        <asp:BoundField DataField="رقم الباج" HeaderText="رقم الباج" SortExpression="رقم الباج" />
                        <asp:BoundField DataField="تاريخ المباشرة" HeaderText="تاريخ المباشرة" SortExpression="تاريخ المباشرة"
                            DataFormatString="{0:d}" HtmlEncode="False" />
                        <asp:BoundField DataField="الدائرة/القسـم" HeaderText="الدائرة/القسـم" SortExpression="الدائرة/القسـم" />
                        <asp:BoundField DataField="تاريخ ترك الوظيفة" HeaderText="تاريخ ترك الوظيفة" SortExpression="تاريخ ترك الوظيفة" />
                        <asp:BoundField DataField="حالة الموظف" HeaderText="حالة الموظف" SortExpression="حالة الموظف" />
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                            ShowHeader="False" SortExpression="ID" Visible="False" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:DetailsView>
            </td>
            <td>
                <asp:DetailsView ID="DetailsViewInsertInitialValues" runat="server" Height="50px"
                    Width="390px" AutoGenerateRows="False" CellPadding="4"
                    DataKeyNames="ID" DataSourceID="SDSInsertBalance" DefaultMode="Insert" Font-Bold="True"
                    GridLines="None">
                    <FooterStyle BackColor="#507000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                    <RowStyle BackColor="#EEEE00" ForeColor="Black" />
                    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                    <PagerStyle BackColor="#999000" ForeColor="Black" HorizontalAlign="Center" />
                    <Fields>
                        <asp:TemplateField HeaderText="نوع الاجازة" SortExpression="ID">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DDLLeaveType" runat="server" DataSourceID="SDSLeaveType" DataTextField="Name"
                                    DataValueField="ID" SelectedValue='<%# Bind("LeaveTypeID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="الرصيد الكلي" SortExpression="Balance">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Balance") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="رقم صحيح فقط"
                                    ValidationExpression="^\d+$" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="White"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ايام الاجازات" SortExpression="ActualLeaves">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ActualLeaves") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="رقم صحيح فقط"
                                    ControlToValidate="TextBox2" ValidationExpression="^\d+$" Display="Dynamic" EnableClientScript="True" ForeColor="White"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="المتبقي من الرصيد" SortExpression="RemainingLeaves">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RemainingLeaves") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="رقم صحيح فقط"
                                    ControlToValidate="TextBox3" ValidationExpression="^\d+$" Display="Dynamic" ForeColor="White"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField CancelText="الغاء" InsertText="اضافة" 
                            ShowInsertButton="True" />
                    </Fields>
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            </td>
           
        </tr>
    </table>
    <asp:SqlDataSource ID="SDSInsertBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        InsertCommand="insertBalance" InsertCommandType="StoredProcedure" SelectCommand="select * from [LeaveBalance]">
        <InsertParameters>
            <asp:ControlParameter ControlID="DtlViewEmployeeInfo" Name="EmployeeID" PropertyName="DataKey(0)"
                Type="Int32" />
            <asp:Parameter Name="LeaveTypeID" Type="Byte" />
            <asp:Parameter Name="Balance" Type="Int16" />
            <asp:Parameter Name="ActualLeaves" Type="Int16" />
            <asp:Parameter Name="RemainingLeaves" Type="Int16" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT Employee.Name AS الاسـم, Employee.BatchNumber AS [رقم الباج], Employee.StartDate AS [تاريخ المباشرة], Department.Name AS [الدائرة/القسـم], Employee.QuitDate AS [تاريخ ترك الوظيفة], Employee.EmployeeStatus AS [حالة الموظف], Employee.ID FROM Employee INNER JOIN Department ON Employee.DepartmentID = Department.ID WHERE (Employee.BatchNumber = @BatchNumber)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxBatch" Name="BatchNumber" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDSLeaveType" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_DBConnectionString %>"
        SelectCommand="SELECT * FROM [LeaveType]"></asp:SqlDataSource>
</asp:Content>
