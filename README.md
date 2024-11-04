# PromoApp: Plataforma de Promoções e Avaliação de Produtos

**PromoApp** é um aplicativo desenvolvido em Flutter que permite aos usuários postar, avaliar, guardar e visualizar produtos em promoção. O aplicativo oferece uma experiência interativa, facilitando a compra e a promoção de produtos entre usuários, além de permitir que avaliações e comentários sejam compartilhados.

## Telas

1. **Login - Cadastro**

<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/f0402761-26a0-4d1d-bca4-bf5dd4b6a873" width="28%" />
    <img src="https://github.com/user-attachments/assets/76e84384-4b35-44f3-a054-1cea77b0c63a" width="30%" />
</div>

2. **Home**
<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/5e2bbb1d-8a81-4b1f-90cc-8973b521150a" width="30%" />
    <img src="https://github.com/user-attachments/assets/cee4ad26-87ac-4fc0-9f7e-004da049c38e" width="30%" />
</div>

3. **Publicação e Detalhes**
<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/e143ad3a-bfbd-4deb-afc6-c90e78b27315" width="28%" />
    <img src="https://github.com/user-attachments/assets/d793124b-4c25-482c-becd-fe86ae8a619f" width="30%" />
</div>

4. **Salvos e Interesses**
<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/344a211e-c1a3-44e7-8025-db29e14d5528" width="30%" />
    <img src="https://github.com/user-attachments/assets/2d7d5ad0-0e74-485d-acac-a3ff14fc14f5" width="30%" />
</div>

5. **Especiais e Em Altas**
<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/2209bd60-010b-4720-a188-8af245beeae4" width="30%" />
    <img src="https://github.com/user-attachments/assets/d13e4289-6f07-47b9-bdf2-4527d9063f2a" width="29%" />
</div>

## Funcionalidades

1. **Postagem de Produtos**
   - Interface intuitiva para adicionar produtos com nome, descrição, preço, imagem e localização.
   - Suporte para upload imagens do produto.

2. **Avaliação e Comentários**
   - Sistema de avaliação por estrelas para que os usuários possam dar feedback sobre os produtos e também like e deslike.
   - Campo para comentários, permitindo a troca de experiências entre os usuários.

3. **Lista de Desejos**
   - Opção de salvar produtos favoritos para acesso fácil e rápido no futuro.
   - Gerenciamento de produtos salvos em uma lista organizada.

4. **Visualização de Produtos em Promoção**
   - Filtro dedicado para exibir produtos em promoção, destacando ofertas especiais ou filtrados.
   - Layout visual que torna mais fácil encontrar e acessar produtos em desconto.

5. **Detalhes do Produto**
   - Tela de detalhes com informações completas sobre o produto, incluindo características, preço e avaliações.

6. **Recomendação de Produtos Baseada na Localização**
   - Acesso à localização do usuário para sugerir produtos disponíveis em sua cidade.
   - Filtro de produtos localizados nas proximidades, promovendo uma experiência de compra mais personalizada e relevante.

## Estrutura do Projeto

O repositório é organizado em módulos, cada um focado em uma funcionalidade específica, permitindo uma fácil navegação e manutenção do código. A estrutura principal inclui:

```plaintext
.
├── lib
│   ├── models        # Modelos de dados
│   ├── controllers   # Controladores que conectam interface e backend
│   ├── pages         # Telas do aplicativo
│   ├── widgets       # Componentes reutilizáveis
│   └── services      # Serviços para manipulação de dados
│
└── assets            # Imagens e recursos estáticos
