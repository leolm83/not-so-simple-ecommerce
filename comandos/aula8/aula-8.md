# COMANDOS AULA 8

## Builds

### SERVICES

<!-- TODO FALTA O DO MAIN QUE FOI FEITO EM OUTRA AULA -->

#### BUILD ORDER

```bash
docker build \
-f src/services/NotSoSimpleEcommerce.Order/Dockerfile \
-t nsse/order:1.0.0 \
.
```

#### BUILD IDENTITY SERVER

```bash
docker build \
-f src/services/NotSoSimpleEcommerce.IdentityServer/Dockerfile \
-t nsse/identity-server:1.0.0 \
.
```

#### BUILD HEALTH CHECKER

```bash
docker build \
-f src/services/NotSoSimpleEcommerce.HealthChecker/Dockerfile \
-t nsse/health-checker:1.0.0 \
.
```

## WORKERS

#### BUILD INVOICE GENERATOR

```bash
docker build \
-f src/workers/NotSoSimpleEcommerce.InvoiceGenerator/Dockerfile \
-t nsse/invoice-generator:1.0.0 \
.
```

#### BUILD NOTIFICATOR

```bash
docker build \
-f src/workers/NotSoSimpleEcommerce.Notificator/Dockerfile \
-t nsse/notificator:1.0.0 \
.
```
