$Status = [ZbxStatus]::Enabled
$Inventory = @{}

$Hostgroupid=15
$TemplateId=10186
$ProxyId=10294


      if ($Hostgroupid -ne $null)
    {
        $HostGroup = @()
        $HostGroupId |% { $HostGroup += @{"groupid" = $_} }
    }
    if ($TemplateId -ne $null)
    {
        $Template = @()
        $TemplateId |% { $Template += @{"templateid" = $_} }
    }
  
        $prms = @{
        host = "Kirillica"
        name = $string
        description = ""
        interfaces = @( @{
            type = 1
            main = 1
            useip = 1
            dns = ""
            ip = "10.10.10.1"
            port = 10050
        })
        groups = $HostGroup
        templates = $Template
        inventory_mode = 0
        inventory = $Inventory
        status = [int]$Status
        proxy_hostid = if ($ProxyId -eq $null) { "" } else { $ProxyId }
        }

    $r = Invoke-ZabbixApi $session "host.create" $prms
    Get-Host -session $s -Id $r.hostids


