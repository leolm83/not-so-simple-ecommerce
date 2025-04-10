FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build
WORKDIR /nsse-backend
COPY . .
RUN dotnet publish /nsse-backend/src/services/NotSoSimpleEcommerce.Main/NotSoSimpleEcommerce.Main.csproj -c Release -o publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
WORKDIR /nsse-backend
COPY --from=build /nsse-backend/publish .
EXPOSE 443
RUN adduser dotnet --disabled-password
RUN apk add curl
USER dotnet
# -k no curl aceita certificados invalidos
HEALTHCHECK CMD curl -k --fail https://localhost:443/main/health
# ENTRYPOINT ["sleep","99999999"]
ENTRYPOINT [ "dotnet","/nsse-backend/NotSoSimpleEcommerce.Main.dll"]

## NECESSARIO ESTAR NA PASTA BASE DO PROJETO not-so-simple-ecommerce
# build
# para buildar utilize o seguinte comando:
    # docker build -f ./src/services/NotSoSimpleEcommerce.Main/Dockerfile -t nsse/main:1.0.0 .
# run 
# para executar:
# docker run --env-file .env -p 8080:443 nsse/main:1.0.0 \
# -v ./certificates/kestrel-certificate.pfx:certificates/kestrel-certificate.pfx:ro
# todo fix docker run
#docker run --env-file .env -p 8080:443 -v ./certificates/:/certificates/:ro  nsse/main:1.0.0