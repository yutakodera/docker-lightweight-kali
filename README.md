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
- Docker Compose
- X11環境（GUIツール使用時）
- 2GB以上の空きメモリ

## 🚀 クイックスタート

### 1. リポジトリのクローン

```bash
git clone https://github.com/yourusername/security-tools-container.git
cd security-tools-container
```

### 2. 作業ディレクトリの作成

```bash
mkdir workspace
```

### 3. コンテナのビルドと起動

```bash
docker build -f kali-light-dockerfile -t kali-security:light .
docker-compose -f kali-docker-compose.yml up -d
```

### 4. コンテナへの接続

```bash
docker-compose -f kali-docker-compose.yml exec kali-security-tools bash
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
security-tools-container/
├── kali-light-dockerfile     # Kali軽量版Dockerfile
├── kali-docker-compose.yml  # Docker Compose設定
├── workspace/               # 作業ディレクトリ（作成要）
└── README.md               # このファイル
```

## 🔧 カスタマイズ

### 追加ツールのインストール
`kali-light-dockerfile`の`RUN apt-get install`セクションに追加パッケージを記述：

```dockerfile
RUN apt-get install -y --no-install-recommends \
    your-additional-tool \
    another-tool
```

### リソース制限の変更
`kali-docker-compose.yml`の設定を調整：

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
docker exec -it kali-security-container xauth
```

### パッケージインストールエラー
```bash
# キャッシュクリア後に再ビルド
docker system prune -f
docker build --no-cache -f kali-light-dockerfile -t kali-security:light .
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