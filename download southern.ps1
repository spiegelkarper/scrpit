Param ($photos)
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
    }
$counter=$counter - 1
}