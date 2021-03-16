
param(
    [string]$tagConnectionString="Data Source=SQL_SERVER;Initial Catalog=STAGING;Integrated Security=True;",
    [string]$tagQuery="SELECT * FROM TAG T WHERE DATEADD(MINUTE, T.LOAD_FREQUENCY_MINS, COALESCE(T.LAST_LOAD_DT, '01-JAN-2000')) < GETDATE() AND SOURCE = 'FT' AND ENABLED_FLAG = 1",
    [string]$dataConnectionString="Data Source=FTHISTORIAN\FTHISTORIAN;Initial Catalog=tempdb;Integrated Security=SSPI;",
    [string]$dataQuery = "SELECT TOP 1000 TAG, TIME, _INDEX, VALUE, STATUS, QUESTIONABLE, SUBSTITUTED, ANNOTATED, ANNOTATIONS FROM FTHISTORIAN.piarchive..picomp2 WHERE TAG = @TAG AND TIME >= COALESCE(@MAX_DATA_DT, GETDATE()-7) ORDER BY TIME"
)

#################################
## Executes an SQL query
#################################
function Exec-Sql-Query {
    param(
        [string] $connectionString = $(throw "Please specify a connection string."),
        [string] $query = $(throw "Please specify a query."),
        $parameters=@{}
      )

    # Create Sql Connection
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connectionString

    # Create Sql Command
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = $query
    $SqlCmd.Connection = $SqlConnection
    $SqlCmd.CommandTimeout = 3600
    $SqlCmd.Connection.Open()

    # Parameters?
    foreach($p in $parameters.Keys){
        [Void] $SqlCmd.Parameters.AddWithValue("@$p",$parameters[$p])
    }

    # Create Sql Data Adapter
    $adapter = New-Object System.Data.sqlclient.SqlDataAdapter $SqlCmd
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataSet) | Out-Null

    # Return tables
    $dataSet

    $SqlConnection.Close()
}


#################################
## Main Routine
#################################
function Main {

    # get the tag list
    $tags = Exec-Sql-Query -connectionString $tagConnectionString -query $tagQuery

    $data = @()

    foreach ($row in $tags.Tables[0]) {
        $tag = $row.TAG
        $maxDataDt = $row.MAX_DATA_DT

        # Get data for each tag. Data is indexed by Tag, so must loop by tag for performance reasons
        $dataset = Exec-Sql-Query -connectionString $dataConnectionString -query $dataQuery -parameters @{TAG=$tag; MAX_DATA_DT=$maxDataDt}
        $formatted = $dataset.Tables[0].Rows | Select   TAG, TIME, _INDEX, VALUE, STATUS, QUESTIONABLE, SUBSTITUTED, ANNOTATED, ANNOTATIONS
        $data = $data + $formatted
    }
    $data
}
Main