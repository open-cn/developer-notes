## k8s

### Kubernetes的核心概念
Master节点运行着集群管理相关的一组进程：etcd、kube-apiserver、kube-controller-manager、scheduler。这些进程实现了整个集群的资源管理、Pod调度、弹性伸缩、安全控制、系统监控、纠错等管理功能。

#### Node(节点)
节点是Kubernates系统中的一台工作机器(之前的版本叫做Minion)，既从属主机。它可以是物理机，也可以是虚拟机。

每一个节点都包含了Pod运行所需的必要服务，例如Docker、kubelet和网络代理(proxy)，节点受Kubernates系统中的主节点控制。

#### Pod(容器组)
运行于Node节点上，若干相关容器的组合。Pod内包含的容器运行在同一宿主机上，使用相同的网络命名空间、IP地址和端口，能够通过localhost进行通信。

Pod是Kurbernetes进行创建、调度和管理的最小单位，它提供了比容器更高层次的抽象，使得部署和管理更加灵活。

一个Pod可以包含一个容器或者多个相关容器。

每个Pod中有一个特殊的Pause容器，其他的成为业务容器，这些业务容器共享Pause容器的网络栈以及Volume挂载卷，因而他们之间的通信及数据交互更为高效。

#### Replication Controller(复制控制器)
Pod可以单独创建。由于Pods没有可控的生命周期，如果他们进程死掉了，他们将不会重新创建。出于这个原因，建议您使用复制控制器。

Replication Controller用来管理Pod的副本，保证集群中存在指定数量的Pod副本。集群中副本的数量大于指定数量，则会停止指定数量之外的多余容器数量，反之，则会启动少于指定数量个数的容器，保证数量不变。Replication Controller是实现弹性伸缩、动态扩容和滚动升级的核心。


#### Replica Sets
Replica Sets能够确保在某个时间点上，一定数量的Pod在运行。

RelicaSet是Replication Controller的升级版本，两者的区别主要在选择器selector,Replica支持集合级别的选择器，而前期的Replication Controller支持在等号描述的选择器。目前Replica Sets主要用于Deployment中。


#### Deployment
Deployment是Kubernetes 1.2起一个新引入的概念，Deployment是Replica Sets更高一层的抽象。

Kubernetes Deployment提供了官方的用于更新Pod和Replica Set的方法，您可以在Deployment对象中只描述您所期望的理想状态(预期的运行状态)，Deployment控制器为您将现在的实际状态转换成您期望的状态。

Deployment集成了上线部署、滚动升级、创建副本、暂停上线任务，恢复上线任务，回滚到以前某一版本(成功/稳定)的Deployment等功能，在某种程度上，Deployment可以帮我们实现无人值守的上线，大大降低我们的上线过程的复杂沟通、操作风险。

##### Deployment的使用场景
- 使用Deployment来启动（上线/部署）一个Pod或者ReplicaSet
- 检查一个Deployment是否成功执行
- 更新Deployment来重新创建相应的Pods（例如，需要使用一个新的Image）
- 如果现有的Deployment不稳定，那么回滚到一个早期的稳定的Deployment版本
- 暂停或者恢复一个Deployment

#### Service(服务)
Service定义了Pod的逻辑集合和访问该集合的策略，是真实服务的抽象。

Service提供了一个统一的服务访问入口以及服务代理和发现机制，用户不需要了解后台Pod是如何运行。

Service具有如下特征：

- 拥有一个唯一指定的名字
- 拥有一个虚拟IP和端口号
- 能够提供某种远程服务能力
- 被映射到提供这种服务能力的一组容器上
- Service的服务进程目前都基于socket通信方式对外提供服务

#### Label(标签)
Kubernetes中的任意API对象都是通过Label进行标识，Label的实质是一系列的K/V键值对，主要解决Service与Pod之间的关联问题。

Label是Replication Controller和Service运行的基础，二者通过Label来进行关联Node上运行的Pod。

#### Annotation(注解)
Annotation与Label类似，也使用key/value键值对的形式进行定义。

Label具有严格的命名规则，它定义的是Kubernetes对象的元数据（Metadata），并且用于Label Selector。

Annotation则是用户任意定义的”附加”信息，以便于外部工具进行查找。

##### 用Annotation来记录的信息包括：
- build信息、release信息、Docker镜像信息等，例如时间戳、release id号、PR号、镜像hash值、docker registry地址等；
- 日志库、监控库、分析库等资源库的地址信息；
- 程序调试工具信息，例如工具名称、版本号等；
- 团队的联系信息，例如电话号码、负责人名称、网址等。


