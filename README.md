# Security Tools Container 🛡️

Ryzen搭載ノートPC向けの軽量セキュリティツールコンテナ環境です。Kali Linuxベースで構築されており、ペネトレーションテストや脆弱性診断に必要な基本的なツールを含んでいます。

## ✨ 特徴

- 🚀 **軽量設計**: 必要最小限のツールのみを厳選してインストール
- 🇯🇵 **高速ビルド**: 日本国内ミラーサーバー（理研）を使用
- 🔧 **AMD64最適化**: Ryzen CPU向けに最適化された構成
- 🖥️ **GUI対応**: WiresharkなどのGUIツールをX11フォワーディングで実行可能

## 🛠️ 含まれるツール

| カテゴリ | ツール | 説明 |
|---------|--------|------|
| **ネットワーク** | `nc` (netcat), `telnet` | ネットワーク接続・ポートスキャン |
| **パスワード解析** | `john`, `zip2john` | パスワードクラッキング・ハッシュ解析 |
| **ファイル解析** | `exiftool`, `binwalk`, `file` | メタデータ抽出・バイナリ解析 |
| **バイナリ操作** | `strings`, `hexdump`, `xxd` | 16進ダンプ・文字列抽出 |
| **ステガノグラフィ** | `steghide` | 隠蔽データの埋め込み・抽出 |
| **デバッグ** | `gdb` | バイナリデバッグ |
| **ネットワーク解析** | `wireshark` | パケットキャプチャ・プロトコル解析 |
| **基本ツール** | `unzip`, `md5sum` | ファイル操作・ハッシュ計算 |

## 📋 前提条件

- Docker
- Docker Compose (v2)
- X11環境（GUIツール使用時）
- 2GB以上の空きメモリ

## 🚀 クイックスタート

### 1. リポジトリのクローン

```bash
git clone https://github.com/yutakodera/docker-lightweight-kali.git
cd docker-lightweight-kali
```

### 2. コンテナのビルドと起動

```bash
docker compose up --build -d
```

### 3. コンテナへの接続

```bash
docker compose exec kali bash
```

## 🎯 使用例

### ネットワークツール
```bash
# ポートスキャン
nc -zv target-host 80 443

# Telnet接続
telnet example.com 80
```

### パスワード解析
```bash
# ZIP暗号化ファイルの解析
zip2john encrypted.zip > hash.txt
john hash.txt
```

### ファイル解析
```bash
# メタデータ抽出
exiftool image.jpg

# バイナリ解析
binwalk firmware.bin

# 16進ダンプ
xxd file.bin | head
```

### ステガノグラフィ
```bash
# 画像にデータを隠す
steghide embed -cf image.jpg -ef secret.txt

# 隠されたデータを抽出
steghide extract -sf image.jpg
```

### Wireshark（GUI）
```bash
# X11フォワーディングを有効化
xhost +local:docker

# Wiresharkを起動
wireshark &
```

## 📁 ファイル構成

```
docker-lightweight-kali/
├── Dockerfile     # Kali軽量版Dockerfile
├── docker-compose.yml  # Docker Compose設定
├── workspace/               # 作業ディレクトリ（作成要）
└── README.md               # このファイル
```

## 🔧 カスタマイズ

### 追加ツールのインストール
`Dockerfile`の`RUN apt-get install`セクションに追加パッケージを記述：

```Dockerfile
RUN apt-get install -y --no-install-recommends \
    your-additional-tool \
    another-tool
```

### リソース制限の変更
`docker-compose.yml`の設定を調整：

```yaml
mem_limit: 4g      # メモリ制限
cpus: '4.0'        # CPU制限
```

## 🐛 トラブルシューティング

### WiresharkのGUIが表示されない
```bash
# X11権限を確認
echo $DISPLAY
xhost +local:docker

# テスト用アプリで確認
docker exec -it kali xauth
```

### パッケージインストールエラー
```bash
# キャッシュクリア後に再ビルド
docker system prune -f
docker build --no-cache -t kali .
```

### メモリ不足エラー
```bash
# 現在の使用量を確認
docker stats
```

## 🔒 セキュリティ注意事項

⚠️ **重要**: このコンテナには強力なセキュリティツールが含まれています

- 適切な権限管理の下で使用してください
- 承認された環境でのみ使用してください
- 本番環境では不要な権限を削除してください

## 📝 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 🙏 謝辞

- [Kali Linux](https://www.kali.org/) - セキュリティツールの提供
- [理化学研究所](https://www.riken.go.jp/) - 高速ミラーサーバーの提供

---

**⭐ このプロジェクトが役に立った場合は、スターを付けていただけると嬉しいです！**