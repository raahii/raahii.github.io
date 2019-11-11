+++
title = "Ubuntu16.04でnvidiaドライバが再起動の度に無効になる"
date = 2019-10-16T21:58:50+09:00
tags = ["nvidia driver", "cuda", "gpu", "機械学習", "深層学習"]
categories = ["技術"] # 技術, 読書, 旅行
draft = false
description = "Ubuntu16.04でnvidiaドライバが再起動の度に無効になる"
aliases = ["/2019/10/16/nvidia-driver-not-work-after-reboot-on-ubuntu", "/2019/10/nvidia-driver-not-work-after-reboot-on-ubuntu"]
+++



## 症状

Cudaのインストール手順を一通り済ませているにも関わらず，Ubuntuを起動するたびに `nvidia-smi` コマンドが実行できない．下記のようなエラーが吐かれる．


```shell
❯ nvidia-smi
NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver. Make sure that the latest NVIDIA driver is installed and running.
```



## 解決策

原因は `.run` ファイルを使ってドライバのインストールをしていたからだった．下記のページが参考になった．

- [Nvidia driver not work after reboot on Ubuntu - NVIDIA Developer Forums](https://devtalk.nvidia.com/default/topic/1047781/nvidia-driver-not-work-after-reboot-on-ubuntu/)



とはいえ，Ubuntuの場合はパッケージマネージャからドライバを直接インストールできるので，`apt`を使ったほうが良いと思う．まずはppaを追加する．

```shell
❯ sudo add-apt-repository ppa:graphics-drivers/ppa
❯ sudo apt update
```



肝心のドライバのパッケージだが，検索すると色々出てくるのでインストールされているGPU及びCUDAに合ったバージョンを入れる．[NvidiaのHP](https://www.nvidia.co.jp/Download/index.aspx?lang=jp)から検索ができる．


```shell
❯ sudo apt search "nvidia-[0-9]+\$"
Sorting... Done
Full Text Search... Done
nvidia-304/xenial 304.137-0ubuntu0~gpu16.04.1 amd64
  NVIDIA legacy binary driver - version 304.137

nvidia-331/xenial-updates,xenial 340.107-0ubuntu0.16.04.2 amd64
  Transitional package for nvidia-331

nvidia-340/xenial-updates,xenial 340.107-0ubuntu0.16.04.2 amd64
  NVIDIA binary driver - version 340.107

          ︙

❯ sudo apt install nvidia-430 # 例
```



再起動して`nvidia-smi` が表示されればOK.

```shell
❯ nvidia-smi                                                                                 Wed Oct 16 22:19:32 2019
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 430.26       Driver Version: 430.26       CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  TITAN RTX           Off  | 00000000:01:00.0 Off |                  N/A |
| 23%   42C    P0     1W / 280W |      0MiB / 24219MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```



めでたし．
