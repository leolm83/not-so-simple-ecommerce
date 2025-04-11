## AULA 7

# criar network no docker

docker network create nome-da-rede

```bash
docker network create nsse-network
```

# executar LocalStack

```bash
docker run --name nsse.localstack --network nsse-network \
--rm -it \
-p 4566:4566 \
-p 4510-4559:4510-4559 \
localstack/localstack:stable
```

```
docker run --name nsse.localstack --network nsse-network \
--rm -it \
-p 4566:4566 \
-p 4510-4559:4510-4559 \
-v "${LOCALSTACK_VOLUME_DIR:-/opt/docker/data/localstack}:/var/lib/localstack" \
-v "/var/run/docker.sock:/var/run/docker.sock" \
localstack/localstack:stable


```

**adicionei :stable para estar na versao estavel do localstack e nao na versao nightly(que pode conter bugs inesperados)**

## Criar queue no localstack

**caso o comando abaixo de erro de configuracao do CLI e desejar prosseguir sem a necessidade de conta da aws verifique o arquivo em comandos/aula7/aws-local-config-placeholder.md**

```bash
aws --endpoint http://localhost:4566 sqs create-queue --queue-name ProductStockQueue

```

## executar o backend na aula 7

```bash
docker run --network nsse-network \
--env-file .env \
-p 8080:443 \
-v ./certificates/:/certificates/:ro \
-v ~/.aws/credentials:/nsse-backend/.aws/credentials:ro nsse/main:1.0.0

```
