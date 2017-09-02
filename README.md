docker-base
============

■概要
-------

docker を使って複数プロジェクトを管理する際に、
1つの Vagrant を基点に複数管理するためのもの。

■前提知識
-----------

- vagrant
- docker
- docker-compose


■プロジェクトの追加方法
------------------------

`projects.yml` にプロジェクトの内容（同期フォルダとフォワードポート）を書き込む。

例:

```yml
- synced_folder:
    /aaaa-a123: ../aaaa/a123
  forwarded_port:
    1337: 1338
    80: 8080

- synced_folder:
    /bbbb-1234: ../bbbb-1234
  forwarded_port:
    1337: 1338

- synced_folder:
    /cccc.1234: ../cccc.1234
  forwarded_port:
    1337: 1338
```

- `synced_folder` は左辺が Guest OS 側のパス（フルパス）で、右辺が Host OS 側（相対パス）
- `forwarded_port` は左辺が Guest OS 側のポートで、右辺が Host OS 側

その後、`vagrant up` や `vagrant reload` を実行することで、その設定が反映される。


■vagrant up すると
--------------------

基本的に `centos/7` だが下記の状態となる

- IPアドレスは `192.168.33.20` をとりあえず割り当てている
- 日本ロケールになっている
- `vagrant` ユーザで `docker` と `docker-compose` が使えるようになっている
- `dc` が `docker-compose` のエイリアスになっている
- 他にも `dcps`、`dcswitch`、`dcexec` という便利コマンドが使える（後述）


### プロジェクト起動方法

```
[vagrantユーザ] cd プロジェクトのパス
[vagrantユーザ] dc up --build -d
```

- `dc` は `docker-compose` のエイリアス

### コンテナの状態を見る

```
[GuestOS] dcps
```

- `dcps` は `docker ps` をさらに見やすくしたコマンドのエイリアス。実体は [dc-ps](dc-ps) 。

### コンテナ群を別のプロジェクトのものに切り替える

```
[GuestOS] cd 別のプロジェクトのパス
[GuestOS] dcswitch
```

これで元々動いていたコンテナは `kill` され、リネーム（退避）され、別のプロジェクトが（リネーム＝退避されていれば元に戻って）立ち上がる。

- `dcswitch` の実体は [dcswitch](dcswitch)。

### コンテナの中に入る

```
[GuestOS] dcexec コンテナ名
```

- `dcexec` は、よく使う `docker exec` を簡単に実行できるようにしたもの。実体は [dcexec](dcexec)。

