<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled ..
#>

function Get-South
{
#param ($photos)
#
$split=$photos.text -split "/"
$name=$split[3]
[int]$counter=$split[4] -replace "fotos" -replace ".htm"
$site=$split[2]

#script
try {Remove-Item $name -Recurse -Force -ErrorAction stop}
catch{}
if ((test-path $name) -eq $false) {mkdir $name} 

While ($counter -ge 1)
{
$prefix="";if ($counter -le 99){$prefix="0"};if ($counter -le 9){$prefix="00"}
$ListView1.text="getting directory nr $counter"
$url="https://$site/$name/fotos$prefix$counter/"
$web=wget -Uri $url
$links=$web.Links|where innerHTML -like "*.jpg"|where innerHTML -NotLike "tn*.jpg"|select -ExpandProperty innerHTML
foreach ($link in $links)
    {
    $ListView1.text = "downloading $link"
    $SCRIPT.outfile=".\$name\$link"
    wget -Uri $url$link -OutFile $SCRIPT.outfile
    $PictureBox1.imageLocation       = $SCRIPT.outfile
    $PictureBox1.Refresh()
    }
$counter=$counter - 1
}
}



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

$photos                        = New-Object system.Windows.Forms.TextBox
$photos.multiline              = $false
$photos.width                  = 518
$photos.height                 = 20
$photos.location               = New-Object System.Drawing.Point(30,51)
$photos.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$photos.text = "test"

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "start"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(613,38)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.Add_MouseClick({Get-South})

$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 692
$PictureBox1.height              = 351
$PictureBox1.location            = New-Object System.Drawing.Point(30,227)
$PictureBox1.imageLocation       = "undefined"
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$ListView1                       = New-Object system.Windows.Forms.textbox
$ListView1.text                  = "listView"
$ListView1.Multiline             = $true
$ListView1.width                 = 517
$ListView1.height                = 88
$ListView1.location              = New-Object System.Drawing.Point(30,88)


$Form.controls.AddRange(@($Label1,$photos,$Button1,$PictureBox1,$ListView1))




#Write your logic code here

[void]$Form.ShowDialog()