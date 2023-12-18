cls

##後程config持ちにする
#ログインURL --ログインセッション確立の為に必須
$loginUrl="https://api.tmhub.jp/1/login"  

#ログイン時情報
$loginParams = @{
email="自分のメールアドレス"
password="パスワード"
}

#チームID
$teamId="xxxxx"

#ロケーション情報の取得
$reqURL="https://api.tmhub.jp/1/teams/${teamId}/locations"

#ログインセッション確立 必須
$ls=Invoke-WebRequest $loginUrl -body $loginParams -SessionVariable loginSession

#WebRequest
$req=Invoke-WebRequest -Method Get $reqURL -WebSession $loginSession

#contentのJsonに変換⇒Jsonから変換
#文字化けしないし、コンソールとかからは見やすい
#$req.Content | ConvertFrom-Json | ConvertTo-Json

$locJson=$req.Content | ConvertFrom-Json

#ロケーション情報
$locJson 
