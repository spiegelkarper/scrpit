function Get-Image
{
$list=Get-ChildItem C:\Users\spieg\Desktop\noella
$count=$list|Measure-Object|select -ExpandProperty count
$pict=$list[(Get-Random($count))]|select -ExpandProperty fullname
$pict
}


param ($photos=$TextBox1.Lines)
#
$split=$photos -split "/"
$name=$split[3]
[int]$counter=$split[4] -replace "fotos" -replace ".htm"
$site=$split[2]

#script
if ((test-path $name) -eq $false) {mkdir $name}
While ($counter -ge 1)
{
$prefix="";if ($counter -le 99){$prefix="0"};if ($counter -le 9){$prefix="00"}
"getting directory nr $counter"
$url="https://$site/$name/fotos$prefix$counter/"
$web=wget -Uri $url
$links=$web.Links|where innerHTML -like "*.jpg"|where innerHTML -NotLike "tn*.jpg"|select -ExpandProperty innerHTML
foreach ($link in $links)
    {
    "downloading $link"
    wget -Uri $url$link -OutFile ".\$name\$link"
    $script:PictureBox1.imageLocation = ".\$name\$link"
    $script:PictureBox1.Refresh();
    $script:PictureBox1.Update()
    }
$counter=$counter - 1
}


<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(755,599)
$Form.text                       = "Form"
$Form.TopMost                    = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "url://"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(34,15)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 518
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(30,51)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$TextBox1.Lines="hoi"

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "start"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(613,38)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$script:PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$script:PictureBox1.width               = 692
$script:PictureBox1.height              = 351
$script:PictureBox1.location            = New-Object System.Drawing.Point(30,227)
$script:PictureBox1.imageLocation       = "undefined"
$script:PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom


$Form.controls.AddRange(@($Label1,$TextBox1,$Button1,$script:PictureBox1))

$Button1.Add_MouseClick({Get-Southern})


#Write your logic code here

[void]$Form.ShowDialog()