#### Namespace(命名空间)
使用Namespace来组织kubernetes的各种对象，可以实现用户的分组(多租户)，对不同的租户还可以进行单独的资源设置和管理，是的整个集群的资源配置非常灵活。

#### Schedule
将Pod调度到合适的Node上启动运行

#### Volume(容器共享存储卷)
Volume是Pod中能够被多个容器访问的共享目录。Kubernetes的Volume概念与Docker的Volume比较类似，但不完全相同。Kubernetes中的Volume与Pod生命周期相同，但与容器的生命周期不相关。当容器终止或者重启时，Volume中的数据也不会丢失。另外，Kubernetes支持多种类型的Volume，并且一个Pod可以同时使用任意多个Volume。

#### Persistent Volume(PV，持久卷)
Persistent Volume(PV)是集群之中的一块网络存储。跟Node一样，也是集群的资源。PV跟Volume (卷)类似，不过会有独立于Pod的生命周期。这一API对象包含了存储的实现细节，例如NFS、iSCSI或者其他的云提供商的存储系统。

##### Persistent Volume Claims(持久卷申请)
用户通过持久卷请求(PVC)申请存储资源。它跟Pod类似，Pod消费Node的资源，PVC消费PV的资源。Pod能够申请特定的资源(CPU和内存)；PVC可以申请大小、访问方式（例如mount rw一次或mount ro多次等多种方式）。

#### Horizontal Pod Autoscaling(Pod自动扩容)
Pod横向自动扩容。可以实现基于CPU使用率的Pod自动伸缩的功能。

#### Proxy(代理)
反向代理，Proxy会根据Load Balancer规则将外网请求分发到后端正确的容器处理。

### install kubernetes

kubelet 运行在 Cluster 所有节点上，负责启动 Pod 和容器。

kubeadm 用于初始化 Cluster。

kubectl 是 Kubernetes 命令行工具。通过 kubectl 可以部署和管理应用，查看各种资源，创建、删除和更新各种组件。

#### on macOS
Kubernetes is only available in Docker for Mac 17.12 CE and higher, on the Edge channel.
preferences Kubernetes select Enable Kubernetes and click the Apply button.

之前使用 brew 安装了 kubectl 请先卸载。
brew uninstall kubernetes-cli
之前你可能使用了 minikube ，需要切换到 docker-for-desktop。
kubectl config use-context docker-for-desktop

#### on Linux
```
apt-get update && apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

...
deb http://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main

apt-get update
apt-get install -y kubelet kubeadm kubectl
```

sudo swapoff -a  关闭所有交换设备
sudo swapon -a
重启失效
sudo kubeadm init

#### 初始化kubectl配置
To start using your cluster, you need to run the following as a regular user:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/
```
kubectl create -f  https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl create -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel-rbac.yml
kubeadm reset
kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.10.1  --apiserver-advertise-address 
```

##### 创建检测DNS pod
kubectl run curl --image=radial/busyboxplus:curl -i --tty

执行nslookup kubernetes.default确认解析正常

kubectl delete deploy curl

kubeadm join emmme.cn:6443 --token bwn0f3.jjkfbiwmw7gd325i --discovery-token-ca-cert-hash sha256:d07e03a2cb21a587f13d09dd8d73ce572e734f594d2849e6694e18def82f2f2f

kubeadm token list

--discovery-token-ca-cert-hash sha256:
哈希值由 kubeadm init 结尾输出的 kubeadm join 命令所返回，或者位于 kubeadm token create --print-join-command 的输出中
也能够通过第三方工具计算
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'


kubectl delete node xxx

sudo kubeadm reset

#### k8s web 管理
使用 kubectl 命令来创建简单的 kubernetes-dashboard 服务：
$ kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
在 Dashboard 启动完毕后，可以使用 kubectl 提供的 Proxy 服务来访问该面板：
$ kubectl proxy
打开如下地址：
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

如果访问报错，可以尝试编辑 kubernetes-dashboard 服务：
$ kubectl -n kube-system edit service kubernetes-dashboard
将倒数第3行的“type: ClusterIP”，改成 type: NodePort
kubectl get services kubernetes-dashboard -n kube-system
kubectl get deployment kubernetes-dashboard  -n kube-system
kubectl get pods  -n kube-system | grep dashboard

curl -k https://10.106.190.212:443
使用 NodePort 方式
curl -k https://127.0.0.1:30333
curl -k https://www.xxx.cn:30333

使用 kubectl proxy 方式
$ kubectl proxy --address='0.0.0.0' --port=8080 --accept-hosts='^*$'

