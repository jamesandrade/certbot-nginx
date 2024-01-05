<div align="center" id="top">
  <img src="./.github/app.gif" alt="Api_2" />

&#xa0;

</div>

<h1 align="center">INSTALADOR DO NGINX COM CERTBOT</h1>

<p align="center">
</p>

<!-- Status -->

<hr>

<p align="center">
  <a href="#dart-sobre">Sobre</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requisitos">Requisitos</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-instalação">Instalação</a> &#xa0; | &#xa0;
  <a href="https://github.com/jamesandrade" target="_blank">Author</a>
</p>

<br>

## :dart: Sobre

O PRESENTE SCRIPT VISA AUTOMATIZAR A INSTALAÇÃO DO NGINX COM CERTIFICADO LET'S ENCRYPT GERADO PELO CERTBOT E INSTALAR UMA ROTINA PARA RENOVAR O CERTIFICADO DA APLICAÇÃO

## :white_check_mark: Requisitos

Para utilizar esse projeto, você precisará estar em um ambiente Linux, com [Git](https://git-scm.com), [Docker](https://www.docker.com/) e [Docker-Compose](https://docs.docker.com/compose/gettingstarted/) instalados.

## :checkered_flag: Instalação

Clone o projeto em seu ambiente Linux

```bash
git clone https://github.com/jamesandrade/certbot-nginx
```

Accesse o diretório

```bash
$ cd certbot-nginx
```

Edite o arquivo .env, passando as informações necessárias, com um editor de sua preferência
Nesse arquivo:
APPLICATION_DOMAIN é o domínio ao qual será instalada a aplicação;
APPLICATION_MAIL é o email que receberá notificações;
APPLICATION_REDIRECT é o comando para o qual o futuramente o nginx fará um proxy reverso, exemplo: http://localhost:3000

```bash
vim .env
```

Seja root

```bash
sudo su -
```

Execute o instalador

```bash
./install.sh
```

Após a conclusão do procedimento, você poderá editar o arquivo app.conf do nginx para melhor atender sua necessidade

```bash
vim nginx/config/app.conf
```

Reinicie o nginx para as alterações serem aplicadas

```bash
docker compose restart nginx
```

&#xa0;

<a href="#top">Back to top</a>
