$url="http://www.lesgalls.com/pics/bustybritain/gal8mq4j/"
$x=wget -Uri $url
$links=$x.Links|where href -like pic*.jpg|select -ExpandProperty href
foreach ($l in $links)
{
$name=($l -split "/")[8]
wget -Uri "$url$l" -OutFile "C:\Users\spieg\Desktop\nikkimay\$l"
}