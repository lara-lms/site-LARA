# Deploy da infraestrutura

A infraestrutura para o site do LARA conta com três manifestos yaml para o Kubernetes:

1. [prod-httproutes.yaml](prod-httproutes.yaml), para o ambiente de produção, ou [dev-httproutes.yaml](dev-httproutes.yaml), para o ambiente de desenvolvimento
2. [service-manifest.yaml](service-manifest.yaml)

A ordem acima não precisa ser seguida, uma vez que não são recursos dependentes.

> [!TIP]
>
> Os comandos listados aqui foram executados em no Ubuntu através do WSL, com o kubectl propriamente configurado para realizar login com o cluster.

## Realizar deploy das rotas http

Para realizar o deploy das rotas basta executar o comando abaixo para o ambiente desejado. 

Para produção:

```shell
kubectl apply -f prod-httproutes.yaml
```

Para desenvolvimento:

```shell
kubectl apply -f dev-httproutes.yaml
```
Cada manifesto possui 2 rotas, uma HTTP e outra HTTPS, com a rota HTTP configurada para redirecionar o trafego para o HTTP.

## Realizar deploy do service manifest

O `service-manifest.yaml` possui um Deployment e um Service, os recursos configurados atualmente estão voltados para um cluster com poucos recursos computacionais. Para realizar o deploy deste manifesto execute o comando abaixo:

```shell
NAMESPACE= envsubst < service-manifest.yaml | kubectl apply -f -
```

- NAMESPACE: o namespace do ambiente que deseja realizar o deploy, pode ser `lara-production` ou `lara-development`
