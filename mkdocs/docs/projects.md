# Projetos

### Automatização de relatório gerencial usando Python

Um processo que antes demorava algumas horas para ser feito foi automatizado, reduzindo para poucos minutos.

O processo exigia extrair de diversas fontes diferentes informações, processá-las e gerar um relatório final. Era um trabalho manual e bem propenso aos erros humanos. Com isso, pensei em uma forma de simplificar esse processo com a automação usando Python.

 Ele utiliza as bibliotecas como Pandas e PyGUI para tornar o interface mais user-friendly e mais fácil de usar para o usuário não técnico.

Um dos meus quick-win no início da minha carreira.

### Geração de PDF e Enviador de E-mail

Trouxe várias melhorias importantes para a rotina já existente de geração de PDFs e envio de e-mail em massa.

#### Processo de geração de PDF

Primeiro, modernizei o processo de geração de PDF, transferindo os códigos legados para Python, o que tornou o código mais limpo e eficiente. 

Em seguida, removi alguns passos intermediários que potencialmente podiam induzir aos erros humanos que podiam afetar o output final. Isso foi feito através da biblioteca de Pandas, que permite manipular facilmente os dados diretamente no Python.

A automação também apresenta as camadas modulares como a camada de validação de input e de validação das regras ou lógica de negócio. Hipoteticamente, a gente pode validar se o valor do campo calculado por uma automação está respeitando os critérios específicos estabelecidos. Por exemplo, a automação validaria se a média final de um aluno bate com o flag de aprovado ou reprovado. Iria emitir a alerta caso o aluno tiver nota menor do que o mínimo para ser considerado como aprovado, mas está acendendo o flag positivo para aprovado.

Depois disso, na primeira versão, o gerador de PDFs utilizava o template de uma planilha de Excel e gerava um relatório de validação, pensando na facilidade de mudar os templates sem exigir os conhecimentos específicos por parte dos utlizadores da ferramenta.

##### "A segunda versão" da automação

Na segunda versão que utilizei para outra rotina que exige a alta performance do próprio script devido a grande volumes de dados, incorporei a possibilidade de geração de múltiplos PDFs de maneira simultânea usando multiprocessing invés de serializar os dados.

Passei a utilizar a usar o template no formato de HTML com parâmetros reutilizáveis, e caso precisasse utilizar essa automação, só mexeria em alguns parâmetros.

Isso permitiu que gerasse PDFs mais personalizados e altamente configurável usando config.yaml.

Nessa nova versão, consegui transformar um processo específico que antes precisava passar a noite inteira em algo como no máximo de meia hora.

Por exemplo, eu agora consigo gerar vários PDFs de certificado de forma rápida e eficiente para todos os participantes elegíveis (aqueles que participaram de mais 3 dias) de um congresso acadêmico. E no outro ano, por exemplo Congresso Acadêmico 2027, eu só ajeito um parâmetro específico em config.yaml para gerar PDFs com ano correto. Ou se a reitoria pediu para trocar a aparência dos certificados, consigo trocar em alguns minutos, mantendo os parâmetros preservados.

#### Processo de envio de e-mail

Trouxe algumas melhorias importantes para o processo de envio de e-mail já existente que é utilizado no sistema corporativo interno.

O código legado era bastante confuso, com muitas funções anônimas e variáveis globais. Para isso, tive que refatorar e documentar todo o código, modularizando-o e criando funções específicas para cada tarefa.

Também implementei as configurações e parâmetros ao lado da aba de uma planilha para os usuários não técnicos pudessem utilizar sem entrar em código.

Além disso, consegui contornar a limitação do próprio serviço de enviador nativo que o meu time historicamente tinha que lidar de maneira artesanal. Com isso, trazendo a proposta de usar o serviço de SMTP que era uma solução altamente escalável, e permitiu que os e-mails sejam enviados em grande volume e em menos tempo do que um método tradicional a baixo custo.

Inclusive, para contornar o tempo de execução da ferramenta interna, tive que criar uma função que chamasse o acionador de uma função. Isso permite que a própria automação pare de executar por um período de tempo e depois volte a executar novamente até que toda tarefa seja concluída.

### Projeto AI Chatbot

Para esse projeto, desenvolvi dentro da infraestrutura já existentes da empresa, um chatbot inteligente de GEN AI que pode responder perguntas comuns dos usuários e utilizar os dados da própria plataforma de dados para poder fornecer as respostas mais personalizadas.

O chatbot operava numa analogia de um restaurante:
- Nós escrevemos os códigos que é a receita do chatbot e enviamos para o fornecedor que é a infraestrutura.
- Nós alugamos um restaurante e pagamos as pessoas, e entregamos a receita a eles.
- Os cozinheiros cozinham o prato (executam os códigos) e entregam para os nossos clientes.
- O "motoqueiro" avalia o status atual do restaurante e nos avisam a situação atual do restaurante (se é operante ou houve alguns problemas com os pedidos).
- Os assistentes avaliam o tempo de pedido e a satisfação dos usuários, e anota em uma tabela de dados que será utilizado como nosso dashboard gerado por um analista.
- Além disso, nós estamos tentando implementar uma funcionalidade em que nós temos uma dispensa onde contém os ingredientes (dados) e agendamos de ir para mercadão para pegar ingredientes ocasionalmente e estocar em uma dispensa, invés de ir para mercadão todas as vezes que os clientes pedem ou todas as vezes que o restaurante abre. Isso ajuda a reduzir o custo marginal de "deslocamento" a um mercadão.

Também implementei algumas tecnologias como usar o tool calling que elimina a necessidade de "Chain of Responsiblity" ou um script extenso e extremamente engessado, o que ajuda a reduzir a manutenção necessária para manter o restaurante funcionando. É como ensinar aos cozinheiros que nós temos ferramentas como faca, tábua, frigideira etc, e deixar eles decidirem o que fazer com as ferramentas e criar os pratos conforme as instruções mínimas. Ou seja, nessa abordagem, nós não precisamos dizer "cozinheiro 1, fatie a cebola e cozinhe o peito de frango na frigideira com óleo de azeite", "cozinheiro 2, cozinhe o macarrão a bolonesa usando macarrão", mas sim "cozinheiro 1, faça isso com as ferramentas e ingredientes que tiver por aí".
