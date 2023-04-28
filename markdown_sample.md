# 見出し
## 見出し2
### 見出し3
#### 見出し4
##### 見出し5
###### 見出し6

# リスト
## 順序指定なし
- aaa
  - 111
  - 222
  - 333
    - あああ
    - いいい
    - ううう
- bbb
- ccc

## 順序指定あり、なし混合
1. aaa
   1. 111
   2. 222
   3. 333
      - あああ
      - いいい
      - ううう
2. bbb
3. ccc

# タスクリスト
- [ ] aaa
- [x] bbb
- [ ] ccc

# 強調
This is *italic* text.

This is also _italic_ text.

これは**太字**です
 
これも__太字__です

これは ~~打消し~~ です。

# 引用
> 引用

# リンク
[リンク](https://www.google.com/)

# 画像
![画像名](ER.png)

# テーブル
a|b|c
---|---|---
1|2|3
4|5|6
7|8|9
10|11|12

# コード
```rb
class ApplicationController < ActionController::Base
  # code sample
end
```

# インラインコード
コードは `sample` このように表示されます。

# 折りたたみ
<details>
<summary>xxx</summary>
aaaaaaaaaaaaaaaaaaaaa
bbbbbbbbbbbbbbbbbbb
ccccccccccccccccccccc
</details>

# 数式
$$ x = {-b \pm \sqrt{b^2-4ac} \over 2a} $$