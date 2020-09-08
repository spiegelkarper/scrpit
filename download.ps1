[int]$n=1
while ($n -le 199)
{
[string]$s=$n
#if ($s.Length -eq 1) {$s="00"+$s}
#if ($s.Length -eq 2) {$s="0"+$s}
$a="https://ip173084097.ahcdn.com/key=RariFUGLhc0ltMZtCH9fmg,s=,end=1594195200,limit=3/data=62.163.1.210/state=PqMB/reftag=78545578/media=hlsA/1/21/8/209672838.mp4/seg-$n-v1-a1.ts"
& 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe' $a;
sleep -Milliseconds 400;
$n=$n+1

}
