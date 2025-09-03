# Kali Linux Rolling 最小ベース
FROM kalilinux/kali-rolling

# メタデータ
LABEL maintainer="user"
LABEL description="Ultra-light Kali Linux with essential security tools"

# 非対話的インストール設定
ENV DEBIAN_FRONTEND=noninteractive

# 日本のミラーサーバーに変更
RUN echo "deb http://ftp.riken.go.jp/Linux/kali kali-rolling main non-free contrib" > /etc/apt/sources.list

# 必要最小限のツールのみインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    # 基本システムツール
    coreutils \
    util-linux \
    file \
    unzip \
    curl \
    wget \
    vim-tiny \
    # ネットワークツール
    netcat-traditional \
    telnet \
    # John the Ripper（zip2john含む）
    john \
    # メタデータ解析
    exiftool \
    # デバッガ
    gdb \
    # バイナリ解析
    binwalk \
    binutils \
    # ステガノグラフィ
    steghide \
    # 16進ダンプ
    xxd \
    # Wireshark（軽量版があれば）
    wireshark-common \
    wireshark \
    # GUI最小構成
    xauth \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# zip2johnの確認と設定
RUN if command -v zip2john >/dev/null 2>&1; then \
        echo "zip2john is available: $(which zip2john)"; \
    else \
        echo "Setting up zip2john..."; \
        find /usr -name "*zip2john*" -type f 2>/dev/null | while read f; do \
            echo "Found: $f"; \
            chmod +x "$f" 2>/dev/null || true; \
            if [ ! -L /usr/local/bin/zip2john ]; then \
                ln -sf "$f" /usr/local/bin/zip2john; \
                echo "Linked zip2john to /usr/local/bin/"; \
            fi; \
        done; \
    fi

# エイリアス設定
RUN echo 'alias nc="netcat"' >> /root/.bashrc && \
    echo 'alias hexdump="xxd"' >> /root/.bashrc

# ツール動作確認
RUN echo "=== Final Tool Check ===" && \
    echo "nc: $(which nc || which netcat)" && \
    echo "telnet: $(which telnet)" && \
    echo "john: $(which john)" && \
    echo "zip2john: $(which zip2john || echo 'checking alternatives...')" && \
    ls -la /usr/local/bin/zip2john 2>/dev/null || \
    find /usr -name "*zip2john*" -type f 2>/dev/null || \
    echo "zip2john setup may need manual verification" && \
    echo "exiftool: $(which exiftool)" && \
    echo "binwalk: $(which binwalk)" && \
    echo "steghide: $(which steghide)" && \
    echo "strings: $(which strings)" && \
    echo "xxd: $(which xxd)" && \
    echo "wireshark: $(which wireshark)" && \
    echo "md5sum: $(which md5sum)" && \
    echo "=== Setup Complete ==="

# 作業ディレクトリ
WORKDIR /workspace
VOLUME ["/workspace"]

# 環境変数
ENV DISPLAY=:0

# デフォルトコマンド
CMD ["/bin/bash"]
