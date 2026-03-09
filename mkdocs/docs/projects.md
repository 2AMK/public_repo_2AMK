# Projetos

Aqui estão listados os principais projetos profissionais e pessoais que foram realizados até agora.

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

Para esse projeto, desenvolvi dentro da infraestrutura já existente da empresa, um chatbot inteligente de GEN AI que pode responder perguntas comuns dos usuários e utilizar os dados da própria plataforma de dados para poder fornecer as respostas mais personalizadas.

O chatbot operava numa analogia de um restaurante:
- Nós escrevemos os códigos que é a receita do chatbot e enviamos para o fornecedor que é a infraestrutura.
- Nós alugamos um restaurante e pagamos as pessoas, e entregamos a receita a eles.
- Os cozinheiros cozinham o prato (executam os códigos) e entregam para os nossos clientes.
- O "motoqueiro" avalia o status atual do restaurante e nos avisam a situação atual do restaurante (se é operante ou houve alguns problemas com os pedidos).
- Os assistentes avaliam o tempo de pedido e a satisfação dos usuários, e anota em uma tabela de dados que será utilizado como nosso dashboard gerado por um analista.
- Além disso, nós estamos tentando implementar uma funcionalidade em que nós temos uma dispensa onde contém os ingredientes (dados) e agendamos de ir para mercadão para pegar ingredientes ocasionalmente e estocar em uma dispensa, invés de ir para mercadão todas as vezes que os clientes pedem ou todas as vezes que o restaurante abre. Isso ajuda a reduzir o custo marginal de "deslocamento" a um mercadão.

Também implementei algumas tecnologias como usar o tool calling que elimina a necessidade de "Chain of Responsiblity" ou um script extenso e extremamente engessado, o que ajuda a reduzir a manutenção necessária para manter o restaurante funcionando. 
- É como ensinar aos cozinheiros que nós temos ferramentas como faca, tábua, frigideira etc, e deixar eles decidirem o que fazer com as ferramentas e criar os pratos conforme as instruções mínimas. 
- Ou seja, na nova abordagem, nós não precisamos dizer "cozinheiro 1, fatie a cebola e cozinhe o peito de frango na frigideira com óleo de azeite", "cozinheiro 2, cozinhe o macarrão a bolonesa usando macarrão", mas sim "cozinheiro 1, faça isso com as ferramentas e ingredientes que tiver por aí".


### Motor de Processamento e Geração de Output

Suponha num cenário hipotético, anualmente os gestores escolares precisam se reunir numa força-tarefa para discutir sobre os reajustes na mensalidade dos alunos da escola. Como a diretora disse aos gestores que devido ao ano díficil que a escola passou, precisarão aumentar a mensalidade e os reajustes serão mais rigorosos do que o normal.

Esse processo exige a coleta de dados de diversas fontes, como planilhas de Excel e Google Sheets com todos os dados necessários sobre os alunos matriculados na escola, e até mesmo arquivos em papel. Depois disso, os gestores precisam processar esses dados manualmente para gerar um relatório final que será utilizado para tomar decisões sobre os reajustes na mensalidade.

Aparecem diversos problemas comuns nessa abordagem tradicional:
- O tempo gasto no processo de busca manual repetitivo usando Excel é excessivo, o que pode levar a atrasos e ineficiências. Por exemplo, os gestores demoraram uma semana inteira só para apurar todas as fontes e consolidar os dados necessários para a reunião.
- Ainda mais, o uso das fórmulas de Excel e Sheet para processar os dados é extremamente frágil, especialmente se as fórmulas não forem configuradas corretamente ou se houver muitos dados para processar. Isso pode levar aos travamentos extremamente frequentes, o que pode ser frustrante e atrasar muito o processo tão árduo.
- A necessidade de puxar várias planilhas diferentes para obter os dados necessários pode ser confusa e propensa a erros, especialmente se as planilhas não estiverem bem organizadas ou se houver muitos dados para processar.
- Como existem várias fontes diferentes de dados, o que leva à outra questão: como atualizar o modelo com segurança com novas fontes de dados? Esse desafio também torna o modelo mais difícil de reutilizar para uma rotina complexa e recorrente.
- A falta de reutilização pode levar a inconsistências e erros, já que cada vez que o processo é realizado, os gestores precisam criar um novo modelo do zero, o que pode apresentar regras inconsistentes e tornar menos transparente.
- Além disso, isso podem levantar as dúvidas por parte dos pais dos alunos como: "Quais foram os critérios de vocês para considerar esse aumento na mensalidade? No ano passado, entendemos que vocês usaram X para Y% de reajuste na mensalidade"

