# Roadmap

O roadmap é uma visão geral dos planos futuros para o desenvolvimento e evolução do projeto. Ele serve como um guia para os próximos passos e metas a serem alcançadas.

## Projetos em Andamento
### Procedural World Gen Engine
É um projeto de geração procedural de mundos, inspirado em jogos como Minecraft e Dwarf Fortress. O objetivo é criar um motor de geração de mundos que seja capaz de gerar mundo de maneira procedural, com diferentes blocos. O motor será desenvolvido em Python e seu principal objetivo é ser uma ferramenta de aprendizado para entender os conceitos de engenharia de software. O projeto está em fase de WIP.

É possível ver os detalhamentos e o código fonte do projeto no repositório do GitHub: [Procedural World Simulation Engine](https://github.com/2AMK/Procedural-World-Simulation-Engine)

## Projetos Futuros

### "Ultimate Validator" de dados

O "Ultimate Validator" é um projeto ambicioso que visa criar um sistema de validação de dados altamente eficiente e flexível. Ele será projetado para validar grandes volumes de dados de maneira rápida e precisa entre as diferentes bases de dados.

O maior desafio que presenciei no dia a dia referente aos dados é assegurar que as duas ou mais bases tenham dados consistentes e confiáveis, além de garantir que as atualizações sejam refletidas corretamente em todas as bases. 

Suponha que queremos migrar uma base antiga em Excel onde contém notas dos alunos de todas as turmas em diferentes matérias e fórmulas matemáticas para gerar as médias finais e as notas pós-recuperações para uma base nova em SQL que será armazenado na nuvem. Esse processo todo contará com a equipe técnica.

Mas como podemos garantir que a nova base tenha todos alunos com matrícula ativa na escola e que as regras de negócios para essa base de dados sejam respeitadas, de maneira que não custe muito dos nossos tempos validando manualmente cada linha?

A gente também não quer que a nova base tenha as inconsistências nos dados podem levar a erros e problemas de integridade, o que pode afetar negativamente a tomada de decisões e a confiança nos sistemas escolares.

O "Ultimate Validator" tem como objetivo resolver esse problema, garantindo que os dados sejam validados de forma eficaz e que as inconsistências sejam identificadas rapidamente e de maneira clara, permitindo que o time possa agir de forma proativa para corrigir quaisquer problemas.

A ideia é que esse motor de validação seja capaz de lidar com diferentes tipos de dados e formatos, além de ser facilmente integrável com as bases de dados existentes e em diferentes contextos. Ele também deve ser escalável para lidar com grandes volumes de dados e ser flexível o suficiente para se adaptar às necessidades específicas de cada projeto.

#### Funcionalidades
- Validação de dados com 2 ou mais bases de dados
- Identificação de inconsistências de forma rápida e clara através dos logs
- Suporte para diferentes tipos de dados e formatos
- Integração fácil com bases de dados existentes, com a arquitetura modular e flexível
- Escalabilidade para lidar com grandes volumes de dados
- Flexibilidade para se adaptar às necessidades específicas de cada projeto
- Interface de usuário intuitiva para facilitar a configuração e monitoramento do processo de validação
- Relatórios detalhados sobre as inconsistências encontradas

## Algumas ideias

### Um sistema "central" de finança pessoal

A ideia desse projeto é criar um sistema centralizado para gerenciar as finanças pessoais de maneira mais fácil e prático, sendo possível registrar ou mesmo exibir os valores de qualquer lugar onde estiver, seja em Telegram ou no Excel, e poder ter uma visão completa de sua situação atual, além dos investimentos.

A ideia nasceu justamente devido à dificuldade de acompanhar e gerenciar as finanças, mesmo com Excel, já que é necessário abrir a planilha, atualizar os dados manualmente e não ter uma visão clara e rápida da situação financeira. Além disso, a planilha só é acessível em um dispositivo específico, o que pode ser um problema para quem precisa acessar as informações de diferentes lugares.

O sistema pode incluir funcionalidades como orçamento, acompanhamento de despesas, metas financeiras e relatórios personalizados.
- Também pode incluir o monitoramento das caixinhas/carteiras de investimento, para ter uma visão completa da situação financeira.
- O sistema pode ser integrado com diferentes plataformas, como Telegram, para facilitar o acesso e atualização dos dados, e também com o Excel para quem prefere trabalhar com planilhas.
- Também poderá usar API de bancos de dados externos como o Yahoo Finance para obter informações atualizadas sobre os investimentos e o mercado financeiro.
- Também seguirá o princípio de "local first", ou seja, os dados serão armazenados localmente no dispositivo do usuário, garantindo a privacidade e segurança das informações financeiras.
- Será necessário ter idempotência para evitar problemas de concorrência e garantir a integridade dos dados, especialmente quando o sistema for acessado de diferentes dispositivos ou plataformas.

Esse projeto seria inicialmente para o uso pessoal. Ele pode ser desenvolvido utilizando Python para o backend, com uma interface de usuário simples e intuitiva, e integração com diferentes plataformas para facilitar o acesso e atualização dos dados. 