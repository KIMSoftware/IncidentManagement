Imports System.Data
Imports System.Data.SqlClient
Imports System.Globalization
Imports Telerik.Web.UI


Public Class AddPersonPreRegistration
    Inherits PageBase
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.CheckForceCodeAndOrgID()

        If Not IsPostBack Then
            txtMode.Value = Request("Mode")

            If Request("PeopleID") <> "" Then
                txtPeopleID.Value = Request("PeopleID")

                Dim dstDataSet As DataSet

                dstDataSet = Me.GetPersons("", "", "", "", txtPeopleID.Value, "")

                If dstDataSet.Tables(0).Rows.Count > 0 Then
                    lblPersonName.Text = "<B>Items Pre-Registered to " & dstDataSet.Tables(0).Rows(0).Item("Forename").ToString & " " & dstDataSet.Tables(0).Rows(0).Item("Surname").ToString & "</B>"
                    txtEmailAddress.Value = dstDataSet.Tables(0).Rows(0).Item("EmailAddress").ToString
                End If

                dstDataSet.Clear()
                dstDataSet = Nothing

                LoadPeoplePreRegisteredItems(True)
                'LoadData(True)
            End If
        Else
            If txtRefresh.Value <> "" Then
                txtRefresh.Value = ""
                LoadPeoplePreRegisteredItems(True)
            End If
        End If


        If Request("PeaopleID") <> "" Then
            txtPeopleID.Value = Request("PeopleID")
        End If


    End Sub
    Sub LoadPeoplePreRegisteredItems(Optional ByVal reBind As Boolean = False)


        Dim dstDataSet As DataSet

        dstDataSet = Me.GetPreRegisteredItems(txtEmailAddress.Value)
        If dstDataSet IsNot Nothing Then
            RadGridPreRegisteredItems.DataSource = dstDataSet
            dstDataSet.Dispose()
        End If

        If reBind Then RadGridPreRegisteredItems.Rebind()

    End Sub
    Private Sub RadGridPreRegisteredItems_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles RadGridPreRegisteredItems.NeedDataSource
        LoadPeoplePreRegisteredItems(False)
    End Sub

    Sub RadGridPreRegisteredItems_ItemDataBound(ByVal s As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RadGridPreRegisteredItems.ItemDataBound

        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then

            Dim editableItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

            Dim txtCategoryID As HiddenField = CType(editableItem.FindControl("txtCategoryID"), HiddenField)
            Dim cboCategory As DropDownList = e.Item.FindControl("cboCategory")


            Dim dstDataReader As DataSet
            dstDataReader = Me.GetCategory(0)
            cboCategory.DataSource = dstDataReader
            cboCategory.DataTextField = "CategoryName"
            cboCategory.DataValueField = "CategoryID"

            cboCategory.DataBind()
            cboCategory.SelectedValue = txtCategoryID.Value

            dstDataReader = Nothing


        End If

        ' If TypeOf e.Item Is GridDataItem Then

        'End If

    End Sub


End Class