Assim, considerando esse cenário, pensei nas formas de simplificar esse processo e implementei um motor poderoso que combina diferentes fontes e gera uma saída personalizada baseado nos parâmetros ajustáveis. 
- Os próprios utilizadores podem modificar os parâmetros para ajustar o modelo conforme necessário. Por exemplo, os gestores escolares podem mudar a porcentagem máxima de reajuste da mensalidade para cada faixa. 
- Também o modelo permite utilizar as funções linear ou logarítimica para calcular os reajustes para sermos mais justos e ajudar com as famílias numa situação financeira mais difícil.
    - Por exemplo, podemos definir que o reajuste máximo para as mensalidades é de 10%, mas para as famílias que estão com dificuldades financeiras (definidas por renda per capita), o reajuste máximo é de 5%. 
    - Assim, o modelo pode calcular os reajustes de maneira mais personalizada e justa para cada família, ao invés de aplicar um reajuste fixo para todos os alunos ou colocar faixas de intervalos para cada faixa de renda (por exemplo, 0-1000, 1001-2000, etc) que pode ser injusto para as famílias que estão perto do limite de cada faixa.
    - Ou seja, a automação permite utilizar diferentes estratégias em cada força tarefa de reajustes na mensalidade. Podemos ser mais agressiva ou ser mais conservadores dependendo do cenário.
- Como a automação gera o output em apenas único botão, após configurar os parâmetros, os gestores podem gerar o relatório final de maneira rápida e eficiente, sem precisar se preocupar com os detalhes técnicos do processo.
- A automação permite a independência do usuário final de ajustar o modelo conforme necessário e reutilização do modelo para próximas rotinas.

### Automação de Consolidação de Formulários

Esse projeto consiste em desenvolver um motor interno que atua como backend das planilhas de formulários e planilha central para consolidar os diferentes formulários de ingestão em única planilha central, com validação e tratamento dos dados.

Para ilustrar o cenário, imagine que a escola tem vários formulários de ingestão de dados para diferentes propósitos, como um formulário para os pais atualizarem as informações de contato, um formulário para os professores atualizarem as notas dos alunos, e um formulário para os gestores atualizarem as informações sobre os reajustes da mensalidade. 
- Esses formulários são preenchidos por diferentes usuários e precisam ser consolidados em uma única planilha central para facilitar a análise e a tomada de decisões.
- O fluxo tradicional para consolidar esses dados seria manual, onde os gestores teriam que acessar cada formulário individualmente, extrair os dados e consolidá-los manualmente em uma planilha central. Isso pode ser demorado e propenso a erros, especialmente se houver muitos formulários e muitos dados para processar.

Assim, para simplificar esse processo, estou desenvolvendo um motor interno que atua como backend das planilhas de formulários e planilha central. A automação consolida os diferentes formulários de ingestão em única planilha central, com validação e tratamento dos dados.

O fluxo seria assim:

1. Os usuários preenchem os formulários de ingestão de dados.
2. O motor interno consolida os dados dos formulários em uma única planilha central, aplicando as regras de validação e tratamento dos dados conforme necessário. 
    - Por exemplo, o motor pode validar se os campos obrigatórios foram preenchidos, se os dados estão no formato correto, ou se os valores estão dentro de um intervalo aceitável.
3. Os gestores podem acessar a planilha central para analisar os dados consolidados e tomar decisões informadas.

A automação é projetada para permitir a autonomia por parte dos utilizadores finais ao tornar mais fácil de configurar e ajustar. Por exemplo, os gestores podem configurar as regras de validação e tratamento dos dados conforme necessário, sem precisar de conhecimentos técnicos avançados. Isso permite que a automação seja flexível e adaptável às necessidades específicas da escola, enquanto ainda simplifica o processo de consolidação dos dados e reduz a probabilidade de erros.