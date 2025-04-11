## CONFIGURAR AWS CLI COM UM PERFIL PARA O LOCALSTACK

adicione a seguinte profile ao seu arquivo de configuracao da AWS(por padrão, este arquivo esta em: ~/.aws/config):
`~/.aws/config`

```
[profile localstack]
region=us-east-1
output=json
endpoint_url = http://localhost:4566
```

Add the following profile to your AWS credentials file (por padrão, este arquivo esta em: ~/.aws/credentials):

arquivo: **`~/.aws/credentials`**

```
[localstack]
aws_access_key_id=test
aws_secret_access_key=test

```

Agora é possivel utilizar a profile criada no aws CLI:

```
aws s3 mb s3://test --profile localstack
aws s3 ls --profile localstack
```

SRC: [LOCALSTACK - CONFIGURING A CUSTOM PROFILE ](https://docs.localstack.cloud/user-guide/integrations/aws-cli/#configuring-a-custom-profile)

para remover a necessidade de passar --profile é possivel tanto definir no arquivo a profile como default como alterar via env var

## exemplo linux:

**_deprecated_**
export AWS_DEFAULT_PROFILE=localstack

**atualmente utilize**:
export AWS_PROFILE=localstack

## sobre essa alteracao envolvendo o AWS_PROFILE(da documentacao da AWS)

AWS_PROFILE

Specifies the name of the AWS CLI profile with the credentials and options to use. This can be the name of a profile stored in a credentials or config file, or the value default to use the default profile.

**If defined, this environment variable overrides the behavior of using the profile named [default] in the configuration file. You can override this environment variable by using the --profile command line parameter.**

SRC 2: [STACKOVERFLOW -SET DEFAULT PROFILE AWS CLI](https://stackoverflow.com/questions/31012460/how-do-i-set-the-name-of-the-default-profile-in-aws-cli)

SRC 3: [AWS DOCS - ENV VARS](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html)

## comandos aplicar apenas essas configuracoes que estao acima:

## **CUIDADO POIS IRA SOBREESCREVER QUALQUER CONFIGURACAO PREVIA DO AWS CLI NO SEU AMBIENTE**

### FORMA 1 - COMANDOS INDIVIDUAIS

comando para sobreescrever qualquer config que exista e colocar apenas o do localstack

execute no terminal:

```bash
echo "[profile localstack]
region=us-east-1
output=json
endpoint_url = http://localhost:4566
" > ~/.aws/config

```

```bash
echo "[localstack]
aws_access_key_id=test
aws_secret_access_key=test
" > ~/.aws/credentials
```

```bash
export AWS_PROFILE=localstack
```

### FORMA 2 : TODOS OS COMANDOS JUNTOS

```bash
echo "[profile localstack]
region=us-east-1
output=json
endpoint_url = http://localhost:4566
" > ~/.aws/config && \
echo "[localstack]
aws_access_key_id=test
aws_secret_access_key=test
" > ~/.aws/credentials && \
export AWS_PROFILE=localstack

```

```
echo $AWS_PROFILE
```
