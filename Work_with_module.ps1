$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$PSDefaultParameterValues['*:Encoding'] = 'iso-8859-1'

[System.Text.Encoding]::Default.Codepage
$OutputEncoding = [System.Text.Encoding]::Unicode
$OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")
$OutputEncoding = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$OutputEncoding = [System.Text.Encoding]::GetEncoding("iso-8859-5")
$OutputEncoding = [System.Text.Encoding]::GetEncoding("windows-1251")
$OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)
$OutputEncoding = [System.Text.Encoding]::ASCII


$OutputEncoding = New-Object -typename System.Text.UTF8Encoding
[Console]::OutputEncoding = New-Object -typename System.Text.UTF8Encoding

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::ASCII


[Console]::InputEncoding = [System.Text.Encoding]::UTF8




Import-Module C:\Zabbix_PSModules_API\PSZabbix-master\PSZabbix.psm1
New-ApiSession -ApiUri http://10.42.10.11/api_jsonrpc.php -auth (Get-Credential)


Invoke-ZabbixApi -method item.get

# New-ZabbixHost -HostName Ping_OVPN_tunnel_ART-SLN-GT_VLK-ENS-GT -IP 10.10.10.1 -GroupID 15 -TemplateID 10186

New-Host -Name Ping_OVPN_tunnel_ART-SLN-GT_VLK-ENS-GT -VisibleName "ICMP PING �����, ���������, 46 -> �����������, ����������, 23�" -HostGroupId 15 -TemplateId 10186 -ProxyId 10294 -Dns "10.10.10.1"
New-Host -Name Ping_OVPN_tunnel_ART-SLN-GT_VLK-ENS-GT -VisibleName 'ICMP PING �����, ���������, 46 -> �����������, ����������, 23�' -HostGroupId 15 -TemplateId 10186 -ProxyId 10294 -Dns "10.10.10.1" 
New-Host -Name Ping_OVPN_tunnel_ART-SLN-GT_VLK-ENS-GT -VisibleName $string -HostGroupId 15 -TemplateId 10186 -ProxyId 10294 -Dns "10.10.10.1" 
# 10482

# "Gateway" GroupID = 15
# "Template Module ICMP Ping" TemplateID = 10186
# "Proxy_ART-SLN-GT" Proxy = 10294



[System.Text.Encoding]::GetEncoding
((Get-Host)[105].Name)




#####################################################################################################################################



������, ��� ������ ��� ��� ��������, ��������, ����� � � ����� ������ ��������:
function convertto-encoding ([string]$from, [string]$to){
    begin{
       $encfrom = [system.text.encoding]::getencoding($from)
       $encto = [system.text.encoding]::getencoding($to)
   }
   process{
       $bytes = $encto.getbytes($_)
       $bytes = [system.text.encoding]::convert($encfrom, $encto, $bytes)
       $encto.getstring($bytes)
   }
}

������������ ���:

$string = $source | convertto-encoding "cp866" "utf-8"
$source | convertto-encoding "koi8-r" "utf-8"
$source | convertto-encoding "koi8-u" "utf-8"
$source | convertto-encoding "utf-8" "koi8-r"
$source | convertto-encoding "koi8-r" "iso-8859-5"
$source | convertto-encoding "koi8-r" "utf-7"
$source | convertto-encoding "windows-1251" "iso-8859-5"
$source | convertto-encoding "utf-8" "iso-8859-5"




$Hosts=Get-Host -Name "*��������*"

$Hosts=$Hosts[4,5]

ICMP PING �����������, 100-��� ������������, �. 28 <- �����������, ����������, 23�  10457
ICMP PING �����������, �����������, 26/28 <- �����������, ����������, 23�           10458




($NewHost | ConvertTo-Json) | FL




####################################################################
# ���� ����� ������ ������� � ���� JSON.txt � �������� � �������. 
# ����� ��� ���� ����� ����� ��� ����� ���� ��������� � ������ ����� �� ����� � ������� JSON. �� ����������� ��� ���� ��� ��������� ������ � ����� ������� � �������
# ������������� �������� $JSON=Get-Content .\JSON.txt | ConvertFrom-Json
####################################################################

$parameters+=
{
   "jsonrpc": "2.0",
   "method": "method.name",
   "params": {
      "param_1_name": "param_1_value",
      "param_2_name": "param_2_value"
   },
   "id": 1,
   "auth": "159121b60d19a9b4b55d49e30cf12b81"
}

######################################################################



# ��������� ������ ��� JSON � ���������� ��� � REST ����� ����� Invoke-RestMethod
# �� �������� ��� ��� ���� ����� ����� ��������� ��������� ��� ���� ������ ������ $session 
New-JsonrpcRequest -method $JSON.method -params $JSON.params -auth $session.Auth
Invoke-RestMethod -Uri $session.Uri -Method Post -ContentType "application/json; charset=UTF-8" -Body (New-JsonrpcRequest -method $JSON.method -params $JSON.params -auth $session.Auth)


# �������� REST ����� �� ������� ����������� � zabbix API � ������� ��� � ���������� $r
$r = Invoke-RestMethod -Uri $ApiUri -Method Post -ContentType "application/json" -Body (new-JsonrpcRequest "user.login" @{user = $auth.UserName; password = $auth.GetNetworkCredential().Password})

# ��������� ���������� ����������� ������ ��������. ������� �� ������� ��� � ������
$script:latestSession = @{Uri = $ApiUri; Auth = $r.result}
$session = $latestSession


# 09.11.2020 (����� ��� ���������������� ������. �������� ������� �������� �������, �������� ��������������)

foreach ($ZbxHost in $Hosts) {
    $JSON.params.hostid = $ZbxHost.hostid
    $JSON.params.name = $ZbxHost.name -replace "��������","���" -replace "�����","���" -replace "������� ������","�-���" -replace "","" -replace "�������������","���" -replace "�������","���" -replace "�-����������","�-���" -replace "����������","���" -replace "���������","���" -replace "������","���" -replace "�-���������","�-���"
    Invoke-RestMethod -Uri $session.Uri -Method Post -ContentType "application/json; charset=UTF-8" -Body (New-JsonrpcRequest -method $JSON.method -params $JSON.params -auth $session.Auth)
}



