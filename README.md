# Internal System

Ainda sem um nome próprio, estamos desenvolvendo um sistema interno empresarial modular, com foco em grande escala. Utilizamos atualmente o nome STORE CAR para que seja possível criar uma aplicação Mobile, também em Flutter, e utilizar este sistema como base, para mostrar as possibilidades e expansões do mesmo.

**🔗 [Acesse o Sistema](https://storecar.netlify.app/)**

## 🛠️ Construído com

* [Flutter](https://flutter.dev/) - O framework utilizado
* [Firebase](https://firebase.google.com/) - Banco de Dados
* [MobX](https://mobx.pub/) - Gerenciamento de estado reativo

## Banco de dados Firebase

Foi utilizado o [Realtime Database](https://firebase.google.com/docs/database) do Firebase para registrar e gerenciar os dados da aplicação. O Realtime Database é um banco de dados NoSQL em tempo real baseado em JSON, que permite o armazenamento e sincronização de dados entre clientes e o servidor em tempo real. Cada alteração no banco de dados é automaticamente sincronizada com todos os clientes conectados, o que é ideal para aplicações que demandam atualizações instantâneas e consistência de dados em tempo real.

### Funcionamento

1. **Obtenção do UID:**
   - Ao registrar um novo usuário, o sistema resgata o token uid gerado pelo [Firebase Authentication](https://firebase.google.com/docs/auth), que serve como chave principal para o registro desse usuário no banco de dados.

2. **Estrutura de Dados**:
   - Dentro do nó de cada `uid`, um mapa é criado para armazenar as informações do usuário. Este mapa inclui:
     - **CPF**: Documento de identificação pessoal do usuário.
     - **Email**: Email para login e contato.
     - **ID**: Identificador sequencial único.
     - **Nome**: Nome completo do usuário.
     - **Telefone**: Número de telefone.
     - **Função**: Cargo ou função do usuário (por exemplo, "funcionário").
     - **Endereço**: Estrutura detalhada de endereço com:
       - `street`: Rua
       - `city`: Cidade
       - `neighborhood`: Bairro
       - `number`: Número
       - `state`: Estado
       - `zipCode`: Código postal.
   - **Mapa de Permissões**: Cada usuário possui um mapa `permissions` dentro do seu registro, onde são armazenadas permissões específicas em formato booleano. Isso permite que o sistema verifique as permissões de cada usuário de forma eficiente. <br>
3. **Exemplo:**

```json
{
  "users": {
    "OLhEAQidqwR3PPzQ5EX1i2SLQa13": {
      "name": "user1",
      "email": "user@gmail.com",
      "cpf": "12345678910",
      "id": "1",
      "phone": "12345678910",
      "role": "funcionario",
      "address": {
        "street": "rua1",
        "city": "cidade1",
        "neighborhood": "bairro1",
        "number": "1",
        "state": "estado1",
        "zipCode": "13333-333"
      },
      "permissions": {
        "isAdmin": true
      }
    }
  }
}
```

## Organização e Gerenciamento de Estado com MobX

Para manter o código organizado e escalável, este projeto utiliza o [MobX](https://pub.dev/packages/mobx) como base para gerenciamento de estado. O MobX é uma biblioteca que permite a implementação de um padrão de programação reativa, facilitando o gerenciamento de estados complexos de maneira previsível e fluida. 

Com o MobX, foi possível separar e organizar o código em **stores** (repositórios de estado), que armazenam o estado da aplicação e permitem uma sincronização em tempo real das mudanças de estado com a interface do usuário. Esse modelo reativo simplifica o acompanhamento de estados em diferentes telas e componentes, proporcionando uma arquitetura mais modular e fácil de manter.

## 📌 Versão

Atualmente em ínicio de desenvolvimento sem uma versão fixa.

## ✒️ Autores

[Tiago Ribolli](https://gist.github.com/ribollitiago) e [Gabriel Figueiredo](https://gist.github.com/GabrielFMA)

---
⌨️ por [Tiago Ribolli](https://gist.github.com/ribollitiago)
