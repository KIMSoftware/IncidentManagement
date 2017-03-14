<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddPersonPreRegistration.aspx.vb" Inherits="IncidentManagement.web.AddPersonPreRegistration" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html >
<head runat="server">
    <title></title>
    
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="Styles/IncidentManagement.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
    <script src="Scripts/jquery.min.js" type="text/javascript" ></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">
       
        function close_iframe() {
           
            
            //No Refresh for Parent Frame
            $(parent.document).find("#iDiv").hide();
            $(parent.document).find('#iframe_table').hide();
            $(parent.document).find("#blackout").hide();
            $(parent.document.body).css("backgroundColor", "white");
            $(parent.document).find("#divMainScreen").show();

            

        }

          
       
        function showMyDialog(frameSrcURL, frameHeight, frameWidth) {

            var rtn

            $('#iframe_table').show();//.style.display = "block";
            $('#iDiv').show();//.style.display = "block";

            var widthOfFrame, heightOfFrame;
            if (frameWidth != undefined && isNaN(frameWidth) == false) {
                widthOfFrame = frameWidth;
            }
            else { widthOfFrame = "900"; }
            if (frameHeight != undefined && isNaN(frameHeight) == false) {
                heightOfFrame = frameHeight;
            }
            else { heightOfFrame = "550"; }

            rtn = "<iframe frameborder='1' scrolling='no' class='iframe'";
            rtn += "width='600px'";
            rtn += "height='450px'";
            rtn += "src='" + frameSrcURL + "'></iframe>";

            //document.getElementById('PersonSearch').innerHTML = rtn;
            $('#iDiv').html(rtn);
        }

    </script>
     
</head>
<body>
    <form id="frmPeoplePreRegistration" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadToolTipManager ID="RadToolTipManager2" runat="server" RelativeTo="Element" Position="TopRight" AutoTooltipify="true" ContentScrolling="Default" Width="150" Height="10">
        </telerik:RadToolTipManager>

<%--        <asp:HiddenField ID="txtUserID" runat="server" />
        <asp:HiddenField ID="txtIncidentID" runat="server" />
        --%>
        <asp:HiddenField ID="txtMode" runat="server" />
        <asp:HiddenField ID="txtPeopleID" runat="server" />
        <asp:HiddenField ID="txtRefresh" runat="server" />
        <asp:HiddenField ID="txtEmailAddress" runat="server" />

         <div id="divMainScreen" class="MainScreen">
             <center>
       
                <input type="button" id="btnClose" value="Close" style="width:150px;" runat="server" title="Close" onclick="javascript: close_iframe();"  class="ButtonClassSmall" />

                <br />
                <br />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
         
                <table width="100%" border="0" cellpadding="1" cellspacing="1">
              
                    <tr style="height: 10px">
                        <td class="Labels" align="left" colspan="8" style="background-color: #dcdcdc"><b><asp:Label ID="lblPersonName" CssClass="Labels" runat="server"></asp:Label></b></td>
                    </tr>
                  
                </table>
        
                <telerik:RadGrid
                    ID="RadGridPreRegisteredItems"
                    Width="99%"
                    runat="server"
                    ActiveItemStyle-CssClass="GridActiveItem" 
                    SelectedItemStyle-CssClass="GridSelectedItem"
                    Skin="Office2010Blue" 
                    AllowPaging="false"
                    OnItemDataBound="RadGridPreRegisteredItems_ItemDataBound"
                    AutoGenerateColumns="false" 
                    AllowSorting="false" 
                    ShowStatusBar="true" 
                    GridLines="Both">


                    <ClientSettings EnableRowHoverStyle="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>

                    <MasterTableView AutoGenerateColumns="False" PagerStyle-Position="TopAndBottom" DataKeyNames="RegistrationItemID" Width="100%" EditMode="InPlace" CommandItemDisplay="TopAndBottom" EditFormSettings-EditColumn-InsertText="Add">
                        <CommandItemSettings ShowAddNewRecordButton="false" />
                        <CommandItemSettings ShowRefreshButton="true"  />

                        <Columns>
                            <telerik:GridBoundColumn DataField="RegistrationItemID" UniqueName="RegistrationItemID" HeaderText="RegistrationItemID" Visible="false" ReadOnly="true" ItemStyle-HorizontalAlign="Left" />

                           <telerik:GridTemplateColumn  DataField="CategoryName"  UniqueName="Category"  HeaderText="Category" ShowSortIcon="true" SortExpression="CategoryName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "CategoryName")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                 
                                    <asp:HiddenField ID="txtCategoryID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CategoryID")%>' />
                                    <asp:DropDownList ID="cboCategory" CssClass="EditableTextBox" runat="server" Width="100px" AppendDataBoundItems="true">
                                        <asp:ListItem Value=""></asp:ListItem>
                                    </asp:DropDownList>

                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn  DataField="Make"  UniqueName="Make"  HeaderText="Make" ShowSortIcon="true" SortExpression="Make" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Make")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMake" CssClass="EditableTextBox" MaxLength="20" Width="100px"  Value='<%# DataBinder.Eval(Container.DataItem, "Make")%>' runat="server"/>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn  DataField="Model"  UniqueName="Model"  HeaderText="Model" ShowSortIcon="true" SortExpression="Model" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Model")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtModel" CssClass="EditableTextBox" MaxLength="20" Width="100px"  Value='<%# DataBinder.Eval(Container.DataItem, "Model")%>' runat="server"/>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn  DataField="Colour"  UniqueName="Colour"  HeaderText="Colour" ShowSortIcon="true" SortExpression="Colour" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Colour")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtColour" CssClass="EditableTextBox" MaxLength="20" Width="100px"  Value='<%# DataBinder.Eval(Container.DataItem, "Colour")%>' runat="server"/>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn  DataField="Description"  UniqueName="Description"  HeaderText="Description" ShowSortIcon="true" SortExpression="Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Description")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" CssClass="EditableTextBox" MaxLength="100" Width="150px"  Value='<%# DataBinder.Eval(Container.DataItem, "Description")%>' runat="server"/>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                              <telerik:GridTemplateColumn  DataField="Serial1"  UniqueName="Serial1"  HeaderText="Serial1" ShowSortIcon="true" SortExpression="Serial1" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Serial1")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSerial1" CssClass="EditableTextBox" MaxLength="20" Width="100px"  Value='<%# DataBinder.Eval(Container.DataItem, "Serial1")%>' runat="server"/>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="" UniqueName="" HeaderText="" HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" ItemStyle-Width="90px">
                                <ItemTemplate>
                                    <img id="imgPhoto" style="width:80px;height:80px;" src='<%# DataBinder.Eval(Container.DataItem, "AzureFileName")%>' runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                       
                        </Columns>

                    </MasterTableView>

                    <HeaderContextMenu FeatureGroupID="rghcMenu">
                    </HeaderContextMenu>

                </telerik:RadGrid>
                     
                </center>  
         </div>
        
            
        

   
        <table id="iframe_table" style="position: absolute; top:10%; left:10%; height:550px; width:70%; text-align:center; display:none;">
            <tr>
                <td></td>
                <td style="width:100%;" align="center">

                <br />

                
                <div id="iDiv" style="height:550px; width:900px; display:none;">
                    
                </div>


                </td>
                <td></td>
            </tr>
        </table>
          

    </form>
</body>
</html>