获取 token
kubectl -n kube-system get secret | grep kubernetes-dashboard-token
kubectl -n kube-system describe secret kubernetes-dashboard-token-xxx

如果上面查到的token无效，可以使用下方命令
kubectl create serviceaccount dashboard -n default
kubectl create clusterrolebinding dashboard-admin -n default \
--clusterrole=cluster-admin \
--serviceaccount=default:dashboard
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode


##### 删除安装的 Dashboard 配置命令：
$ kubectl -n kube-system delete $(kubectl -n kube-system get pod -o name | grep dashboard)

```
kubectl delete deployment kubernetes-dashboard --namespace=kube-system 
kubectl delete service kubernetes-dashboard  --namespace=kube-system 
kubectl delete role kubernetes-dashboard-minimal --namespace=kube-system 
kubectl delete rolebinding kubernetes-dashboard-minimal --namespace=kube-system
kubectl delete sa kubernetes-dashboard --namespace=kube-system 
kubectl delete secret kubernetes-dashboard-certs --namespace=kube-system
kubectl delete secret kubernetes-dashboard-key-holder --namespace=kube-system

kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl delete service hello-minikube
kubectl delete deployment hello-minikube

kubectl get pod --all-namespaces kube-addon-manager-minikube
kubectl describe --namespace=kube-system pod kube-addon-manager-minikube
kubectl logs --namespace=kube-system kube-addon-manager-minikube
kubectl delete --namespace=kube-system pod kube-addon-manager-minikube

查看部署的容器与服务 
kubectl get deployments -n kube-system -o=wide
kubectl get services               kubectl get svc
kubectl get pods                   kubectl get pod
kubectl get nodes                  kubectl get no
kubectl get ds                     kubectl get ds 
kubectl get componentstatuses      kubectl get cs

--all-namespaces 
--namespace kube-system 

kubectl cluster-info
kubectl cluster-info dump
```


no IP addresses available in range set: 10.244.0.1-10.244.0.254
sudo ls /var/lib/cni/flannel/
sudo ls /var/lib/cni/networks/cbr0/

干掉cni-flannel,停运集群.清理环境.
sudo kubeadm reset
rm -rf /var/lib/cni/flannel/* && rm -rf /var/lib/cni/networks/cbr0/* && ip link delete cni0
rm -rf  /var/lib/cni/networks/cni0/*



master:
for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler flanneld; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES
done
node:
for SERVICES in kube-proxy kubelet flanneld docker; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES
done


kubectl config get-contexts
kubectl config use-context docker-for-desktop

kubectl config set-cluster default-cluster --server=http://192.168.121.9:8080
kubectl config set-context default-context --cluster=default-cluster --user=default-admin
kubectl config use-context default-context




#### Kubeadm 安装方式

Kubeadm安装的k8s集群与kube-up.sh安装集群相比，最大的不同应该算是kubernetes核心组件的Pod化，即：kube-apiserver、kube-controller-manager、kube-scheduler、kube-proxy、kube-discovery以及 etcd 等核心组件都运行在集群中的Pod里的，这颇有些 CoreOS 的风格。只有一个组件是例外的，那就是负责在node上与本地容器引擎交互的Kubelet。


kube-apiserver pod里面的pause容器采用的网络模式是host网络，而以pause容器网络为基础的kube-apiserver 容器显然就继承了这一network namespace。

在kube-apiserver等核心组件还是以本地程序运行在物理机上的时代，修改kube-apiserver的启动参数，可以通过直接修改/etc/default/kube-apiserver(以Ubuntu 14.04为例)文件的内容并重启kube-apiserver service(service restart kube-apiserver)的方式实现。其他核心组件：诸如：kube-controller-manager、kube-proxy和kube-scheduler均是如此。

但在kubeadm时代，这些配置文件不再存在，取而代之的是和用户Pod描述文件类似的manifest文件(都放置在/etc/kubernetes/manifests)

kubelet自身是一个systemd的service，它的启动配置可以通过下面文件修改：
vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

```
kubectl --kubeconfig /etc/kubernetes/kubelet.conf config view

ls /etc/kubernetes/pki
apiserver-key.pem：kube-apiserver的私钥文件
apiserver.pem：kube-apiserver的公钥证书
apiserver-pub.pem kube-apiserver的公钥文件
ca-key.pem：CA的私钥文件
ca.pem：CA的公钥证书
ca-pub.pem ：CA的公钥文件
sa-key.pem ：serviceaccount私钥文件
sa-pub.pem ：serviceaccount的公钥文件
tokens.csv：kube-apiserver用于校验的token文件
```




