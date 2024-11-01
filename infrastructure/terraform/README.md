## Redirecionamento de porta utilizando socat
O redirecionamento de portas no WSL (Windows Subsystem for Linux) usando socat refere-se à prática de encaminhar tráfego de uma porta em uma interface de rede para outra porta em outra interface. Isso é útil, por exemplo, para permitir que serviços em execução no WSL sejam acessíveis a partir de outra interface de rede, como o host do Windows ou outra máquina na rede.

1. **Instalar o socat**:
   Execute o comando a seguir para instalar o `socat`:

   ```bash
   sudo apt install socat

2. **Utilização do socat**:
   Execute o comando a seguir para executar o `socat`:

   ```bash
   sudo socat TCP-LISTEN:30001,fork TCP:172.18.0.2:30001

## Testes de stress utilizando fortio
Testes de estresse, também conhecidos como stress tests, são uma forma de teste de desempenho que visa avaliar como um sistema, aplicativo ou serviço se comporta sob condições extremas ou além de sua capacidade normal. 

1. **Instalar o fortio**:
   Execute o comando a seguir para instalar o `fortio`:

   ```bash
   sudo kubectl run fortio --image=fortio/fortio --port=8080 --labels="app=fortio"

2. **Utilização do fortio**:
   Execute o comando a seguir para executar o `fortio`:

   ```bash
   sudo kubectl exec -it $(sudo kubectl get pods --selector=app=fortio -o jsonpath='{.items[0].metadata.name}') -- fortio load -c 70 -t 220s -qps 800 "http://172.18.0.2:30001"

## Visualizar o dashboard utilizando kiali
Kiali é uma ferramenta de observabilidade e gerenciamento para arquiteturas de microserviços que utilizam o Istio, um popular serviço de malha (service mesh) para Kubernetes. Kiali fornece uma interface gráfica que permite aos desenvolvedores e operadores de sistemas visualizar e gerenciar o tráfego entre microserviços, monitorar a saúde e o desempenho das aplicações, e configurar políticas de segurança e roteamento.

1. **Instalar o kiali**:
   Execute o comando a seguir para instalar o `kiali`:

   ```bash
   sudo kubectl apply -f https://github.com/istio/istio/blob/master/samples/addons/kiali.yaml

2. **Utilização do kiali**:
   Execute o comando a seguir para executar o `kiali`:

   ```bash
   sudo istioctl dashboard kiali