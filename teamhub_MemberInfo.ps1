
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

#メンバー情報のリスト
$reqURL="https://api.tmhub.jp/1/teams/${teamId}/teamMembersAndGuestsByTypes"

#ログインセッション確立 必須
$ls=Invoke-WebRequest $loginUrl -body $loginParams -SessionVariable loginSession

#WebRequest
$req=Invoke-WebRequest -Method Get $reqURL -WebSession $loginSession

#変数定義
$members=$null

#contentのJsonに変換⇒Jsonから変換
#文字化けしないし、コンソールとかからは見やすい
#$req.Content | ConvertFrom-Json | ConvertTo-Json

#メンバー情報を格納
#NotePropertyでごにょごにょしているのは、MemberTypeをNotePropertyで絞り
#SysytemPropertyの取得を防ぐため。
$reqJson=$req.Content | ConvertFrom-Json
$memberType=$reqJson | get-member | Where-Object {$_.MemberType -eq "NoteProperty"}
foreach ( $mType in $MemberType ) { $members += $reqJson.($mType.Name) }


#出力 後で情報をファイルにアウトプットする
$members
